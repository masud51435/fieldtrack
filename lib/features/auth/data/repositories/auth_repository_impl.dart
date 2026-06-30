import '../../../../core/storage/auth_data.dart';
import '../../../../core/storage/auth_persist_data.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthPersistData authPersistData;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.authPersistData,
  });

  // login method
  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final response = await remoteDataSource.login(
      LoginRequestModel(email: email, password: password),
    );

    final userEntity = response.toEntity(email);

    // Save tokens locally
    await authPersistData.setAuthData(
      AuthData(
        accessToken: userEntity.accessToken,
        refreshToken: userEntity.refreshToken,
      ),
    );

    return userEntity;
  }

  // register method
  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await remoteDataSource.register({
      'email': email,
      'password': password,
      'full_name': fullName,
    });

    final userEntity = response.toEntity(email);

    // Save tokens locally
    await authPersistData.setAuthData(
      AuthData(
        accessToken: userEntity.accessToken,
        refreshToken: userEntity.refreshToken,
      ),
    );

    return userEntity;
  }

  // refresh token method
  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await authPersistData.deleteAuthData();
  }

  // get current user method
  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }
}
