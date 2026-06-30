import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_bottom_navbar/controller/bottom_navbar_controller.dart';
import '../../custom_bottom_navbar/view/custom_bottom_navbar.dart';
import '../../home/presentation/home/view/home_screen.dart';

class DashboardScreen extends GetView<BottomNavController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(), // This will be "Tasks"
      const Center(child: Text("Locations")),
      const Center(child: Text("Sync")),
      const Center(child: Text("Profile")),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
