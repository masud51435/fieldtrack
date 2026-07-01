import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

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
            // Title Shimmer
            const ShimmerBox(height: 30, width: 100),
            SizedBox(height: 24.h),

            // Profile Header Card Shimmer
            const ShimmerBox(height: 220, borderRadius: 24),
            SizedBox(height: 24.h),

            // Stats Row Shimmer
            Row(
              children: [
                const Expanded(child: ShimmerBox(height: 80, borderRadius: 20)),
                SizedBox(width: 16.w),
                const Expanded(child: ShimmerBox(height: 80, borderRadius: 20)),
              ],
            ),
            SizedBox(height: 24.h),

            // Menu Items Container Shimmer
            const ShimmerBox(height: 300, borderRadius: 24),
            SizedBox(height: 32.h),

            // Sign out button Shimmer
            const ShimmerBox(height: 56, borderRadius: 12),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
