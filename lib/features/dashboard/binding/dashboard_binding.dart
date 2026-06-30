import 'package:get/get.dart';

import '../../../core/network/api_client.dart';
import '../../custom_bottom_navbar/controller/bottom_navbar_controller.dart';
import '../../home/data/datasources/home_remote_data_source.dart';
import '../../home/data/repositories/home_repository_impl.dart';
import '../../home/domain/repositories/home_repository.dart';
import '../../home/domain/usecases/get_home_data_usecase.dart';
import '../../home/presentation/home/controller/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController());

    // Home Dependencies (needed for HomeScreen inside Dashboard)
    Get.lazyPut<HomeRemoteDataSource>(
      () =>
          HomeRemoteDataSourceImpl(client: Get.find<ApiClient>(tag: 'public')),
    );
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: Get.find()),
    );
    Get.lazyPut(() => GetHomeDataUseCase(Get.find()));
    Get.lazyPut(() => HomeController(getHomeDataUseCase: Get.find()));
  }
}
