import '../../domain/entities/home_entity.dart';

class HomeResponseModel {
  final bool? status;
  final String? message;
  final HomeDataModel? data;

  HomeResponseModel({this.status, this.message, this.data});

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : HomeDataModel.fromJson(json["data"]),
      );

  HomeEntity toEntity() {
    return HomeEntity(
      banners: data?.banners?.map((e) => e.toEntity()).toList() ?? [],
      coupon: data?.coupon?.toEntity(),
      trendingCategories:
          data?.trendingCategories?.map((e) => e.toEntity()).toList() ?? [],
      popularBrands:
          data?.popularBrands?.map((e) => e.toBrandEntity()).toList() ?? [],
      providers: data?.providers?.map((e) => e.toEntity()).toList() ?? [],
      products:
          data?.products?.toEntity() ??
          HomeProductsEntity(
            flashSaleProducts: [],
            trendingProducts: [],
            bestSellingProducts: [],
            latestProducts: [],
          ),
      flashSaleMeta: data?.flashSaleMeta?.toEntity() ?? FlashSaleMetaEntity(),
    );
  }
}

class HomeDataModel {
  final List<BannerModel>? banners;
  final CouponModel? coupon;
  final List<CategoryBrandModel>? trendingCategories;
  final List<CategoryBrandModel>? popularBrands;
  final ProductsModel? products;
  final List<ProviderModel>? providers;
  final FlashSaleMetaModel? flashSaleMeta;

  HomeDataModel({
    this.banners,
    this.coupon,
    this.trendingCategories,
    this.popularBrands,
    this.products,
    this.providers,
    this.flashSaleMeta,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    banners: json["banners"] == null
        ? []
        : List<BannerModel>.from(
            json["banners"].map((x) => BannerModel.fromJson(x)),
          ),
    coupon: json["coupon"] == null
        ? null
        : CouponModel.fromJson(json["coupon"]),
    trendingCategories: json["trending_categories"] == null
        ? []
        : List<CategoryBrandModel>.from(
            json["trending_categories"].map(
              (x) => CategoryBrandModel.fromJson(x),
            ),
          ),
    popularBrands: json["popular_brands"] == null
        ? []
        : List<CategoryBrandModel>.from(
            json["popular_brands"].map((x) => CategoryBrandModel.fromJson(x)),
          ),
    products: json["products"] == null
        ? null
        : ProductsModel.fromJson(json["products"]),
    providers: json["providers"] == null
        ? []
        : List<ProviderModel>.from(
            json["providers"].map((x) => ProviderModel.fromJson(x)),
          ),
    flashSaleMeta: json["flash_sale_meta"] == null
        ? null
        : FlashSaleMetaModel.fromJson(json["flash_sale_meta"]),
  );
}

class BannerModel {
  final int? id;
  final String? name;
  final String? image;
  final String? slug;
  final int? categoryId;

  BannerModel({this.id, this.name, this.image, this.slug, this.categoryId});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
    categoryId: json["category_id"],
  );

  BannerEntity toEntity() => BannerEntity(
    id: id ?? 0,
    name: name ?? '',
    image: image ?? '',
    slug: slug ?? '',
    categoryId: categoryId,
  );
}

class CouponModel {
  final int? id;
  final String? code;
  final String? discountType;
  final String? discountValue;
  final String? expiresAt;

  CouponModel({
    this.id,
    this.code,
    this.discountType,
    this.discountValue,
    this.expiresAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    id: json["id"],
    code: json["code"],
    discountType: json["discount_type"],
    discountValue: json["discount_value"],
    expiresAt: json["expires_at"],
  );

  CouponEntity toEntity() => CouponEntity(
    id: id ?? 0,
    code: code ?? '',
    discountType: discountType ?? '',
    discountValue: discountValue ?? '',
    expiresAt: expiresAt ?? '',
  );
}

class CategoryBrandModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;

  CategoryBrandModel({this.id, this.name, this.slug, this.image});

  factory CategoryBrandModel.fromJson(Map<String, dynamic> json) =>
      CategoryBrandModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
      );

  CategoryEntity toEntity() => CategoryEntity(
    id: id ?? 0,
    name: name ?? '',
    slug: slug ?? '',
    image: image ?? '',
  );

  BrandEntity toBrandEntity() => BrandEntity(
    id: id ?? 0,
    name: name ?? '',
    slug: slug ?? '',
    image: image ?? '',
  );
}

class ProviderModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final String? websiteUrl;

  ProviderModel({this.id, this.name, this.slug, this.image, this.websiteUrl});

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    websiteUrl: json["website_url"],
  );

  ProviderEntity toEntity() => ProviderEntity(
    id: id ?? 0,
    name: name ?? '',
    slug: slug ?? '',
    image: image ?? '',
    websiteUrl: websiteUrl,
  );
}

class ProductsModel {
  final List<ProductModel>? flashSaleProducts;
  final List<ProductModel>? trendingProducts;
  final List<ProductModel>? bestSellingProducts;
  final List<ProductModel>? latestProducts;

  ProductsModel({
    this.flashSaleProducts,
    this.trendingProducts,
    this.bestSellingProducts,
    this.latestProducts,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    flashSaleProducts: json["flash_sale_products"] == null
        ? []
        : List<ProductModel>.from(
            json["flash_sale_products"].map((x) => ProductModel.fromJson(x)),
          ),
    trendingProducts: json["trending_products"] == null
        ? []
        : List<ProductModel>.from(
            json["trending_products"].map((x) => ProductModel.fromJson(x)),
          ),
    bestSellingProducts: json["best_selling_products"] == null
        ? []
        : List<ProductModel>.from(
            json["best_selling_products"].map((x) => ProductModel.fromJson(x)),
          ),
    latestProducts: json["latest_products"] == null
        ? []
        : List<ProductModel>.from(
            json["latest_products"].map((x) => ProductModel.fromJson(x)),
          ),
  );

  HomeProductsEntity toEntity() => HomeProductsEntity(
    flashSaleProducts:
        flashSaleProducts?.map((e) => e.toEntity()).toList() ?? [],
    trendingProducts: trendingProducts?.map((e) => e.toEntity()).toList() ?? [],
    bestSellingProducts:
        bestSellingProducts?.map((e) => e.toEntity()).toList() ?? [],
    latestProducts: latestProducts?.map((e) => e.toEntity()).toList() ?? [],
  );
}

class ProductModel {
  final int? id;
  final String? productName;
  final String? thumbnail;
  final String? price;
  final dynamic finalPrice;
  final bool? hasDiscount;
  final String? discountText;
  final int? quantity;
  final String? type;
  final Map<String, List<ProductAttributeOptionModel>>? attributes;

  ProductModel({
    this.id,
    this.productName,
    this.thumbnail,
    this.price,
    this.finalPrice,
    this.hasDiscount,
    this.discountText,
    this.quantity,
    this.type,
    this.attributes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final rawAttributes = json["attributes"];
    Map<String, List<ProductAttributeOptionModel>> parsedAttributes = {};
    if (rawAttributes is Map) {
      rawAttributes.forEach((key, value) {
        if (value is List) {
          parsedAttributes[key.toString()] = value
              .map((e) => ProductAttributeOptionModel.fromJson(e))
              .toList();
        }
      });
    }
    return ProductModel(
      id: json["id"],
      productName: json["product_name"],
      thumbnail: json["thumbnail"],
      price: json["price"],
      finalPrice: json["final_price"],
      hasDiscount: json["has_discount"],
      discountText: json["discount_text"],
      quantity: json["quantity"],
      type: json["type"],
      attributes: parsedAttributes,
    );
  }

  ProductEntity toEntity() => ProductEntity(
    id: id ?? 0,
    productName: productName ?? '',
    thumbnail: thumbnail ?? '',
    price: price ?? '0',
    finalPrice: finalPrice,
    hasDiscount: hasDiscount ?? false,
    discountText: discountText ?? '',
    quantity: quantity ?? 0,
    type: type ?? '',
    attributes:
        attributes?.map(
          (k, v) => MapEntry(k, v.map((e) => e.toEntity()).toList()),
        ) ??
        {},
  );
}

class ProductAttributeOptionModel {
  final int? id;
  final String? name;
  final String? price;
  final String? finalPrice;
  final bool? hasDiscount;

  ProductAttributeOptionModel({
    this.id,
    this.name,
    this.price,
    this.finalPrice,
    this.hasDiscount,
  });

  factory ProductAttributeOptionModel.fromJson(Map<String, dynamic> json) =>
      ProductAttributeOptionModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        finalPrice: json["final_price"],
        hasDiscount: json["has_discount"],
      );

  ProductAttributeOptionEntity toEntity() => ProductAttributeOptionEntity(
    id: id ?? 0,
    name: name ?? '',
    price: price ?? '0',
    finalPrice: finalPrice ?? '0',
    hasDiscount: hasDiscount ?? false,
  );
}

class FlashSaleMetaModel {
  final String? flashSaleStatus;
  final String? flashSaleStartDate;
  final String? flashSaleEndDate;

  FlashSaleMetaModel({
    this.flashSaleStatus,
    this.flashSaleStartDate,
    this.flashSaleEndDate,
  });

  factory FlashSaleMetaModel.fromJson(Map<String, dynamic> json) =>
      FlashSaleMetaModel(
        flashSaleStatus: json["flash_sale_status"],
        flashSaleStartDate: json["flash_sale_start_date"],
        flashSaleEndDate: json["flash_sale_end_date"],
      );

  FlashSaleMetaEntity toEntity() => FlashSaleMetaEntity(
    status: flashSaleStatus,
    startDate: flashSaleStartDate,
    endDate: flashSaleEndDate,
  );
}
