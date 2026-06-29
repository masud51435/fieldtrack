import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/home_entity.dart';
import '../../../domain/usecases/get_home_data_usecase.dart';

class HomeController extends GetxController {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeController({required this.getHomeDataUseCase});

  // State
  final isLoading = false.obs;
  final banners = <BannerEntity>[].obs;
  final coupon = Rxn<CouponEntity>();
  final trendingCategories = <CategoryEntity>[].obs;
  final popularBrands = <BrandEntity>[].obs;
  final providers = <ProviderEntity>[].obs;
  final flashSaleProducts = <ProductEntity>[].obs;
  final trendingProducts = <ProductEntity>[].obs;
  final bestSellingProducts = <ProductEntity>[].obs;
  final latestProducts = <ProductEntity>[].obs;
  final flashSaleMeta = Rxn<FlashSaleMetaEntity>();

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoading.value = true;
    try {
      final homeData = await getHomeDataUseCase(NoParams());

      banners.assignAll(homeData.banners);
      coupon.value = homeData.coupon;
      trendingCategories.assignAll(homeData.trendingCategories);
      popularBrands.assignAll(homeData.popularBrands);
      providers.assignAll(homeData.providers);

      flashSaleProducts.assignAll(homeData.products.flashSaleProducts);
      trendingProducts.assignAll(homeData.products.trendingProducts);
      bestSellingProducts.assignAll(homeData.products.bestSellingProducts);
      latestProducts.assignAll(homeData.products.latestProducts);

      flashSaleMeta.value = homeData.flashSaleMeta;
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Home Load Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await loadHomeData();
  }
}
