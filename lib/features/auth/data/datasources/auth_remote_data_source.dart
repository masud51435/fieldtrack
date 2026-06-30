import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../../../../core/storage/auth_data.dart';
import '../auth_api_constants.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<LoginResponseModel> register(Map<String, dynamic> data);
  Future<AuthData> refreshToken(String refreshToken);
  Future<void> logout();
  Future<Map<String, dynamic>> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    return await client.request(
      path: AuthApiConstants.login,
      method: MethodType.post,
      payload: request.toJson(),
      parse: (json) => LoginResponseModel.fromJson(json),
    );
  }

  @override
  Future<LoginResponseModel> register(Map<String, dynamic> data) async {
    return await client.request(
      path: AuthApiConstants.register,
      method: MethodType.post,
      payload: data,
      parse: (json) => LoginResponseModel.fromJson(json),
    );
  }

  @override
  Future<AuthData> refreshToken(String refreshToken) async {
    return await client.request(
      path: AuthApiConstants.refresh,
      method: MethodType.post,
      payload: {'refresh_token': refreshToken},
      parse: (json) => AuthData.fromJson(json),
    );
  }

  @override
  Future<void> logout() async {
    await client.request(
      path: AuthApiConstants.logout,
      method: MethodType.post,
    );
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    return await client.request(
      path: AuthApiConstants.me,
      method: MethodType.get,
    );
  }
}
