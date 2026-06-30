import 'package:get/get.dart';

import '../../../domain/usecases/register_usecase.dart';
import '../controllers/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterUseCase(Get.find()));
    Get.lazyPut(() => SignUpController(registerUseCase: Get.find()));
  }
}
