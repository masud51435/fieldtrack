import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../models/add_new_location_request_model.dart';
import '../models/all_locations_response_model.dart';

abstract class LocationRemoteDataSource {
  Future<AllLocationsResponseModel> getAllLocations();
  Future<Location> addNewLocation(AddNewLocationRequestModel request);
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final ApiClient client;
  LocationRemoteDataSourceImpl({required this.client});

  @override
  Future<AllLocationsResponseModel> getAllLocations() async {
    return await client.request(
      path: "/locations",
      method: MethodType.get,
      parse: (json) => AllLocationsResponseModel.fromJson(json),
    );
  }

  @override
  Future<Location> addNewLocation(AddNewLocationRequestModel request) async {
    return await client.request(
      path: "/locations",
      method: MethodType.post,
      payload: request.toJson(),
      parse: (json) => Location.fromJson(json),
    );
  }
}
