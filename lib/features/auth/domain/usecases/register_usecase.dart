import 'package:fieldtrack/core/usecases/usecase.dart';
import 'package:fieldtrack/features/auth/domain/entities/user_entity.dart';
import 'package:fieldtrack/features/auth/domain/repositories/auth_repository.dart';

class RegisterParams {
  final String email;
  final String password;
  final String fullName;

  RegisterParams({
    required this.email,
    required this.password,
    required this.fullName,
  });
}

class RegisterUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<UserEntity> call(RegisterParams params) async {
    return repository.register(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );
  }
}
