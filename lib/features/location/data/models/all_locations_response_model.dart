import '../../domain/entities/location_entity.dart';

class AllLocationsResponseModel {
  List<Location>? data;

  AllLocationsResponseModel({this.data});

  factory AllLocationsResponseModel.fromJson(Map<String, dynamic> json) =>
      AllLocationsResponseModel(
        data: json["data"] == null
            ? []
            : List<Location>.from(
                json["data"]!.map((x) => Location.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };

  AllLocationsEntity toEntity() {
    final List<LocationEntity> locations = [];
    for (var location in data ?? []) {
      locations.add(
        LocationEntity(
          locationName: location.locationName,
          latitude: location.latitude,
          longitude: location.longitude,
          radiusM: location.radiusM,
          isActive: location.isActive,
          id: location.id,
        ),
      );
    }
    return AllLocationsEntity(locations: locations);
  }
}

class Location {
  String? locationName;
  double? latitude;
  double? longitude;
  double? radiusM;
  bool? isActive;
  String? id;

  Location({
    this.locationName,
    this.latitude,
    this.longitude,
    this.radiusM,
    this.isActive,
    this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationName: json["location_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    radiusM: json["radius_m"]?.toDouble(),
    isActive: json["is_active"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "location_name": locationName,
    "latitude": latitude,
    "longitude": longitude,
    "radius_m": radiusM,
    "is_active": isActive,
    "id": id,
  };
}
