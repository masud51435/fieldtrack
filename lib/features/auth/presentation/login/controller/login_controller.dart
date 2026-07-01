import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/routes.dart';
import '../../../../../core/services/geofence_service.dart';
import '../../../../../core/services/sync_service.dart';
import '../../../../../core/utils/device/device_utility.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController({required this.loginUseCase});

  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // State
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void goToForgotPassword() {}

  void goToRegister() => Get.toNamed(BaseRoute.signUp);

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    DeviceUtility.hideKeyboard();
    isLoading.value = true;

    try {
      await loginUseCase(
        LoginParams(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );

      // Initialize background services after login
      if (Get.isRegistered<GeofenceService>()) {
        Get.find<GeofenceService>().updateMonitoredLocations();
      }
      if (Get.isRegistered<SyncService>()) {
        Get.find<SyncService>().syncNow();
      }

      // Navigate to Dashboard
      Get.offAllNamed(BaseRoute.dashboard);
    } catch (e) {
      // Errors are handled by ApiErrorHandler + ToastService automatically
      debugPrint("Login Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
