import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_bottom_navbar/controller/bottom_navbar_controller.dart';
import '../../custom_bottom_navbar/view/custom_bottom_navbar.dart';
import '../../home/presentation/view/home_screen.dart';
import '../../location/presentation/view/location_screen.dart';
import '../../sync/view/sync_screen.dart';
import '../../user_profile/presentation/view/profile_screen.dart';

class DashboardScreen extends GetView<BottomNavController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const LocationScreen(),
      const SyncScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
