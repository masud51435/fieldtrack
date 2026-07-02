import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../core/services/sync_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import '../../domain/usecases/update_todo_usecase.dart';

class HomeController extends GetxController {
  final GetHomeDataUseCase getHomeDataUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final _syncService = Get.find<SyncService>();

  HomeController({
    required this.getHomeDataUseCase,
    required this.updateTodoUseCase,
  });

  // State
  final isLoading = false.obs;
  final processingIds = <String>{}.obs;
  final allTodos = <TodoEntity>[].obs;
  final filteredTodos = <TodoEntity>[].obs;
  final selectedFilter = 'All'.obs;

  // Progress calculations
  int get completedCount => allTodos.where((t) => t.isCompleted).length;
  int get totalCount => allTodos.length;
  double get progressPercentage =>
      totalCount == 0 ? 0 : completedCount / totalCount;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();

    // Automatically refresh data when a sync completes in the background
    ever(_syncService.lastSyncTime, (_) => loadHomeData(silent: true));
  }

  Future<void> loadHomeData({bool silent = false}) async {
    if (!silent) isLoading.value = true;
    try {
      final homeData = await getHomeDataUseCase(NoParams());
      allTodos.assignAll(homeData.todos);
      _applyFilter();
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Home Load Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleTodo(TodoEntity todo) async {
    if (processingIds.contains(todo.id)) return;

    final oldStatus = todo.isCompleted;
    final newStatus = !oldStatus;
    final updatedAt = DateTime.now().toUtc().toIso8601String();

    processingIds.add(todo.id);

    // 1. Optimistic UI Update
    final index = allTodos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      allTodos[index] = TodoEntity(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: newStatus,
        dueAt: todo.dueAt,
        createdAt: todo.createdAt,
        updatedAt: updatedAt,
      );
      _applyFilter();
    }

    try {
      // 2. Process update (Try PATCH if online, otherwise save to Queue)
      await _syncService.processUpdate(
        todo.id,
        newStatus,
        todo.title,
        updatedAt,
      );
    } finally {
      processingIds.remove(todo.id);
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    _applyFilter();
  }

  void _applyFilter() {
    if (selectedFilter.value == 'All') {
      filteredTodos.assignAll(allTodos);
    } else if (selectedFilter.value == 'Pending') {
      filteredTodos.assignAll(allTodos.where((t) => !t.isCompleted));
    } else if (selectedFilter.value == 'Completed') {
      filteredTodos.assignAll(allTodos.where((t) => t.isCompleted));
    }
  }

  Future<void> refreshData() async {
    await loadHomeData();
  }
}
