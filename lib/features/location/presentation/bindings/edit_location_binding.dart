import 'package:get/get.dart';
import '../controller/edit_location_controller.dart';
import '../../domain/usecases/update_location_usecase.dart';
import '../../domain/usecases/delete_location_usecase.dart';

class EditLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateLocationUseCase(Get.find()));
    Get.lazyPut(() => DeleteLocationUseCase(Get.find()));
    Get.lazyPut(
      () => EditLocationController(
        updateLocationUseCase: Get.find(),
        deleteLocationUseCase: Get.find(),
      ),
    );
  }
}
