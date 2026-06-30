import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../controller/home_controller.dart';

class TaskFilterChip extends GetView<HomeController> {
  final String label;

  const TaskFilterChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final isSelected = controller.selectedFilter.value == label;

      return GestureDetector(
        onTap: () => controller.setFilter(label),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.surfaceDark : Colors.white),
            borderRadius: BorderRadius.circular(25.r),
            border: isSelected
                ? null
                : Border.all(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                  ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? Colors.white
                  : (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
            ),
          ),
        ),
      );
    });
  }
}
