import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

import '../../features/home/domain/usecases/sync_todos_usecase.dart';
import '../../features/home/domain/usecases/update_todo_usecase.dart';

class SyncService extends GetxService {
  final SyncTodosUseCase syncTodosUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  late Box _syncBox;
  final _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  // Reactive state for UI
  final pendingChanges = <Map<String, dynamic>>[].obs;
  final isOffline = false.obs;

  SyncService({
    required this.syncTodosUseCase,
    required this.updateTodoUseCase,
  });

  Future<SyncService> init() async {
    _syncBox = await Hive.openBox('pending_sync');
    _updatePendingList();

    // Monitor connectivity
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) {
      final wasOffline = isOffline.value;
      isOffline.value = result.contains(ConnectivityResult.none);

      // If we just came back online, sync everything in the queue
      if (wasOffline && !isOffline.value) {
        syncNow();
      }
    });

    // Initial check
    final current = await _connectivity.checkConnectivity();
    isOffline.value = current.contains(ConnectivityResult.none);

    return this;
  }

  void _updatePendingList() {
    pendingChanges.assignAll(
      _syncBox.values.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }

  /// Primary method called by UI to update a todo
  Future<void> processUpdate(
    String todoId,
    bool isCompleted,
    String title,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    final updatedAt = DateTime.now().toUtc().toIso8601String();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      // OFFLINE: Save to local storage for later sync
      await _addToQueue(todoId, isCompleted, title, updatedAt);
      return;
    }

    try {
      // ONLINE: Try individual update API first
      await updateTodoUseCase(
        UpdateTodoParams(
          id: todoId,
          isCompleted: isCompleted,
          updatedAt: updatedAt,
        ),
      );

      // If this item was previously in the queue, remove it since it's now synced
      if (_syncBox.containsKey(todoId)) {
        await _syncBox.delete(todoId);
        _updatePendingList();
      }
    } catch (e) {
      // API FAILED (Timeout, Server Error, etc.): Save to queue
      debugPrint("Individual update failed, adding to sync queue: $e");
      await _addToQueue(todoId, isCompleted, title, updatedAt);
    }
  }

  Future<void> _addToQueue(
    String todoId,
    bool isCompleted,
    String title,
    String updatedAt,
  ) async {
    final change = {
      'todo_id': todoId,
      'is_completed': isCompleted,
      'title': title,
      'updated_at': updatedAt,
    };

    await _syncBox.put(todoId, change);
    _updatePendingList();
  }

  /// Bulk sync for everything in the queue (POST /api/v1/todos/sync)
  Future<void> syncNow() async {
    if (_syncBox.isEmpty) return;

    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) return;

    try {
      final changes = _syncBox.values.map((e) {
        final map = Map<String, dynamic>.from(e);
        return {
          'todo_id': map['todo_id'],
          'is_completed': map['is_completed'],
          'updated_at': map['updated_at'],
        };
      }).toList();

      await syncTodosUseCase(changes);
      await _syncBox.clear();
      _updatePendingList();
      debugPrint("Bulk sync successful: ${changes.length} items");
    } catch (e) {
      debugPrint("Bulk sync failed: $e");
    }
  }

  int get pendingCount => pendingChanges.length;
}
