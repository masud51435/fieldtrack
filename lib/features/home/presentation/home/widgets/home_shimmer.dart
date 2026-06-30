import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/app_shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            // Header Shimmer
            const ShimmerBox(height: 28, width: 120),
            SizedBox(height: 8.h),
            const ShimmerBox(height: 16, width: 150),

            SizedBox(height: 16.h),
            // Progress Card Shimmer
            const ShimmerBox(height: 100, borderRadius: 20),

            SizedBox(height: 24.h),
            // Filter Chips Shimmer
            Row(
              children: [
                const ShimmerBox(height: 36, width: 60, borderRadius: 25),
                SizedBox(width: 12.w),
                const ShimmerBox(height: 36, width: 80, borderRadius: 25),
                SizedBox(width: 12.w),
                const ShimmerBox(height: 36, width: 90, borderRadius: 25),
              ],
            ),

            SizedBox(height: 24.h),
            // Task List Shimmer
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: const ShimmerBox(height: 120, borderRadius: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
