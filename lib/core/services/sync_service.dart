import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fieldtrack/core/errors/failures.dart';
import 'package:fieldtrack/core/storage/auth_persist_data.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_ce/hive.dart';

import '../../features/home/domain/usecases/sync_todos_usecase.dart';
import '../../features/home/domain/usecases/update_todo_usecase.dart';

class SyncService extends GetxService {
  final SyncTodosUseCase syncTodosUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  late Box _syncBox;
  late Box _metaBox;
  final _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  // Reactive state for UI
  final pendingChanges = <Map<String, dynamic>>[].obs;
  final isOffline = false.obs;
  final lastSyncTime = Rxn<DateTime>();

  SyncService({
    required this.syncTodosUseCase,
    required this.updateTodoUseCase,
  });

  Future<SyncService> init() async {
    _syncBox = await Hive.openBox('pending_sync');
    _metaBox = await Hive.openBox('sync_metadata');
    _updatePendingList();

    // Load last sync time from metadata box
    final storedTime = _metaBox.get('last_sync_timestamp');
    if (storedTime != null) {
      lastSyncTime.value = DateTime.parse(storedTime);
    }

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
      _syncBox.values
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
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
    String updatedAt,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();

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
      _updateLastSyncTime();
    } catch (e) {
      if (e is ConflictFailure) {
        // CONFLICT: Local data is out of sync with server.
        // Don't queue, instead trigger a refresh to get the latest state.
        debugPrint("Sync conflict detected for $todoId. Refreshing...");
        _updateLastSyncTime();
        return;
      }

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

    // Check Auth: Don't sync if logged out
    final authData = await Get.find<AuthPersistData>().getAuthData();
    if (authData.accessToken.isEmpty) return;

    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) return;

    try {
      final changes = _syncBox.values.whereType<Map>().map((e) {
        final map = Map<String, dynamic>.from(e);
        return {
          'todo_id': map['todo_id'],
          'is_completed': map['is_completed'],
          'updated_at': map['updated_at'],
        };
      }).toList();

      final result = await syncTodosUseCase(changes);

      final failedItems = result['failed'] as List? ?? [];
      final syncedIds = result['synced_ids'] as List? ?? [];

      if (failedItems.isNotEmpty) {
        debugPrint("Bulk sync completed with ${failedItems.length} conflicts.");
        // If there are conflicts, we clear the queue and refresh to stay in sync with server
        await _syncBox.clear();
      } else {
        await _syncBox.clear();
        debugPrint("Bulk sync successful: ${syncedIds.length} items");
      }

      _updatePendingList();
      _updateLastSyncTime();
    } catch (e) {
      if (e is ConflictFailure) {
        debugPrint("Bulk sync conflict! Clearing queue to prevent loop.");
        await _syncBox.clear();
        _updatePendingList();
        _updateLastSyncTime();
      }
      debugPrint("Bulk sync failed: $e");
    }
  }

  void _updateLastSyncTime() {
    final now = DateTime.now();
    lastSyncTime.value = now;
    _metaBox.put('last_sync_timestamp', now.toIso8601String());
  }

  /// Clear all pending changes and metadata (usually on logout)
  Future<void> clearQueue() async {
    await _syncBox.clear();
    await _metaBox.clear();
    lastSyncTime.value = null;
    _updatePendingList();
  }

  int get pendingCount => pendingChanges.length;
}
