import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_data_source.dart';
import '../models/add_new_location_request_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource remoteDataSource;

  LocationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AllLocationsEntity> getLocation() async {
    final response = await remoteDataSource.getAllLocations();
    return response.toEntity();
  }

  @override
  Future<LocationEntity> addNewLocation(
    AddNewLocationRequestModel request,
  ) async {
    final response = await remoteDataSource.addNewLocation(request);
    return response.toEntity();
  }

  @override
  Future<LocationEntity> updateLocation(
    String id,
    AddNewLocationRequestModel request,
  ) async {
    final response = await remoteDataSource.updateLocation(id, request);
    return response.toEntity();
  }

  @override
  Future<void> deleteLocation(String id) async {
    await remoteDataSource.deleteLocation(id);
  }
}
