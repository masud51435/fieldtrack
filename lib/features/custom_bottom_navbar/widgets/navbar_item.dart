import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../models/bottom_nav_item.dart';

class NavItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final int index;
  final int count;

  const NavItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.index,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color itemColor = isSelected
        ? (isDark ? AppColors.primaryDark : AppColors.primary)
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(item.icon, size: 26.sp, color: itemColor),
          SizedBox(height: 4.h),
          Text(
            item.label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: itemColor,
            ),
          ),
        ],
      ),
    );
  }
}
