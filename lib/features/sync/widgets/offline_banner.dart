import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/services/sync_service.dart';

class OfflineBanner extends GetView<SyncService> {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isOffline.value
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.wifi_off, color: AppColors.warning, size: 20.sp),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You're offline",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.warning,
                          ),
                        ),
                        Text(
                          "Changes are saved on this device",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.warning.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
