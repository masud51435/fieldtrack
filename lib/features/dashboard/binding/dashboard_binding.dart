import 'package:get/get.dart';

import '../../custom_bottom_navbar/controller/bottom_navbar_controller.dart';
import '../../home/domain/usecases/get_home_data_usecase.dart';
import '../../home/domain/usecases/update_todo_usecase.dart';
import '../../home/presentation/home/controller/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());

    // Home Dependencies
    Get.lazyPut(() => GetHomeDataUseCase(Get.find()));
    Get.lazyPut(() => UpdateTodoUseCase(Get.find()));
    Get.lazyPut(
      () => HomeController(
        getHomeDataUseCase: Get.find(),
        updateTodoUseCase: Get.find(),
      ),
    );
  }
}
