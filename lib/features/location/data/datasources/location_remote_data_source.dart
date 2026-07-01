import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../models/all_locations_response_model.dart';

abstract class LocationRemoteDataSource {
  Future<AllLocationsResponseModel> getAllLocations();
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
}
