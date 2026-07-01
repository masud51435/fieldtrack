import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers/formatter.dart';
import '../../domain/entities/home_entity.dart';
import '../controller/home_controller.dart';

class TaskCard extends StatelessWidget {
  final TodoEntity todo;

  const TaskCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Checkbox
          GestureDetector(
            onTap: () => controller.toggleTodo(todo),
            child: Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                color: todo.isCompleted
                    ? AppColors.success
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(7.r),
                border: Border.all(
                  color: todo.isCompleted
                      ? AppColors.success
                      : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: 2,
                ),
              ),
              child: todo.isCompleted
                  ? Icon(Icons.check, size: 18.sp, color: Colors.white)
                  : null,
            ),
          ),
          SizedBox(width: 16.w),

          // Task Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: isDark
                        ? (todo.isCompleted ? Colors.white38 : Colors.white)
                        : (todo.isCompleted
                              ? Colors.black38
                              : AppColors.textPrimaryLight),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  todo.description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: isDark ? Colors.white38 : Colors.black38,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      todo.isCompleted
                          ? "Done ${AppFormatter.formatTime(todo.updatedAt)}"
                          : "Due ${AppFormatter.formatTime(todo.dueAt)}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isDark ? Colors.white38 : Colors.black38,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: todo.isCompleted
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        todo.isCompleted ? 'Completed' : 'Pending',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: todo.isCompleted
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
