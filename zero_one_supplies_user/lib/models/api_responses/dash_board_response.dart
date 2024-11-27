import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/api_responses/seller_list_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

// ---------------DashBoardResponse Api Class-------------------
class DashBoardResponse {
  bool error;
  DashboardData data;

  DashBoardResponse({this.error = false, required this.data});

  factory DashBoardResponse.fromJson(Map<String, dynamic> json) {
    return DashBoardResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      data: DashboardData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson(),
      };

  factory DashBoardResponse.empty() => DashBoardResponse(
        data: DashboardData.empty(),
      );

  static DashBoardResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashBoardResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashBoardResponse.empty();
}

// ---------------Category Api Class-------------------

class Category {
  String id;
  String name;
  String description;
  String image;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  String color;

  Category({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
    this.color = '',
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        description: APIHelper.getSafeStringValue(json['description']),
        image: APIHelper.getSafeStringValue(json['image']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        color: APIHelper.getSafeStringValue(json['color']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'color': color,
      };

  factory Category.empty() => Category(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category.empty();
}

// ---------------Data Api Class-------------------

class DashboardData {
  String id;
  List<Category> categories;
  List<AuctionProduct> auctionProducts;
  List<FlashSell> flashSell;
  List<TopBrand> topBrands;
  List<PopularProduct> popularProducts;
  List<TopSeller> topSeller;
  List<AuctionProduct> endingSoon;
  List<DashboardSlider> sliders;
  List<DashBoardCouponResponse> coupons;

  DashboardData(
      {this.id = '',
      this.categories = const [],
      this.auctionProducts = const [],
      this.flashSell = const [],
      this.topBrands = const [],
      this.popularProducts = const [],
      this.topSeller = const [],
      this.endingSoon = const [],
      this.sliders = const [],
      this.coupons = const []});

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        id: APIHelper.getSafeStringValue(json['_id']),
        categories: (APIHelper.getSafeListValue(json['categories']))
            .map((e) => Category.getAPIResponseObjectSafeValue(e))
            .toList(),
        auctionProducts: (APIHelper.getSafeListValue(json['auction_products']))
            .map((e) => AuctionProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        flashSell: (APIHelper.getSafeListValue(json['flash_sell']))
            .map((e) => FlashSell.getAPIResponseObjectSafeValue(e))
            .toList(),
        topBrands: (APIHelper.getSafeListValue(json['top_brands']))
            .map((e) => TopBrand.getAPIResponseObjectSafeValue(e))
            .toList(),
        popularProducts: (APIHelper.getSafeListValue(json['popular_products']))
            .map((e) => PopularProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        topSeller: (APIHelper.getSafeListValue(json['top_seller']))
            .map((e) => TopSeller.getAPIResponseObjectSafeValue(e))
            .toList(),
        endingSoon: (APIHelper.getSafeListValue(json['ending_soon']))
            .map((e) => AuctionProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        sliders: (APIHelper.getSafeListValue(json['sliders']))
            .map((e) => DashboardSlider.getAPIResponseObjectSafeValue(e))
            .toList(),
        coupons: (APIHelper.getSafeListValue(json['coupons']))
            .map(
                (e) => DashBoardCouponResponse.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'categories': categories.map((e) => e.toJson()).toList(),
        'auction_products': auctionProducts.map((e) => e.toJson()).toList(),
        'flash_sell': flashSell.map((e) => e.toJson()).toList(),
        'top_brands': topBrands.map((e) => e.toJson()).toList(),
        'popular_products': popularProducts.map((e) => e.toJson()).toList(),
        'top_seller': topSeller.map((e) => e.toJson()).toList(),
        'ending_soon': endingSoon.map((e) => e.toJson()).toList(),
        'sliders': sliders.map((e) => e.toJson()).toList(),
        'coupons': coupons.map((e) => e.toJson()).toList(),
      };

  factory DashboardData.empty() => DashboardData();

  static DashboardData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DashboardData.empty();
}

// ---------------AuctionProduct Api Class-------------------

class AuctionProduct {
  String id;
  ProductShortDetails product;
  DateTime startDate;
  DateTime endDate;
  double currentPrice;
  bool status;
  DateTime createdAt;
  bool isEnd;
  bool isWishListed;

  AuctionProduct({
    this.id = '',
    required this.product,
    required this.startDate,
    required this.endDate,
    this.currentPrice = 0,
    this.status = false,
    required this.createdAt,
    this.isEnd = false,
    this.isWishListed = false,
  });

  factory AuctionProduct.fromJson(Map<String, dynamic> json) {
    return AuctionProduct(
      id: APIHelper.getSafeStringValue(json['_id']),
      product:
          ProductShortDetails.getAPIResponseObjectSafeValue(json['product']),
      startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
      endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
      currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
      status: APIHelper.getSafeBoolValue(json['status']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      isEnd: APIHelper.getSafeBoolValue(json['is_end']),
      isWishListed: APIHelper.getSafeBoolValue(json['isFavorite']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'product': product.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'current_price': currentPrice,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'is_end': isEnd,
        'isFavorite': isWishListed,
      };

  factory AuctionProduct.empty() => AuctionProduct(
        createdAt: AppComponents.defaultUnsetDateTime,
        product: ProductShortDetails.empty(),
        startDate: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
      );

  static AuctionProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProduct.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : AuctionProduct.empty();
}

// ---------------EndingSoon Api Class-------------------

// class EndingSoon {
// 	String id;
// 	ProductShortDetails product;
// 	DateTime startDate;
// 	DateTime endDate;
// 	int currentPrice;
// 	bool status;
// 	DateTime createdAt;
// 	bool isEnd;

// 	EndingSoon({
// 		this.id='',
// 		required this.product,
// 		required this.startDate,
// 		required this.endDate,
// 		this.currentPrice=0,
// 		this.status=false,
// 		required this.createdAt,
// 		this.isEnd=false,
// 	});

// 	factory EndingSoon.fromJson(Map<String, dynamic> json) => EndingSoon(
// 				id: APIHelper.getSafeStringValue(json['_id']),
// 				product: ProductShortDetails.getAPIResponseObjectSafeValue(json['product']),
// 				startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
// 				endDate: APIHelper.getSafeDateTimeValue(json['end_date'] ),
// 				currentPrice: APIHelper.getSafeIntValue(json['current_price']),
// 				status: APIHelper.getSafeBoolValue(json['status']),
// 				createdAt: APIHelper.getSafeDateTimeValue(json['createdAt'] ),
// 				isEnd: APIHelper.getSafeBoolValue(json['is_end']),
// 			);

// 	Map<String, dynamic> toJson() => {
// 				'_id': id,
// 				'product': product?.toJson(),
// 				'start_date': APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
// 				'end_date':APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
// 				'current_price': currentPrice,
// 				'status': status,
// 				'createdAt': APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
// 				'is_end': isEnd,
// 			};

//       factory EndingSoon.empty()=> EndingSoon(
//         createdAt:AppComponents.defaultUnsetDateTime ,
//         product:ProductShortDetails(),
//         startDate: AppComponents.defaultUnsetDateTime,
//         endDate: AppComponents.defaultUnsetDateTime,
//         );

//        static EndingSoon getAPIResponseObjectSafeValue(
//           dynamic unsafeResponseValue) =>
//       APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
//           ? EndingSoon.fromJson(
//               unsafeResponseValue as Map<String, dynamic>)
//           : EndingSoon.empty();

// }
// ---------------TopBrand Api Class-------------------
class TopBrand {
  String id;
  String name;
  String description;
  String image;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  TopBrand({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TopBrand.fromJson(Map<String, dynamic> json) => TopBrand(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        description: APIHelper.getSafeStringValue(json['description']),
        image: APIHelper.getSafeStringValue(json['image']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };
  factory TopBrand.empty() => TopBrand(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );

  static TopBrand getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TopBrand.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : TopBrand.empty();
}
// ---------------TopSeller Api Class-------------------

class TopSeller {
  String id;
  String name;
  String logo;
  DateTime createdAt;
  String category;
  int products;
  SellerRating sellerRating;
  bool isVerified;

  TopSeller({
    this.id = '',
    this.name = '',
    this.logo = '',
    required this.createdAt,
    this.category = '',
    this.products = 0,
    required this.sellerRating,
    this.isVerified = false,
  });

  factory TopSeller.fromJson(Map<String, dynamic> json) => TopSeller(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        category: APIHelper.getSafeStringValue(json['category']),
        products: APIHelper.getSafeIntValue(json['products'], 0),
        sellerRating:
            SellerRating.getAPIResponseObjectSafeValue(json['product_ratings']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'logo': logo,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'category': category,
        'products': products,
        'product_ratings': sellerRating.toJson(),
        'verified': isVerified,
      };
  factory TopSeller.empty() => TopSeller(
        createdAt: AppComponents.defaultUnsetDateTime,
        sellerRating: SellerRating(),
      );

  static TopSeller getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TopSeller.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : TopSeller.empty();
}

// ---------------PopularProduct Api Class-------------------
class PopularProduct {
  String id;
  String name;
  DashboardProductStore store;
  DashboardProductCategory category;
  double originalPrice;
  double currentPrice;
  bool newArrival;
  DateTime createdAt;
  String image;
  double rating;
  double totalReview;
  bool discount;
  bool isWishListed;
  DiscountValue discountValue;
  String productCondition;
  ProductDetailsLocation productLocation;

  PopularProduct({
    this.id = '',
    this.name = '',
    required this.store,
    required this.category,
    this.originalPrice = 0,
    this.currentPrice = 0,
    this.newArrival = false,
    required this.createdAt,
    this.image = '',
    this.rating = 0,
    this.totalReview = 0,
    this.discount = false,
    this.isWishListed = false,
    required this.discountValue,
    this.productCondition = '',
    required this.productLocation,
  });

  factory PopularProduct.fromJson(Map<String, dynamic> json) => PopularProduct(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        store:
            DashboardProductStore.getAPIResponseObjectSafeValue(json['store']),
        category: DashboardProductCategory.getAPIResponseObjectSafeValue(
            json['category']),
        originalPrice: APIHelper.getSafeDoubleValue(json['price']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        image: APIHelper.getSafeStringValue(json['image']),
        rating: APIHelper.getSafeDoubleValue(json['rating']),
        totalReview: APIHelper.getSafeDoubleValue(json['total_review']),
        discount: APIHelper.getSafeBoolValue(json['discount']),
        isWishListed: APIHelper.getSafeBoolValue(json['isWishListed']),
        discountValue:
            DiscountValue.getAPIResponseObjectSafeValue(json['discount_value']),
        productCondition:
            APIHelper.getSafeStringValue(json['product_condition']),
        productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
            json['product_location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'store': store.toJson(),
        'category': category.toJson(),
        'price': originalPrice,
        'current_price': currentPrice,
        'new_arrival': newArrival,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        'rating': rating,
        'total_review': totalReview,
        'discount': discount,
        'isWishListed': isWishListed,
        'discount_value': discountValue.toJson(),
        'product_condition': productCondition,
        'product_location': productLocation.toJson(),
      };
  factory PopularProduct.empty() => PopularProduct(
        store: DashboardProductStore(),
        category: DashboardProductCategory(),
        createdAt: AppComponents.defaultUnsetDateTime,
        discountValue: DiscountValue.empty(),
        productLocation: ProductDetailsLocation.empty(),
      );

  static PopularProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PopularProduct.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PopularProduct.empty();

  ProductConditionStatus get productConditionStatus =>
      ProductConditionStatus.toEnumValue(productCondition);
}
// ---------------FlashSell Api Class-------------------

class FlashSell {
  String id;
  String name;
  DashboardProductStore store;
  DashboardProductCategory category;
  double originalPrice;
  double currentPrice;
  bool newArrival;
  DateTime createdAt;
  String image;
  String productCondition;
  double rating;
  double totalReview;
  bool discount;
  // bool isAddedToCart;
  bool isWishListed;
  DiscountValue discountValue;
  ProductDetailsLocation productLocation;

  FlashSell({
    this.id = '',
    this.name = '',
    required this.store,
    required this.category,
    this.originalPrice = 0,
    this.currentPrice = 0,
    this.newArrival = false,
    required this.createdAt,
    this.image = '',
    this.productCondition = '',
    this.rating = 0,
    this.totalReview = 0,
    this.discount = false,
    // this.isAddedToCart = false,
    this.isWishListed = false,
    required this.discountValue,
    required this.productLocation,
  });

  factory FlashSell.fromJson(Map<String, dynamic> json) => FlashSell(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        store:
            DashboardProductStore.getAPIResponseObjectSafeValue(json['store']),
        category: DashboardProductCategory.getAPIResponseObjectSafeValue(
            json['category']),
        originalPrice: APIHelper.getSafeDoubleValue(json['price']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        image: APIHelper.getSafeStringValue(json['image']),
        rating: APIHelper.getSafeDoubleValue(json['rating']),
        totalReview: APIHelper.getSafeDoubleValue(json['total_review']),
        discount: APIHelper.getSafeBoolValue(json['discount']),
        // isAddedToCart: APIHelper.getSafeBoolValue(json['isAddedToCart']),
        isWishListed: APIHelper.getSafeBoolValue(json['isWishListed']),
        discountValue:
            DiscountValue.getAPIResponseObjectSafeValue(json['discount_value']),
        productCondition:
            APIHelper.getSafeStringValue(json['product_condition']),
        productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
            json['product_location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'store': store.toJson(),
        'category': category.toJson(),
        'price': originalPrice,
        'current_price': currentPrice,
        'new_arrival': newArrival,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        'rating': rating,
        'total_review': totalReview,
        'discount': discount,
        // 'isAddedToCart': isAddedToCart,
        'isWishListed': isWishListed,
        'discount_value': discountValue.toJson(),
        'product_condition': productCondition,
        'product_location': productLocation.toJson(),
      };
  factory FlashSell.empty() => FlashSell(
        store: DashboardProductStore(),
        category: DashboardProductCategory(),
        createdAt: AppComponents.defaultUnsetDateTime,
        discountValue: DiscountValue.empty(),
        productLocation: ProductDetailsLocation.empty(),
      );

  static FlashSell getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FlashSell.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : FlashSell.empty();

  ProductConditionStatus get productConditionStatus =>
      ProductConditionStatus.toEnumValue(productCondition);
}

class DashboardProductStore {
  String id;
  String name;
  bool isVerified;

  DashboardProductStore({
    this.id = '',
    this.name = '',
    this.isVerified = false,
  });

  factory DashboardProductStore.fromJson(Map<String, dynamic> json) =>
      DashboardProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static DashboardProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardProductStore();
}

class DashboardProductCategory {
  String id;
  String name;

  DashboardProductCategory({
    this.id = '',
    this.name = '',
  });

  factory DashboardProductCategory.fromJson(Map<String, dynamic> json) =>
      DashboardProductCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static DashboardProductCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardProductCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardProductCategory();
}
// ---------------DiscountValue Api Class-------------------

class DiscountValue {
  String type;
  double amount;
  DateTime startDate;
  DateTime endDate;

  DiscountValue(
      {this.type = '',
      this.amount = 0,
      required this.startDate,
      required this.endDate});

  factory DiscountValue.fromJson(Map<String, dynamic> json) => DiscountValue(
        type: APIHelper.getSafeStringValue(json['type']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'amount': amount,
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
      };

  factory DiscountValue.empty() => DiscountValue(
        startDate: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
      );

  static DiscountValue getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DiscountValue.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DiscountValue.empty();
}

// ---------------ProductShortDetails Api Class-------------------
class ProductShortDetails {
  String id;
  String name;
  String image;
  bool isFavorite;
  ProductShortCategory category;
  ProductShortDetailsStore store;

  ProductShortDetails(
      {this.id = '',
      this.name = '',
      this.image = '',
      this.isFavorite = false,
      required this.category,
      required this.store});

  factory ProductShortDetails.fromJson(Map<String, dynamic> json) {
    return ProductShortDetails(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      category:
          ProductShortCategory.getAPIResponseObjectSafeValue(json['category']),
      image: APIHelper.getSafeStringValue(json['image']),
      isFavorite: APIHelper.getSafeBoolValue(json['isFavorite']),
      store:
          ProductShortDetailsStore.getAPIResponseObjectSafeValue(json['store']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'category': category.toJson(),
        'image': image,
        'isFavorite': isFavorite,
        'store': store.toJson(),
      };

  factory ProductShortDetails.empty() => ProductShortDetails(
      category: ProductShortCategory(), store: ProductShortDetailsStore());

  static ProductShortDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductShortDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductShortDetails.empty();
}

class ProductShortDetailsStore {
  String id;
  String name;
  bool isVerified;

  ProductShortDetailsStore(
      {this.id = '', this.name = '', this.isVerified = false});

  factory ProductShortDetailsStore.fromJson(Map<String, dynamic> json) =>
      ProductShortDetailsStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static ProductShortDetailsStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductShortDetailsStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductShortDetailsStore();
}

class ProductShortCategory {
  String id;
  String name;

  ProductShortCategory({
    this.id = '',
    this.name = '',
  });

  factory ProductShortCategory.fromJson(Map<String, dynamic> json) {
    return ProductShortCategory(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
  static ProductShortCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductShortCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductShortCategory();
}

class DashBoardCouponResponse {
  String id;
  String name;
  String code;
  double value;
  String discountType;
  bool freeShipping;
  bool active;
  bool isNavbar;
  bool isNewsletter;
  int usageLimitPerCoupon;
  int usageLimitPerCustomer;
  int minSpend;
  DateTime startDate;
  DateTime endDate;
  DateTime createdAt;
  DateTime updatedAt;
  String description;
  String image;
  bool isApp;

  DashBoardCouponResponse({
    this.id = '',
    this.name = '',
    this.code = '',
    this.value = 0,
    this.discountType = '',
    this.freeShipping = false,
    this.active = false,
    this.isNavbar = false,
    this.isNewsletter = false,
    this.usageLimitPerCoupon = 0,
    this.usageLimitPerCustomer = 0,
    this.minSpend = 0,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    this.description = '',
    this.image = '',
    this.isApp = false,
  });

  factory DashBoardCouponResponse.fromJson(Map<String, dynamic> json) {
    return DashBoardCouponResponse(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      code: APIHelper.getSafeStringValue(json['code']),
      value: APIHelper.getSafeDoubleValue(json['value']),
      discountType: APIHelper.getSafeStringValue(json['discount_type']),
      freeShipping: APIHelper.getSafeBoolValue(json['free_shipping']),
      active: APIHelper.getSafeBoolValue(json['active']),
      isNavbar: APIHelper.getSafeBoolValue(json['is_navbar']),
      isNewsletter: APIHelper.getSafeBoolValue(json['is_newsletter']),
      usageLimitPerCoupon:
          APIHelper.getSafeIntValue(json['usage_limit_per_coupon']),
      usageLimitPerCustomer:
          APIHelper.getSafeIntValue(json['usage_limit_per_customer']),
      minSpend: APIHelper.getSafeIntValue(json['min_spend']),
      startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
      endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      description: APIHelper.getSafeStringValue(json['description']),
      image: APIHelper.getSafeStringValue(json['image']),
      isApp: APIHelper.getSafeBoolValue(json['isApp']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'value': value,
        'discount_type': discountType,
        'free_shipping': freeShipping,
        'active': active,
        'is_navbar': isNavbar,
        'is_newsletter': isNewsletter,
        'usage_limit_per_coupon': usageLimitPerCoupon,
        'usage_limit_per_customer': usageLimitPerCustomer,
        'min_spend': minSpend,
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'description': description,
        'image': image,
        'isApp': isApp,
      };

  factory DashBoardCouponResponse.empty() => DashBoardCouponResponse(
        startDate: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );

  static DashBoardCouponResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashBoardCouponResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashBoardCouponResponse.empty();
}

class DashboardSlider {
  String category;
  String image;
  String id;

  DashboardSlider({this.category = '', this.image = '', this.id = ''});

  factory DashboardSlider.fromJson(Map<String, dynamic> json) {
    return DashboardSlider(
      category: APIHelper.getSafeStringValue(json['category']),
      image: APIHelper.getSafeStringValue(json['image']),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'image': image,
        '_id': id,
      };
  static DashboardSlider getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DashboardSlider.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DashboardSlider();
}
