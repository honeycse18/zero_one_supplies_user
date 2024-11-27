import 'dart:math';

import 'package:collection/collection.dart';
import 'package:ecomik/models/api_responses/coupon_list_response.dart';
import 'package:ecomik/models/api_responses/pickup_stations_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';

class ProductDetailsResponse {
  bool error;
  String msg;
  ProductDetailsItem data;

  ProductDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: ProductDetailsItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ProductDetailsResponse.empty() => ProductDetailsResponse(
        data: ProductDetailsItem.empty(),
      );
  static ProductDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsResponse.empty();
}

class ProductDetailsItem {
  String id;
  String name;
  ProductStore store;
  double rating;
  String model;
  ProductBrand brand;
  List<ProductDetailsCategory> productDetailsCategories;
  List<ProductDetailsSubCategory> productDetailsSubCategories;
  String unit;
  Quantity quantity;
  List<QuantityBasedPrice> quantityBasedPrices;
  double originalPrice;
  double currentPrice;
  String productImage;
  List<String> galleryImages;
  Attributes attributes;
  List<ProductAttribute> attribute;
  bool stockAvailable;
  bool stockVisibility;
  bool flashDeal;
  bool newArrival;
  bool isStatus;
  List<Specification> specifications;
  List<dynamic> variants;
  DateTime createdAt;
  DateTime updatedAt;
  List<RelatedProduct> relatedProducts;
  List<ProductRatingWiseUser> productRatingWiseUser;
  bool discount;
  ProductDiscountValue discountValue;
  Description description;
  DeliveryInfo deliveryInfo;
  int productCount;
  int totalReview;
  bool isFavorite;
  List<Coupon> coupons;
  List<String> productCondition;
  ProductDetailsLocation productLocation;
  List<ProductDetailsReview> reviews;
  String specificationDescription;
  List<String> tags;
  String thumbImage;
  bool isTrash;
  bool isUserRequested;

  ProductDetailsItem({
    this.id = '',
    this.name = '',
    required this.store,
    this.rating = 0,
    this.model = '',
    required this.brand,
    this.productDetailsCategories = const [],
    this.productDetailsSubCategories = const [],
    this.unit = '',
    required this.quantity,
    this.quantityBasedPrices = const [],
    this.originalPrice = 0,
    this.currentPrice = 0,
    this.productImage = '',
    this.galleryImages = const [],
    required this.attributes,
    this.attribute = const [],
    this.stockAvailable = false,
    this.stockVisibility = false,
    this.flashDeal = false,
    this.newArrival = false,
    this.isStatus = false,
    this.specifications = const [],
    this.variants = const [],
    required this.createdAt,
    required this.updatedAt,
    this.relatedProducts = const [],
    this.productRatingWiseUser = const [],
    this.discount = false,
    required this.discountValue,
    required this.description,
    required this.deliveryInfo,
    this.productCount = 1,
    this.totalReview = 0,
    this.isFavorite = false,
    this.coupons = const [],
    this.productCondition = const [],
    required this.productLocation,
    this.reviews = const [],
    this.specificationDescription = '',
    this.tags = const [],
    this.thumbImage = '',
    this.isTrash = false,
    this.isUserRequested = false,
  });

  factory ProductDetailsItem.fromJson(Map<String, dynamic> json) =>
      ProductDetailsItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        rating: APIHelper.getSafeDoubleValue(json['rating'], 0),
        name: APIHelper.getSafeStringValue(json['name']),
        store: ProductStore.getAPIResponseObjectSafeValue(json['store']),
        model: APIHelper.getSafeStringValue(json['model']),
        brand: ProductBrand.getAPIResponseObjectSafeValue(json['brand']),
        productDetailsCategories: APIHelper.getSafeListValue(
                json['ProductDetailsCategories'])
            .map((e) => ProductDetailsCategory.getAPIResponseObjectSafeValue(e))
            .toList(),
        productDetailsSubCategories:
            (APIHelper.getSafeListValue(json['subProductDetailsCategories']))
                .map((e) =>
                    ProductDetailsSubCategory.getAPIResponseObjectSafeValue(e))
                .toList(),
        unit: APIHelper.getSafeStringValue(json['unit']),
        quantity: Quantity.getAPIResponseObjectSafeValue(json['quantity']),
        quantityBasedPrices:
            APIHelper.getSafeListValue(json['quantity_based_price'])
                .map((e) => QuantityBasedPrice.getAPIResponseObjectSafeValue(e))
                .toList(),
        originalPrice: APIHelper.getSafeDoubleValue(json['price']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        productImage: APIHelper.getSafeStringValue(json['product_image']),
        galleryImages: (APIHelper.getSafeListValue(json['gallery_images']))
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        productRatingWiseUser: APIHelper.getSafeListValue(
                json['product_rating_wise_user'])
            .map((e) => ProductRatingWiseUser.getAPIResponseObjectSafeValue(e))
            .toList(),
        attributes:
            Attributes.getAPIResponseObjectSafeValue(json['attributes']),
        attribute: APIHelper.getSafeListValue(json['attribute'])
            .map((e) => ProductAttribute.getAPIResponseObjectSafeValue(e))
            .toList(),
        stockAvailable: APIHelper.getSafeBoolValue(json['stock_available']),
        stockVisibility: APIHelper.getSafeBoolValue(json['stock_visibility']),
        flashDeal: APIHelper.getSafeBoolValue(json['flash_deal']),
        newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
        isStatus: APIHelper.getSafeBoolValue(json['is_status']),
        specifications: APIHelper.getSafeListValue(json['specifications'])
            .map((e) => Specification.getAPIResponseObjectSafeValue(e))
            .toList(),
        variants:
            APIHelper.getSafeListValue(json['variants']).map((e) => e).toList(),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        relatedProducts: APIHelper.getSafeListValue(json['related_products'])
            .map((e) => RelatedProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        discount: APIHelper.getSafeBoolValue(json['discount']),
        discountValue: ProductDiscountValue.getAPIResponseObjectSafeValue(
            json['discount_value']),
        description:
            Description.getAPIResponseObjectSafeValue(json['description']),
        totalReview: APIHelper.getSafeIntValue(json['total_review']),
        deliveryInfo:
            DeliveryInfo.getAPIResponseObjectSafeValue(json['delivery_info']),
        productCount: APIHelper.getSafeIntValue(json['product_Count'], 1),
        isFavorite: APIHelper.getSafeBoolValue(json['product_Count']),
        coupons: APIHelper.getSafeListValue(json['coupon_codes'])
            .map((e) => Coupon.getAPIResponseObjectSafeValue(e))
            .toList(),
        productCondition: APIHelper.getSafeListValue(json['product_condition'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
            json['product_location']),
        reviews: APIHelper.getSafeListValue(json['reviews'])
            .map((e) => ProductDetailsReview.getAPIResponseObjectSafeValue(e))
            .toList(),
        specificationDescription:
            APIHelper.getSafeStringValue(json['specification_description']),
        tags: APIHelper.getSafeListValue(json['tags'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        thumbImage: APIHelper.getSafeStringValue(json['thumb_image']),
        isTrash: APIHelper.getSafeBoolValue(json['trash']),
        isUserRequested: APIHelper.getSafeBoolValue(json['user_requested']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'model': model,
        'rating': rating,
        'brand': brand.toJson(),
        'ProductDetailsCategories':
            productDetailsCategories.map((e) => e.toJson()).toList(),
        'subProductDetailsCategories': productDetailsSubCategories,
        'unit': unit,
        'quantity': quantity.toJson(),
        'quantity_based_price':
            quantityBasedPrices.map((e) => e.toJson()).toList(),
        'price': originalPrice,
        'current_price': currentPrice,
        'product_image': productImage,
        'gallery_images': galleryImages,
        'attributes': attributes.toJson(),
        'attribute': attribute.map((e) => e.toJson()).toList(),
        'stock_available': stockAvailable,
        'stock_visibility': stockVisibility,
        'flash_deal': flashDeal,
        'new_arrival': newArrival,
        'product_rating_wise_user':
            productRatingWiseUser.map((e) => e.toJson()).toList(),
        'is_status': isStatus,
        'specifications': specifications.map((e) => e.toJson()).toList(),
        'variants': variants,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'related_products': relatedProducts.map((e) => e.toJson()).toList(),
        'discount': discount,
        'discount_value': discountValue.toJson(),
        'description': description.toJson(),
        'delivery_info': deliveryInfo.toJson(),
        'product_Count': productCount,
        'total_review': totalReview,
        'isFavorite': isFavorite,
        'coupon_codes': coupons.map((e) => e.toJson()).toList(),
        'product_condition': productCondition.map((e) => e).toList(),
        'product_location': productLocation.toJson(),
        'reviews': reviews.map((e) => e).toList(),
        'specification_description': specificationDescription,
        'tags': tags.map((e) => e).toList(),
        'thumbImage': thumbImage,
        'trash': isTrash,
        'user_requested': isUserRequested,
      };

  factory ProductDetailsItem.empty() => ProductDetailsItem(
        description: Description(),
        createdAt: AppComponents.defaultUnsetDateTime,
        brand: ProductBrand(),
        quantity: Quantity(),
        attributes: Attributes(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        discountValue: ProductDiscountValue.empty(),
        deliveryInfo: DeliveryInfo.empty(),
        store: ProductStore.empty(),
        productLocation: ProductDetailsLocation.empty(),
      );

  static ProductDetailsItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsItem.empty();

  ProductAttribute? get colorAttribute =>
      attribute.firstWhereOrNull((element) => element.isProductColorAttribute);

  int get minimumQuantity => quantityBasedPrices.fold(
      0, (previousValue, element) => min(previousValue, element.maximum));

  int get maximumQuantity => quantityBasedPrices.fold(
      0, (previousValue, element) => max(previousValue, element.maximum));

  QuantityBasedPrice get maximumQuantityBasedPriceObject =>
      quantityBasedPrices
          .firstWhereOrNull((element) => element.maximum == maximumQuantity) ??
      QuantityBasedPrice();

  double get maximumQuantityPrice => maximumQuantityBasedPriceObject.price;

  double get productPrice {
    final productCurrentPrice = currentPrice;
    if (quantityBasedPrices.isEmpty) {
      return productCurrentPrice;
    }
    for (var quantityBasedPrice in quantityBasedPrices) {
      if (productCount >= quantityBasedPrice.minimum &&
          productCount <= quantityBasedPrice.maximum) {
        return quantityBasedPrice.price;
      }
    }
    if (minimumQuantity <= 0) {
      return productCurrentPrice;
    }
    if (maximumQuantity <= 0) {
      return productCurrentPrice;
    }
    if (minimumQuantity < productCount) {
      return productCurrentPrice;
    } else if (maximumQuantity > productCount) {
      return productCurrentPrice;
    }
    return productCurrentPrice;
  }
}

class ProductDetailsReview {
  ProductDetailsReviewUser user;
  String review;
  double rating;
  DateTime createdAt;

  ProductDetailsReview({
    required this.user,
    this.review = '',
    this.rating = 0,
    required this.createdAt,
  });

  factory ProductDetailsReview.fromJson(Map<String, dynamic> json) {
    return ProductDetailsReview(
      user:
          ProductDetailsReviewUser.getAPIResponseObjectSafeValue(json['user']),
      review: APIHelper.getSafeStringValue(json['review']),
      rating: APIHelper.getSafeDoubleValue(json['rating']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'review': review,
        'rating': rating,
        'createdAt': createdAt.toIso8601String(),
      };

  factory ProductDetailsReview.empty() => ProductDetailsReview(
      user: ProductDetailsReviewUser(),
      createdAt: AppComponents.defaultUnsetDateTime);

  static ProductDetailsReview getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsReview.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsReview.empty();
}

class ProductDetailsReviewUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String image;

  ProductDetailsReviewUser(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.image = ''});

  factory ProductDetailsReviewUser.fromJson(Map<String, dynamic> json) =>
      ProductDetailsReviewUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'image': image,
      };

  static ProductDetailsReviewUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsReviewUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsReviewUser();
}

class ProductDetailsLocation {
  String type;
  ProductDetailsLocationStore store;
  PickupStation relayPoint;

  ProductDetailsLocation(
      {this.type = '', required this.store, required this.relayPoint});

  factory ProductDetailsLocation.fromJson(Map<String, dynamic> json) {
    return ProductDetailsLocation(
      type: APIHelper.getSafeStringValue(json['type']),
      store: ProductDetailsLocationStore.getAPIResponseObjectSafeValue(
          json['store']),
      relayPoint:
          PickupStation.getAPIResponseObjectSafeValue(json['replay_point']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      'type': type,
    };
    switch (locationType) {
      case ProductLocation.pickupStations:
        map['replay_point'] = relayPoint.toJson();
        break;
      case ProductLocation.store:
        map['store'] = store.toJson();
        break;
      default:
    }
    return map;
  }

  factory ProductDetailsLocation.empty() => ProductDetailsLocation(
      store: ProductDetailsLocationStore.empty(),
      relayPoint: PickupStation.empty());

  static ProductDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsLocation.empty();

  bool get isEmpty => locationType == ProductLocation.none;
  bool get isNotEmpty => !isEmpty;

  ProductLocation get locationType {
    if (type == 'replay_point') {
      return ProductLocation.pickupStations;
    } else if (type == 'store') {
      return ProductLocation.store;
    }
    return ProductLocation.none;
  }
}

class ProductDetailsLocationStore {
  String id;
  String name;
  String address;
  ProductDetailsLocationStoreLocation location;

  ProductDetailsLocationStore(
      {this.id = '',
      this.name = '',
      this.address = '',
      required this.location});

  factory ProductDetailsLocationStore.fromJson(Map<String, dynamic> json) =>
      ProductDetailsLocationStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location:
            ProductDetailsLocationStoreLocation.getAPIResponseObjectSafeValue(
                json['location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'location': location.toJson(),
      };

  factory ProductDetailsLocationStore.empty() => ProductDetailsLocationStore(
      location: ProductDetailsLocationStoreLocation());

  static ProductDetailsLocationStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsLocationStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsLocationStore.empty();
}

class ProductDetailsLocationStoreLocation {
  double latitude;
  double longitude;

  ProductDetailsLocationStoreLocation(
      {this.latitude = Constants.unsetMapLatLng,
      this.longitude = Constants.unsetMapLatLng});

  factory ProductDetailsLocationStoreLocation.fromJson(
          Map<String, dynamic> json) =>
      ProductDetailsLocationStoreLocation(
        latitude: APIHelper.getSafeDoubleValue(
            json['latitude'], Constants.unsetMapLatLng),
        longitude: APIHelper.getSafeDoubleValue(
            json['longitude'], Constants.unsetMapLatLng),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
  static ProductDetailsLocationStoreLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsLocationStoreLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsLocationStoreLocation();
}

//====================================================

class RelatedProduct {
  String id;
  String name;
  double originalPrice;
  double currentPrice;
  bool newArrival;
  DateTime createdAt;
  String image;
  double rating;
  bool discount;
  bool isAddedToCart;
  bool isFavorite;
  ProductDiscountValue discountValue;
  RelatedProductStore store;
  String productCondition;
  int totalReview;
  ProductDetailsLocation productLocation;

  RelatedProduct({
    this.id = '',
    this.name = '',
    this.originalPrice = 0,
    this.currentPrice = 0,
    this.newArrival = false,
    required this.createdAt,
    this.image = '',
    this.rating = 0,
    this.discount = false,
    this.isFavorite = false,
    this.isAddedToCart = false,
    required this.discountValue,
    required this.store,
    this.productCondition = '',
    this.totalReview = 0,
    required this.productLocation,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      originalPrice: APIHelper.getSafeDoubleValue(json['price']),
      currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
      newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      image: APIHelper.getSafeStringValue(json['image']),
      rating: APIHelper.getSafeDoubleValue(json['rating']),
      discount: APIHelper.getSafeBoolValue(json['discount']),
      isAddedToCart: APIHelper.getSafeBoolValue(json['isAddedToCart']),
      isFavorite: APIHelper.getSafeBoolValue(json['isFavorite']),
      discountValue: ProductDiscountValue.getAPIResponseObjectSafeValue(
          json['discount_value']),
      store: RelatedProductStore.getAPIResponseObjectSafeValue(json['store']),
      productCondition: APIHelper.getSafeStringValue(json['product_condition']),
      totalReview: APIHelper.getSafeIntValue(json['total_review']),
      productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
          json['product_location']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'price': originalPrice,
        'current_price': currentPrice,
        'new_arrival': newArrival,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        'rating': rating,
        'discount': discount,
        'isWishListed': isFavorite,
        'isFavorite': isAddedToCart,
        'discount_value': discountValue,
        'store': store.toJson(),
        'product_condition': productCondition,
        'total_review': totalReview,
        'product_location': productLocation.toJson(),
      };

  factory RelatedProduct.empty() => RelatedProduct(
        createdAt: AppComponents.defaultUnsetDateTime,
        discountValue: ProductDiscountValue.empty(),
        store: RelatedProductStore(),
        productLocation: ProductDetailsLocation.empty(),
      );
  static RelatedProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RelatedProduct.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RelatedProduct.empty();

  ProductConditionStatus get productConditionStatus =>
      ProductConditionStatus.toEnumValue(productCondition);
}

class RelatedProductStore {
  String id;
  String name;
  bool isVerified;

  RelatedProductStore({
    this.id = '',
    this.name = '',
    this.isVerified = false,
  });

  factory RelatedProductStore.fromJson(Map<String, dynamic> json) =>
      RelatedProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static RelatedProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RelatedProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RelatedProductStore();
}

class Quantity {
  int unitQuantity;
  int stockQuantity;
  int minPurchaseQuantity;
  int stockAlertQuantity;

  Quantity({
    this.unitQuantity = 0,
    this.stockQuantity = 0,
    this.minPurchaseQuantity = 0,
    this.stockAlertQuantity = 0,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        unitQuantity: APIHelper.getSafeIntValue(json['unit_quantity']),
        stockQuantity: APIHelper.getSafeIntValue(json['stock_quantity']),
        minPurchaseQuantity:
            APIHelper.getSafeIntValue(json['min_purchase_quantity']),
        stockAlertQuantity:
            APIHelper.getSafeIntValue(json['stock_alert_quantity']),
      );

  Map<String, dynamic> toJson() => {
        'unit_quantity': unitQuantity,
        'stock_quantity': stockQuantity,
        'min_purchase_quantity': minPurchaseQuantity,
        'stock_alert_quantity': stockAlertQuantity,
      };
  static Quantity getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Quantity.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Quantity();
}

class ProductDiscountValue {
  String type;
  double amount;
  DateTime startDate;
  DateTime endDate;

  ProductDiscountValue(
      {this.type = '',
      this.amount = 0,
      required this.startDate,
      required this.endDate});

  factory ProductDiscountValue.fromJson(Map<String, dynamic> json) =>
      ProductDiscountValue(
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

  factory ProductDiscountValue.empty() => ProductDiscountValue(
        startDate: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
      );
  static ProductDiscountValue getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDiscountValue.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDiscountValue.empty();
}

class ProductBrand {
  String id;
  String name;

  ProductBrand({this.id = '', this.name = ''});

  factory ProductBrand.fromJson(Map<String, dynamic> json) => ProductBrand(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
  static ProductBrand getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductBrand.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProductBrand();
}

class ProductColor {
  String id;
  String name;
  String hexCode;

  ProductColor({this.id = '', this.name = '', this.hexCode = ''});

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        hexCode: APIHelper.getSafeStringValue(json['hex_code']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'hex_code': hexCode,
      };
  static ProductColor getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductColor.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProductColor();
}

class ProductStore {
  String id;
  String name;
  double totalRating;
  String logo;
  int sellerReviews;
  int positiveSellerReview;
  double avgRating;
  ProductStoreCategory category;
  String type;
  bool isVerified;
  ProductStoreInfo info;
  // TODO: Add info(Same as this object), products(RelatedProduct)

  ProductStore({
    this.id = '',
    this.name = '',
    this.totalRating = 0,
    this.avgRating = 0,
    this.logo = '',
    this.positiveSellerReview = 0,
    this.sellerReviews = 0,
    required this.category,
    this.type = '',
    this.isVerified = false,
    required this.info,
  });

  factory ProductStore.fromJson(Map<String, dynamic> json) => ProductStore(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      logo: APIHelper.getSafeStringValue(json['logo']),
      totalRating: APIHelper.getSafeDoubleValue(json['totalRating']),
      sellerReviews: APIHelper.getSafeIntValue(json['seller_reviews']),
      positiveSellerReview:
          APIHelper.getSafeIntValue(json['positiveSellerReview']),
      avgRating: APIHelper.getSafeDoubleValue(json['avg_rating']),
      category:
          ProductStoreCategory.getAPIResponseObjectSafeValue(json['category']),
      type: APIHelper.getSafeStringValue(json['type']),
      isVerified: APIHelper.getSafeBoolValue(json['verified']),
      info: ProductStoreInfo.getAPIResponseObjectSafeValue(json['info']));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'logo': logo,
        'positiveSellerReview': positiveSellerReview,
        'avg_rating': avgRating,
        'totalRating': totalRating,
        'seller_reviews': sellerReviews,
        'category': category.toJson(),
        'type': type,
        'verified': isVerified,
        'info': info.toJson(),
      };

  factory ProductStore.empty() =>
      ProductStore(category: ProductStoreCategory(), info: ProductStoreInfo());

  static ProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductStore.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProductStore.empty();

  SellerStatus get status {
    return Helper.getSellerStatus(positiveSellerReview);
  }
}

class ProductStoreInfo {
  String id;
  String logo;
  String name;

  ProductStoreInfo({
    this.id = '',
    this.name = '',
    this.logo = '',
  });

  factory ProductStoreInfo.fromJson(Map<String, dynamic> json) =>
      ProductStoreInfo(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'logo': logo,
      };

  static ProductStoreInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductStoreInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductStoreInfo();
}

class ProductStoreCategory {
  String id;
  String name;

  ProductStoreCategory({
    this.id = '',
    this.name = '',
  });

  factory ProductStoreCategory.fromJson(Map<String, dynamic> json) =>
      ProductStoreCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
  static ProductStoreCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductStoreCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductStoreCategory();
}

class Attributes {
  String name;
  List<String> values;

  Attributes({this.name = '', this.values = const []});

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: APIHelper.getSafeStringValue(json['name']),
        values: (APIHelper.getSafeListValue(json['values']))
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'values': values,
      };
  static Attributes getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Attributes.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Attributes();
}

class ProductAttribute {
  String key;
  ProductAttributeOption? selectedOption;
  List<ProductAttributeOption> options;
  String id;
  bool isLoading;

  ProductAttribute(
      {this.key = '',
      this.options = const [],
      this.id = '',
      this.isLoading = false,
      this.selectedOption});

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      key: APIHelper.getSafeStringValue(json['key']),
      options: APIHelper.getSafeListValue(json['options'])
          .map((e) => ProductAttributeOption.fromJson(e))
          .toList(),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'options': options.map((e) => e.toJson()).toList(),
        '_id': id,
      };

  static ProductAttribute getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductAttribute.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductAttribute();

  bool get isProductColorAttribute =>
      options.any((element) => element.isValueHexColorCode);
}

class ProductAttributeOption {
  String label;
  String value;
  double price;
  String id;

  ProductAttributeOption(
      {this.label = '', this.value = '', this.price = 0, this.id = ''});

  factory ProductAttributeOption.fromJson(Map<String, dynamic> json) =>
      ProductAttributeOption(
        label: APIHelper.getSafeStringValue(json['label']),
        value: APIHelper.getSafeStringValue(json['value']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
        'price': price,
        '_id': id,
      };
  static ProductAttributeOption getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductAttributeOption.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductAttributeOption();

  bool get isValueHexColorCode => Helper.isColorCode(value);
}

class ProductDetailsCategory {
  String id;
  String name;

  ProductDetailsCategory({this.id = '', this.name = ''});

  factory ProductDetailsCategory.fromJson(Map<String, dynamic> json) =>
      ProductDetailsCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static ProductDetailsCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsCategory();
}

class ProductDetailsSubCategory {
  String id;
  String name;

  ProductDetailsSubCategory({this.id = '', this.name = ''});

  factory ProductDetailsSubCategory.fromJson(Map<String, dynamic> json) =>
      ProductDetailsSubCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static ProductDetailsSubCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsSubCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsSubCategory();
}

class Specification {
  String key;
  String value;
  String id;

  Specification({this.key = '', this.value = '', this.id = ''});

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        key: APIHelper.getSafeStringValue(json['key']),
        value: APIHelper.getSafeStringValue(json['value']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        '_id': id,
      };
  static Specification getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Specification.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Specification();
}

class DeliveryInfo {
  double delivery;
  double shipping;
  ProductReturn productReturn;

  DeliveryInfo(
      {this.delivery = 0, this.shipping = 0, required this.productReturn});

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => DeliveryInfo(
        delivery: APIHelper.getSafeDoubleValue(json['delivery']),
        shipping: APIHelper.getSafeDoubleValue(json['shipping']),
        productReturn:
            ProductReturn.getAPIResponseObjectSafeValue(json['product_return']),
      );

  Map<String, dynamic> toJson() => {
        'delivery': delivery,
        'shipping': shipping,
        'product_return': productReturn.toJson(),
      };

  factory DeliveryInfo.empty() => DeliveryInfo(
        productReturn: ProductReturn(),
      );

  static DeliveryInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryInfo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DeliveryInfo.empty();
}

class QuantityBasedPrice {
  int minimum;
  int maximum;
  double price;
  String id;

  QuantityBasedPrice(
      {this.minimum = 0, this.maximum = 0, this.price = 0, this.id = ''});

  factory QuantityBasedPrice.fromJson(Map<String, dynamic> json) {
    return QuantityBasedPrice(
      minimum: APIHelper.getSafeIntValue(json['minimum']),
      maximum: APIHelper.getSafeIntValue(json['maximum']),
      price: APIHelper.getSafeDoubleValue(json['price']),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'minimum': minimum,
        'maximum': maximum,
        'price': price,
        '_id': id,
      };

  static QuantityBasedPrice getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? QuantityBasedPrice.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : QuantityBasedPrice();
}

class ProductReturn {
  int days;
  String msg;

  ProductReturn({this.days = 0, this.msg = ''});

  factory ProductReturn.fromJson(Map<String, dynamic> json) => ProductReturn(
        days: APIHelper.getSafeIntValue(json['days']),
        msg: APIHelper.getSafeStringValue(json['msg']),
      );

  Map<String, dynamic> toJson() => {
        'days': days,
        'msg': msg,
      };

  static ProductReturn getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductReturn.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProductReturn();
}

class ProductRatingWiseUser {
  ProductRatingId id;
  int count;

  ProductRatingWiseUser({required this.id, this.count = 0});

  factory ProductRatingWiseUser.fromJson(Map<String, dynamic> json) {
    return ProductRatingWiseUser(
      id: ProductRatingId.getAPIResponseObjectSafeValue(json['_id']),
      count: APIHelper.getSafeIntValue(json['count'], 0),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id.toJson(),
        'count': count,
      };

  factory ProductRatingWiseUser.empty() => ProductRatingWiseUser(
        id: ProductRatingId(),
      );

  static ProductRatingWiseUser getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductRatingWiseUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductRatingWiseUser.empty();
}

class Description {
  String short;
  String long;

  Description({this.short = '', this.long = ''});

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        short: APIHelper.getSafeStringValue(json['short']),
        long: APIHelper.getSafeStringValue(json['long']),
      );

  Map<String, dynamic> toJson() => {
        'short': short,
        'long': long,
      };

  static Description getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Description.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Description();
}

class ProductRatingId {
  double rating;

  ProductRatingId({this.rating = 0});

  factory ProductRatingId.fromJson(Map<String, dynamic> json) =>
      ProductRatingId(
        rating: APIHelper.getSafeDoubleValue(json['rating']),
      );

  Map<String, dynamic> toJson() => {
        'rating': rating,
      };

  static ProductRatingId getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductRatingId.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductRatingId();
}
