import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<SplashController>(SplashController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
  }
}
