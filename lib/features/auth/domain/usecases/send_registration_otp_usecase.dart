import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class RegistrationOtpParams {
  final String phoneNumber;
  final String dialCode;

  RegistrationOtpParams({required this.phoneNumber, required this.dialCode});
}

class SendRegistrationOtpUseCase
    implements UseCase<String, RegistrationOtpParams> {
  final AuthRepository repository;

  SendRegistrationOtpUseCase(this.repository);

  @override
  Future<String> call(RegistrationOtpParams params) async {
    return await repository.sendRegistrationOtp(
      phoneNumber: params.phoneNumber,
      dialCode: params.dialCode,
    );
  }
}
