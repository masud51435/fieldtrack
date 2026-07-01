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
  List<LocationEntity> _monitoredLocations = [];
  final Set<String> _insideLocations = {};

  Future<GeofenceService> init() async {
    await _checkPermissions();

    // Only fetch if we are already logged in (app restart case)
    final authData = await Get.find<AuthPersistData>().getAuthData();
    if (authData.accessToken.isNotEmpty) {
      await updateMonitoredLocations();
      _startMonitoring();
    }

    return this;
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;
  }

  /// Public method to fetch locations and start monitoring (called after login)
  Future<void> updateMonitoredLocations() async {
    try {
      final result = await getAllLocationUseCases(NoParams());
      _monitoredLocations = result.locations.where((l) => l.isActive).toList();

      // If we have locations and stream isn't running, start it
      if (_monitoredLocations.isNotEmpty && _positionStream == null) {
        _startMonitoring();
      }
    } catch (e) {
      if (kDebugMode) {
        print("GeofenceService: Error fetching locations: $e");
      }
    }
  }

  /// Stop monitoring and clear data (called on logout)
  void stopMonitoring() {
    _positionStream?.cancel();
    _positionStream = null;
    _monitoredLocations.clear();
    _insideLocations.clear();
  }

  void _startMonitoring() {
    _positionStream?.cancel();

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
    if (_monitoredLocations.isEmpty) return;

    for (var location in _monitoredLocations) {
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
