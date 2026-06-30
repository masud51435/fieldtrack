import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/routes.dart';
import '../../../../../core/storage/auth_data.dart';
import '../../../../../core/storage/auth_persist_data.dart';
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
      final user = await loginUseCase(
        LoginParams(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );

      // Save tokens to persistence
      await Get.find<AuthPersistData>().setAuthData(
        AuthData(
          accessToken: user.accessToken,
          refreshToken: user.refreshToken,
        ),
      );

      // Navigate to Dashboard (Example)
      Get.offAllNamed(BaseRoute.dashboard);
    } catch (e) {
      // Errors are handled by ApiErrorHandler + ToastService automatically
      debugPrint("Login Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
