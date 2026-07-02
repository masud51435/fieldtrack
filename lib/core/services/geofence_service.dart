import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../core/usecases/usecase.dart';
import '../../features/location/domain/entities/location_entity.dart';
import '../../features/location/domain/usecases/get_all_location_usecases.dart';
import '../storage/auth_persist_data.dart';
import 'notification_service.dart';

class GeofenceService extends GetxService {
  final GetAllLocationUseCases getAllLocationUseCases;

  GeofenceService({required this.getAllLocationUseCases});

  StreamSubscription<Position>? _positionStream;
  final monitoredLocations = <LocationEntity>[].obs;
  final Set<String> _insideLocations = {};

  Future<GeofenceService> init() async {
    try {
      final authData = await Get.find<AuthPersistData>().getAuthData();
      if (authData.accessToken.isNotEmpty) {
        await updateMonitoredLocations();
      }
    } catch (_) {}

    return this;
  }

  Future<bool> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) return false;

    return true;
  }

  /// Public method to fetch locations and start monitoring (called after login)
  Future<void> updateMonitoredLocations() async {
    // Check permissions right before we need them
    final hasPermission = await _checkPermissions();
    if (!hasPermission) {
      debugPrint(
        "GeofenceService: Permission denied, cannot start monitoring.",
      );
      return;
    }

    try {
      final result = await getAllLocationUseCases(NoParams());
      monitoredLocations.assignAll(
        result.locations.where((l) => l.isActive).toList(),
      );

      if (monitoredLocations.isNotEmpty) {
        _startMonitoring();
      }
    } catch (e) {
      debugPrint("GeofenceService: Error fetching locations: $e");
    }
  }

  /// Stop monitoring and clear data (called on logout)
  void stopMonitoring() {
    _positionStream?.cancel();
    _positionStream = null;
    monitoredLocations.clear();
    _insideLocations.clear();
  }

  void _startMonitoring() async {
    _positionStream?.cancel();

    try {
      // Final check before hitting GPS
      final initialPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      _evaluateGeofences(initialPosition);
    } catch (e) {
      debugPrint("GeofenceService: Error getting initial position: $e");
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) {
            _evaluateGeofences(position);
          },
        );
  }

  void _evaluateGeofences(Position position) {
    if (monitoredLocations.isEmpty) return;

    for (var location in monitoredLocations) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        location.latitude,
        location.longitude,
      );

      bool isInside = distance <= location.radiusM;
      String locId = location.id;

      if (isInside && !_insideLocations.contains(locId)) {
        _insideLocations.add(locId);
        _triggerNotification(location);
      } else if (!isInside && _insideLocations.contains(locId)) {
        _insideLocations.remove(locId);
      }
    }
  }

  void _triggerNotification(LocationEntity location) {
    Get.find<NotificationService>().showNotification(
      id: location.id.hashCode,
      title: "Entered Geofence",
      body: "You have arrived at ${location.locationName}",
    );
  }

  @override
  void onClose() {
    _positionStream?.cancel();
    super.onClose();
  }
}
