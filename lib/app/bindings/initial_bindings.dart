import 'package:get/get.dart';

import '../../core/network/api_client.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/links.dart';
import '../../core/services/geofence_service.dart';
import '../../core/services/sync_service.dart';
import '../../core/services/theme_service.dart';
import '../../core/storage/auth_persist_data.dart';
import '../../core/storage/local_storage.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/sync_todos_usecase.dart';
import '../../features/home/domain/usecases/update_todo_usecase.dart';
import '../../features/location/data/datasources/location_remote_data_source.dart';
import '../../features/location/data/repository/location_repository_impl.dart';
import '../../features/location/domain/repositories/location_repository.dart';
import '../../features/location/domain/usecases/get_all_location_usecases.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // 1. Core Services
    Get.lazyPut(() => ThemeService(Get.find<LocalStorage>()), fenix: true);
    Get.lazyPut(() => AuthPersistData(), fenix: true);

    // 2. Api Clients
    Get.lazyPut<ApiClient>(
      () => DioClient(baseUrl: Links.baseUrl, tag: 'Public API'),
      tag: 'public',
      fenix: true,
    );

    Get.lazyPut<ApiClient>(
      () => DioClient(
        baseUrl: Links.baseUrl,
        tag: 'Secure API',
        tokenProvider: () async {
          try {
            final authData = await Get.find<AuthPersistData>().getAuthData();
            return authData.accessToken;
          } catch (_) {
            return null;
          }
        },
        onRefreshToken: () async {
          try {
            final authPersistData = Get.find<AuthPersistData>();
            final authData = await authPersistData.getAuthData();
            final remoteDataSource = Get.find<AuthRemoteDataSource>();

            final newAuthData = await remoteDataSource.refreshToken(
              authData.refreshToken,
            );

            await authPersistData.setAuthData(newAuthData);
            return true;
          } catch (e) {
            return false;
          }
        },
      ),
      tag: 'secure',
      fenix: true,
    );

    // 3. Shared Auth Dependencies
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        publicClient: Get.find<ApiClient>(tag: 'public'),
        secureClient: Get.find<ApiClient>(tag: 'secure'),
      ),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find(),
        authPersistData: Get.find(),
      ),
      fenix: true,
    );

    // 4. Global Home/Sync Dependencies
    Get.lazyPut<HomeRemoteDataSource>(
      () =>
          HomeRemoteDataSourceImpl(client: Get.find<ApiClient>(tag: 'secure')),
      fenix: true,
    );
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => SyncTodosUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => UpdateTodoUseCase(Get.find()), fenix: true);

    Get.putAsync(
      () => SyncService(
        syncTodosUseCase: Get.find(),
        updateTodoUseCase: Get.find(),
      ).init(),
      permanent: true,
    );

    // 5. Location & Geofence Dependencies
    Get.lazyPut<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl(client: Get.find(tag: 'secure')),
      fenix: true,
    );
    Get.lazyPut<LocationRepository>(
      () => LocationRepositoryImpl(remoteDataSource: Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => GetAllLocationUseCases(Get.find()), fenix: true);

    Get.putAsync(
      () => GeofenceService(getAllLocationUseCases: Get.find()).init(),
      permanent: true,
    );
  }
}
