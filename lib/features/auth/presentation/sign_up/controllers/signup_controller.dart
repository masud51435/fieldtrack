import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/routes.dart';
import '../../../../../core/utils/device/device_utility.dart';
import '../../../domain/usecases/register_usecase.dart';

class SignUpController extends GetxController {
  final RegisterUseCase registerUseCase;
  SignUpController({required this.registerUseCase});

  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // State
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void goToLogin() => Get.back();

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    DeviceUtility.hideKeyboard();
    isLoading.value = true;

    try {
      await registerUseCase(
        RegisterParams(
          fullName: nameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );

      // Navigate to Dashboard
      Get.offAllNamed(BaseRoute.dashboard);
    } catch (e, stackTrace) {
      // Errors are handled by ApiErrorHandler + ToastService automatically
      debugPrint("Register Error: $e$stackTrace");
    } finally {
      isLoading.value = false;
    }
  }
}
