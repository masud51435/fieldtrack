import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../controller/bottom_navbar_controller.dart';
import '../models/bottom_nav_item.dart';
import '../widgets/navbar_item.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  List<BottomNavItem> get items => [
    BottomNavItem(icon: Icons.list_alt_rounded, label: "Tasks"),
    BottomNavItem(icon: Icons.location_on_outlined, label: "Locations"),
    BottomNavItem(icon: Icons.sync, label: "Sync"),
    BottomNavItem(icon: Icons.person_outline, label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BottomNavController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      final index = controller.currentIndex.value;
      final count = items.length;

      return Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 0.5,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.0.r),
            child: Row(
              children: List.generate(
                count,
                (i) => Expanded(
                  child: NavItem(
                    item: items[i],
                    isSelected: index == i,
                    index: i,
                    count: count,
                    onTap: () => controller.changeIndex(i),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
