import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/validators/app_validators.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../controllers/signup_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                // Logo section
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.primaryDark
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                        ],
                      ),
                      child: Icon(
                        Icons.location_on,
                        size: 30.sp,
                        color: isDark ? AppColors.fieldBgDark : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                SizedBox(height: 20.h),

                // Title Text
                Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Join your team on FieldTrack',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 40.h),

                // Full Name Field
                AppTextField(
                  controller: controller.nameController,
                  label: 'Full name',
                  hintText: 'John Doe',
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  validator: (value) =>
                      AppValidators.validateEmptyText(value, 'Full name'),
                ),
                SizedBox(height: 20.h),

                // Email Field
                AppTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hintText: 'john.doe@example.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  validator: AppValidators.validateEmail,
                ),
                SizedBox(height: 20.h),

                // Password Field
                Obx(
                  () => AppTextField(
                    controller: controller.passwordController,
                    label: 'Password',
                    hintText: 'Create a password',
                    obscureText: !controller.isPasswordVisible.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: AppValidators.validatePassword,
                  ),
                ),
                SizedBox(height: 30.h),

                // Create Account Button
                Obx(
                  () => AppButton(
                    text: 'Create account',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.register,
                  ),
                ),
                SizedBox(height: 20.h),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: controller.goToLogin,
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
