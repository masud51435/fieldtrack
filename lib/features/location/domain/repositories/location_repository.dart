import '../../data/models/add_new_location_request_model.dart';
import '../entities/location_entity.dart';

abstract class LocationRepository {
  Future<AllLocationsEntity> getLocation();
  Future<LocationEntity> addNewLocation(AddNewLocationRequestModel request);
  Future<LocationEntity> updateLocation(
    String id,
    AddNewLocationRequestModel request,
  );
  Future<void> deleteLocation(String id);
}
