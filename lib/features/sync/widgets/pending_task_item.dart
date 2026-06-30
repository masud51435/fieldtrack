import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers/formatter.dart';

class PendingTaskItem extends StatelessWidget {
  final Map<String, dynamic> change;

  const PendingTaskItem({super.key, required this.change});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              change['is_completed']
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              size: 20.sp,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  change['title'] ?? 'Unknown Task',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimaryLight,
                  ),
                ),
                Text(
                  "Marked ${change['is_completed'] ? 'done' : 'pending'} - ${AppFormatter.formatTime(change['updated_at'])}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'Pending',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
