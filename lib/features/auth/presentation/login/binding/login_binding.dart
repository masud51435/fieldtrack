import 'package:get/get.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => LoginController(loginUseCase: Get.find()));
  }
}
