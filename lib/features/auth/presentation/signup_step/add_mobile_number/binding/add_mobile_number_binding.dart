import 'package:get/get.dart';

import '../../../../../../core/common/domain/usecases/get_countries_usecase.dart';
import '../../../../domain/usecases/send_registration_otp_usecase.dart';
import '../controller/add_mobile_number_controller.dart';

class AddMobileNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetCountriesUseCase(Get.find()));
    Get.lazyPut(() => SendRegistrationOtpUseCase(Get.find()));
    Get.lazyPut(
      () => AddMobileNumberController(
        getCountriesUseCase: Get.find(),
        sendRegistrationOtpUseCase: Get.find(),
      ),
    );
  }
}
