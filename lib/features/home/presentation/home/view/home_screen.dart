import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../controller/home_controller.dart';
import '../widgets/category_grid.dart';
import '../widgets/home_banner_slider.dart';
import '../widgets/product_section.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: CustomScrollView(
            slivers: [
              // Banner Slider
              SliverToBoxAdapter(
                child: HomeBannerSlider(banners: controller.banners),
              ),

              // Categories
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Trending Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CategoryGrid(categories: controller.trendingCategories),
              ),

              // Products Sections
              SliverToBoxAdapter(
                child: ProductSection(
                  title: 'Flash Sale',
                  products: controller.flashSaleProducts,
                ),
              ),

              SliverToBoxAdapter(
                child: ProductSection(
                  title: 'Trending Products',
                  products: controller.trendingProducts,
                ),
              ),

              // Bottom Spacing
              const SliverToBoxAdapter(child: SizedBox(height: 50)),
            ],
          ),
        );
      }),
    );
  }
}
