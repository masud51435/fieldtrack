import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../controller/home_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/home_shimmer.dart';
import '../widgets/progress_card.dart';
import '../widgets/task_card.dart';
import '../widgets/task_filter_chip.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value || controller.allTodos.isEmpty) {
            return const HomeShimmer();
          }

          return RefreshIndicator(
            onRefresh: controller.refreshData,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Header
                const SliverToBoxAdapter(child: HomeHeader()),

                // Progress Card
                const SliverToBoxAdapter(child: ProgressCard()),

                // Filters
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
                    child: Row(
                      children: [
                        const TaskFilterChip(label: 'All'),
                        SizedBox(width: 12.w),
                        const TaskFilterChip(label: 'Pending'),
                        SizedBox(width: 12.w),
                        const TaskFilterChip(label: 'Completed'),
                      ],
                    ),
                  ),
                ),

                // Task List
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  sliver: controller.filteredTodos.isEmpty
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 40.h),
                              child: Text(
                                'No tasks found',
                                style: TextStyle(
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final todo = controller.filteredTodos[index];
                            return TaskCard(todo: todo);
                          }, childCount: controller.filteredTodos.length),
                        ),
                ),

                // Bottom spacing for navbar
                SliverToBoxAdapter(child: SizedBox(height: 100.h)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
