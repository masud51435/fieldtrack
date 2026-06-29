import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});

  Future<String> forgotPassword({required String email});

  Future<String> sendRegistrationOtp({
    required String phoneNumber,
    required String dialCode,
  });
}
