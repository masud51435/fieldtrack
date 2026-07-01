import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<AllLocationsEntity> getLocation();
}
