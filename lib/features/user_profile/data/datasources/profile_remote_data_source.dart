import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../models/profile_response_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponseModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient client;
  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfileResponseModel> getProfile() async {
    return await client.request(
      path: "/me",
      method: MethodType.get,
      parse: (json) => ProfileResponseModel.fromJson(json),
    );
  }
}
