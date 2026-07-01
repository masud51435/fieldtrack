class AllLocationsEntity {
  final List<LocationEntity> locations;
  AllLocationsEntity({required this.locations});
}

class LocationEntity {
  final String locationName;
  final double latitude;
  final double longitude;
  final double radiusM;
  final bool isActive;
  final String id;

  LocationEntity({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.radiusM,
    required this.isActive,
    required this.id,
  });
}
