import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

class ToastService {
  static FToast? _fToast;

  static BuildContext? get _context => Get.context;

  static void _ensureInitialized() {
    if (_fToast == null && _context != null) {
      _fToast = FToast()..init(_context!);
    }
  }

  static void showSuccess(
    String message, {
    Color? bgColor,
    ToastGravity? gravity,
  }) {
    _showToast(
      message: message,
      icon: Icons.check_circle,
      bgColor: bgColor ?? AppColors.primary,
      gravity: gravity,
    );
  }

  static void showError(String message) {
    _showToast(message: message, icon: Icons.error, bgColor: AppColors.error);
  }

  static void _showToast({
    required String message,
    required IconData icon,
    required Color bgColor,
    ToastGravity? gravity,
  }) {
    _ensureInitialized();
    if (_fToast == null) return;

    final toast = Container(
      margin: .symmetric(horizontal: 10.w, vertical: 0),
      padding: .symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(color: bgColor, borderRadius: .circular(12.w)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.white, size: 22.sp),
          SizedBox(width: 10.w),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 15.sp,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );

    _fToast!.showToast(
      child: toast,
      gravity: gravity ?? ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
