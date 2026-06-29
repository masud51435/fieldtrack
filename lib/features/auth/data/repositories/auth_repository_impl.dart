import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      LoginRequestModel(email: email, password: password),
    );

    return response.toEntity(email);
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    final response = await remoteDataSource.forgotPassword(email);
    return response.message ?? 'Success';
  }

  @override
  Future<String> sendRegistrationOtp({
    required String phoneNumber,
    required String dialCode,
  }) async {
    final response = await remoteDataSource.sendRegistrationOtp(
      phoneNumber,
      dialCode,
    );
    return response.message ?? 'Success';
  }
}
