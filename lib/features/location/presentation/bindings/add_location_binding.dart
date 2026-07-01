import 'package:get/get.dart';

import '../../domain/usecases/add_new_location_usecases.dart';
import '../controller/add_location_controller.dart';

class AddLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewLocationUseCases(Get.find()));
    Get.lazyPut(() => AddLocationController(addNewLocationUseCase: Get.find()));
  }
}
