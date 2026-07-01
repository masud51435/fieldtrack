import 'package:get/get.dart';

import '../../auth/domain/usecases/logout_usecase.dart';
import '../../custom_bottom_navbar/controller/bottom_navbar_controller.dart';
import '../../home/domain/usecases/get_home_data_usecase.dart';
import '../../home/domain/usecases/update_todo_usecase.dart';
import '../../home/presentation/controller/home_controller.dart';
import '../../user_profile/data/datasources/profile_remote_data_source.dart';
import '../../user_profile/data/repositories/profile_repository_impl.dart';
import '../../user_profile/domain/repositories/profile_repository.dart';
import '../../user_profile/domain/usecases/get_profile_use_cases.dart';
import '../../user_profile/presentation/controllers/profile_controller.dart';

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

    // Profile Dependencies
    Get.lazyPut<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(client: Get.find(tag: "secure")),
    );

    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: Get.find()),
    );

    Get.lazyPut(() => GetProfileUseCases(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(
      () => ProfileController(
        getProfileUseCases: Get.find(),
        logoutUseCase: Get.find(),
      ),
    );
  }
}
