import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/services/sync_service.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final syncService = Get.find<SyncService>();

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My tasks',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                DateFormat('EEEE, MMM d').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),

          // Sync Status Indicator
          Obx(() {
            final isOffline = syncService.isOffline.value;
            final pendingCount = syncService.pendingCount;

            IconData icon;
            Color color;
            String tooltip;

            if (isOffline) {
              icon = Icons.cloud_off;
              color = AppColors.error;
              tooltip = "Offline";
            } else if (pendingCount > 0) {
              icon = Icons.cloud_upload;
              color = AppColors.warning;
              tooltip = "$pendingCount items pending sync";
            } else {
              icon = Icons.cloud_done;
              color = AppColors.success;
              tooltip = "All tasks synced";
            }

            return Tooltip(
              message: tooltip,
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Icon(icon, color: color, size: 22.sp),
                    if (pendingCount > 0 && !isOffline)
                      Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12.r,
                          minHeight: 12.r,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
