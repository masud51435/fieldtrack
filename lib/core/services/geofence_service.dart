import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../core/usecases/usecase.dart';
import '../../features/location/domain/entities/location_entity.dart';
import '../../features/location/domain/usecases/get_all_location_usecases.dart';
import 'notification_service.dart';

class GeofenceService extends GetxService {
  final GetAllLocationUseCases getAllLocationUseCases;

  GeofenceService({required this.getAllLocationUseCases});

  StreamSubscription<Position>? _positionStream;
  List<LocationEntity> _monitoredLocations = [];
  final Set<String> _insideLocations = {};

  Future<GeofenceService> init() async {
    await _checkPermissions();
    await updateMonitoredLocations();
    _startMonitoring();
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

  Future<void> updateMonitoredLocations() async {
    try {
      final result = await getAllLocationUseCases(NoParams());
      _monitoredLocations = result.locations.where((l) => l.isActive).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching locations for geofencing: $e");
      }
    }
  }

  void _startMonitoring() {
    _positionStream?.cancel();

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) {
            _evaluateGeofences(position);
          },
        );
  }

  void _evaluateGeofences(Position position) {
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
        // Just entered
        _insideLocations.add(locId);
        _triggerNotification(location);
      } else if (!isInside && _insideLocations.contains(locId)) {
        // Just exited
        _insideLocations.remove(locId);
      }
    }
  }

  void _triggerNotification(LocationEntity location) {
    NotificationService.showNotification(
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
