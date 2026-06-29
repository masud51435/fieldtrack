import 'package:get/get.dart';

import '../../core/network/api_client.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/links.dart';
import '../../core/storage/auth_persist_data.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // 1. Core Services
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
            return authData.token;
          } catch (_) {
            return null;
          }
        },
      ),
      tag: 'secure',
      fenix: true,
    );

    // 3. Shared Auth Dependencies
    Get.lazyPut<AuthRemoteDataSource>(
      () =>
          AuthRemoteDataSourceImpl(client: Get.find<ApiClient>(tag: 'public')),
      fenix: true,
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: Get.find()),
      fenix: true,
    );
  }
}
