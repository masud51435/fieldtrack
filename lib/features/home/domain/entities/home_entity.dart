class HomeEntity {
  final List<BannerEntity> banners;
  final CouponEntity? coupon;
  final List<CategoryEntity> trendingCategories;
  final List<BrandEntity> popularBrands;
  final List<ProviderEntity> providers;
  final HomeProductsEntity products;
  final FlashSaleMetaEntity flashSaleMeta;

  HomeEntity({
    required this.banners,
    this.coupon,
    required this.trendingCategories,
    required this.popularBrands,
    required this.providers,
    required this.products,
    required this.flashSaleMeta,
  });
}

class BannerEntity {
  final int id;
  final String name;
  final String image;
  final String slug;
  final int? categoryId;

  BannerEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
    this.categoryId,
  });
}

class CouponEntity {
  final int id;
  final String code;
  final String discountType;
  final String discountValue;
  final String expiresAt;

  CouponEntity({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.expiresAt,
  });
}

class CategoryEntity {
  final int id;
  final String name;
  final String slug;
  final String image;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });
}

class BrandEntity {
  final int id;
  final String name;
  final String slug;
  final String image;

  BrandEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });
}

class ProviderEntity {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String? websiteUrl;

  ProviderEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    this.websiteUrl,
  });
}

class HomeProductsEntity {
  final List<ProductEntity> flashSaleProducts;
  final List<ProductEntity> trendingProducts;
  final List<ProductEntity> bestSellingProducts;
  final List<ProductEntity> latestProducts;

  HomeProductsEntity({
    required this.flashSaleProducts,
    required this.trendingProducts,
    required this.bestSellingProducts,
    required this.latestProducts,
  });
}

class ProductEntity {
  final int id;
  final String productName;
  final String thumbnail;
  final String price;
  final dynamic finalPrice;
  final bool hasDiscount;
  final String discountText;
  final int quantity;
  final String type;
  final Map<String, List<ProductAttributeOptionEntity>> attributes;

  ProductEntity({
    required this.id,
    required this.productName,
    required this.thumbnail,
    required this.price,
    this.finalPrice,
    required this.hasDiscount,
    required this.discountText,
    required this.quantity,
    required this.type,
    required this.attributes,
  });
}

class ProductAttributeOptionEntity {
  final int id;
  final String name;
  final String price;
  final String finalPrice;
  final bool hasDiscount;

  ProductAttributeOptionEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.finalPrice,
    required this.hasDiscount,
  });
}

class FlashSaleMetaEntity {
  final String? status;
  final String? startDate;
  final String? endDate;

  FlashSaleMetaEntity({this.status, this.startDate, this.endDate});
}
