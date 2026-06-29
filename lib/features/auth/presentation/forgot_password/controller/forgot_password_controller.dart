import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes/routes.dart';
import '../../../../../core/utils/device/device_utility.dart';
import '../../../../../core/utils/snackbar/toast_service.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordController({required this.forgotPasswordUseCase});

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) return;

    DeviceUtility.hideKeyboard();
    isLoading.value = true;

    try {
      final message = await forgotPasswordUseCase(emailController.text.trim());

      ToastService.showSuccess(message);

      // Navigate to OTP verification
      Get.toNamed(
        BaseRoute.verifyOtp,
        arguments: {'email': emailController.text.trim()},
      );
    } catch (e) {
      // Handled by global error handler
    } finally {
      isLoading.value = false;
    }
  }
}
