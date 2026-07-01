class AddNewLocationRequestModel {
  final String locationName;
  final double latitude;
  final double longitude;
  final double radiusM;
  final bool isActive;

  AddNewLocationRequestModel({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.radiusM,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
    "location_name": locationName,
    "latitude": latitude,
    "longitude": longitude,
    "radius_m": radiusM,
    "is_active": isActive,
  };
}
