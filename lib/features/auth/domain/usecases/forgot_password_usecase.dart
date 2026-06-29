import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase implements UseCase<String, String> {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<String> call(String email) async {
    return await repository.forgotPassword(email: email);
  }
}
