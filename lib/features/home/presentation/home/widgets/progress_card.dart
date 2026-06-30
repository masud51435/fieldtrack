import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../controller/home_controller.dart';

class ProgressCard extends GetView<HomeController> {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's progress",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
                Text(
                  "${controller.completedCount} of ${controller.totalCount} done",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: controller.progressPercentage,
                minHeight: 8.h,
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.05),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
