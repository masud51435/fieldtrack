import 'package:get/get.dart';

import '../../../domain/usecases/forgot_password_usecase.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordUseCase(Get.find()));
    Get.lazyPut(
      () => ForgotPasswordController(forgotPasswordUseCase: Get.find()),
    );
  }
}
