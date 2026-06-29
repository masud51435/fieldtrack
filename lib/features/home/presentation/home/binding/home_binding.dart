import 'package:get/get.dart';

import '../../../../../core/network/api_client.dart';
import '../../../data/datasources/home_remote_data_source.dart';
import '../../../data/repositories/home_repository_impl.dart';
import '../../../domain/repositories/home_repository.dart';
import '../../../domain/usecases/get_home_data_usecase.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
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
