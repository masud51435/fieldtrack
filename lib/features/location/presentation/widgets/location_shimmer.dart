import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_shimmer.dart';

class LocationShimmer extends StatelessWidget {
  const LocationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: List.generate(
            5,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: ShimmerBox(height: 120.h, borderRadius: 20.r),
            ),
          ),
        ),
      ),
    );
  }
}
