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
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient publicClient;
  final ApiClient secureClient;

  AuthRemoteDataSourceImpl({
    required this.publicClient,
    required this.secureClient,
  });

  // login method
  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    return await publicClient.request(
      path: AuthApiConstants.login,
      method: MethodType.post,
      payload: request.toJson(),
      parse: (json) => LoginResponseModel.fromJson(json),
    );
  }

  // register method
  @override
  Future<LoginResponseModel> register(Map<String, dynamic> data) async {
    return await publicClient.request(
      path: AuthApiConstants.register,
      method: MethodType.post,
      payload: data,
      parse: (json) => LoginResponseModel.fromJson(json),
    );
  }

  // refresh token method
  @override
  Future<AuthData> refreshToken(String refreshToken) async {
    return await publicClient.request(
      path: AuthApiConstants.refresh,
      method: MethodType.post,
      payload: {'refresh_token': refreshToken},
      parse: (json) => AuthData.fromJson(json),
    );
  }

  // logout method
  @override
  Future<void> logout() async {
    await secureClient.request(
      path: AuthApiConstants.logout,
      method: MethodType.post,
    );
  }
}
