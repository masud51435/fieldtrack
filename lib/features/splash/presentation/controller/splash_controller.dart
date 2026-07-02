import 'package:get/get.dart';

import '../../../../app/routes/routes.dart';
import '../../../../core/storage/auth_persist_data.dart';

class SplashController extends GetxController {
  final AuthPersistData _authPersistData = Get.find<AuthPersistData>();

  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final authData = await _authPersistData.getAuthData();

      if (authData.accessToken.isNotEmpty) {
        Get.offAllNamed(BaseRoute.dashboard);
      } else {
        Get.offAllNamed(BaseRoute.login);
      }
    } catch (_) {
      Get.offAllNamed(BaseRoute.login);
    }
  }
}
