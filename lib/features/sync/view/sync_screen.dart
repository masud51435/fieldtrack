import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/services/sync_service.dart';
import '../../../core/widgets/app_button.dart';
import '../widgets/offline_banner.dart';
import '../widgets/pending_task_item.dart';
import '../widgets/sync_summary_card.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final syncService = Get.find<SyncService>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 16.h),
              child: Text(
                'Sync',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.textPrimaryLight,
                ),
              ),
            ),

            // Offline Banner
            const OfflineBanner(),

            // Pending Summary Card
            const SyncSummaryCard(),

            // Waiting List Label
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Text(
                'WAITING TO UPLOAD',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
            ),

            // List of Pending Items
            Expanded(
              child: Obx(
                () => syncService.pendingChanges.isEmpty
                    ? Center(
                        child: Text(
                          "All changes are synced",
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemCount: syncService.pendingChanges.length,
                        itemBuilder: (context, index) {
                          final change = syncService.pendingChanges[index];
                          return PendingTaskItem(change: change);
                        },
                      ),
              ),
            ),

            // Sync Now Button
            Obx(
              () => syncService.pendingChanges.isEmpty
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.all(24.r),
                      child: AppButton(
                        text: 'Sync now',
                        iconData: Icons.sync,
                        onPressed: () => syncService.syncNow(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
