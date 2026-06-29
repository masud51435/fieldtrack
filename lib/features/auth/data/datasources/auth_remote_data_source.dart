import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../auth_api_constants.dart';
import '../models/base_auth_response_model.dart';
import '../models/forgot_password_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<ForgotPasswordResponseModel> forgotPassword(String email);
  Future<BaseAuthResponseModel> sendRegistrationOtp(
    String phoneNumber,
    String dialCode,
  );
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
  Future<ForgotPasswordResponseModel> forgotPassword(String email) async {
    return await client.request(
      path: AuthApiConstants.forgotPassword,
      method: MethodType.post,
      payload: {'email': email},
      parse: (json) => ForgotPasswordResponseModel.fromJson(json),
    );
  }

  @override
  Future<BaseAuthResponseModel> sendRegistrationOtp(
    String phoneNumber,
    String dialCode,
  ) async {
    return await client.request(
      path: AuthApiConstants.registerOtpSend,
      method: MethodType.post,
      payload: {'phone': phoneNumber, 'phone_code': dialCode},
      parse: (json) => BaseAuthResponseModel.fromJson(json),
    );
  }
}
