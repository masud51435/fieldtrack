import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/theme_service.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_stat_card.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.profile.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.profile.value;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
                SizedBox(height: 24.h),

                // Profile Header Card
                ProfileHeader(
                  initials: controller.initials,
                  name: user?.name ?? 'User Name',
                  email: user?.email ?? 'user@example.com',
                  role: user?.role ?? 'Field User',
                ),
                SizedBox(height: 24.h),

                // Stats Row
                Row(
                  children: [
                    ProfileStatCard(
                      value:
                          "${controller.completedTasks}/${controller.totalTasks}",
                      label: "Tasks done today",
                    ),
                    SizedBox(width: 16.w),
                    const ProfileStatCard(
                      value: "3", // Placeholder for locations
                      label: "Active locations",
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Menu Items
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: isDark
                          ? AppColors.borderDark.withValues(alpha: 0.5)
                          : AppColors.borderLight,
                      width: 1,
                    ),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                    ],
                  ),
                  child: Material(
                    color: isDark
                        ? AppColors.surfaceDark
                        : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(24.r),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Column(
                        children: [
                          ProfileMenuItem(
                            icon: Icons.dark_mode_outlined,
                            title: "Dark Mode",
                            onTap: () => Get.find<ThemeService>().switchTheme(),
                            trailing: Transform.scale(
                              scale: 0.85,
                              child: Switch.adaptive(
                                value: isDark,
                                activeTrackColor: AppColors.primary,
                                inactiveTrackColor: isDark
                                    ? Colors.white.withValues(alpha: 0.05)
                                    : Colors.black.withValues(alpha: 0.05),
                                inactiveThumbColor: isDark
                                    ? Colors.white.withValues(alpha: 0.4)
                                    : Colors.white,
                                trackOutlineColor: WidgetStatePropertyAll(
                                  isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight,
                                ),
                                onChanged: (value) =>
                                    Get.find<ThemeService>().switchTheme(),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: isDark
                                ? AppColors.borderDark.withValues(alpha: 0.5)
                                : AppColors.borderLight,
                          ),
                          ProfileMenuItem(
                            icon: Icons.person_outline,
                            title: "Edit profile",
                            onTap: () {},
                          ),
                          Divider(
                            height: 1,
                            color: isDark
                                ? AppColors.borderDark.withValues(alpha: 0.5)
                                : AppColors.borderLight,
                          ),
                          ProfileMenuItem(
                            icon: Icons.notifications_none,
                            title: "Notifications",
                            onTap: () {},
                          ),
                          Divider(
                            height: 1,
                            color: isDark
                                ? AppColors.borderDark.withValues(alpha: 0.5)
                                : AppColors.borderLight,
                          ),
                          ProfileMenuItem(
                            icon: Icons.settings_outlined,
                            title: "Settings",
                            onTap: () {},
                          ),
                          Divider(
                            height: 1,
                            color: isDark
                                ? AppColors.borderDark.withValues(alpha: 0.5)
                                : AppColors.borderLight,
                          ),
                          ProfileMenuItem(
                            icon: Icons.help_outline,
                            title: "Help & support",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),

                // Sign out button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: controller.logout,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      side: BorderSide(
                        color: AppColors.error.withValues(alpha: 0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: AppColors.error, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Sign out',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          );
        }),
      ),
    );
  }
}
