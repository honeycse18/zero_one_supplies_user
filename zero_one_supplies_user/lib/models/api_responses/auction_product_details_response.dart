import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class AuctionProductDetailsResponse {
  bool error;
  String msg;
  AuctionProductDetails data;

  AuctionProductDetailsResponse(
      {this.error = false, required this.data, this.msg = ''});

  factory AuctionProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    return AuctionProductDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: AuctionProductDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory AuctionProductDetailsResponse.empty() =>
      AuctionProductDetailsResponse(data: AuctionProductDetails.empty());
  static AuctionProductDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductDetailsResponse.empty();
}

class AuctionProductDetails {
  String id;
  Store store;
  String name;
  String model;
  List<AuctionProductCategory> categories;
  List<AuctionProductSubcategory> subcategories;
  AuctionProductQuantity quantity;
  List<String> tags;
  List<String> galleryImages;
  bool stockAvailable;
  bool stockVisibility;
  bool flashDeal;
  bool newArrival;
  bool userRequested;
  bool isStatus;
  List<dynamic> quantityBasedPrice;
  List<AuctionProductAttribute> attribute;
  DateTime createdAt;
  DateTime updatedAt;
  AuctionProductBrand brand;
  String unit;
  ProductDetailsLocation productLocation;
  AuctionProductDescription description;
  String specificationDescription;
  String productImage;
  String thumbImage;
  AuctionProductDeliveryInfo deliveryInfo;
  List<AuctionProductRelatedProduct> relatedProducts;
  AuctionProductAuctionInfo auctionInfo;
  List<BidDetailsProductSpecification> specification;
  bool isFavorite;

  AuctionProductDetails({
    this.id = '',
    required this.store,
    this.name = '',
    this.model = '',
    this.categories = const [],
    this.subcategories = const [],
    required this.quantity,
    this.tags = const [],
    this.galleryImages = const [],
    this.stockAvailable = false,
    this.stockVisibility = false,
    this.flashDeal = false,
    this.newArrival = false,
    this.userRequested = false,
    this.isStatus = false,
    this.quantityBasedPrice = const [],
    this.attribute = const [],
    required this.createdAt,
    required this.updatedAt,
    required this.brand,
    this.unit = '',
    required this.productLocation,
    required this.description,
    this.specificationDescription = '',
    this.productImage = '',
    this.thumbImage = '',
    required this.deliveryInfo,
    this.relatedProducts = const [],
    required this.auctionInfo,
    this.specification = const [],
    this.isFavorite = false,
  });

  factory AuctionProductDetails.fromJson(Map<String, dynamic> json) =>
      AuctionProductDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        store: Store.getAPIResponseObjectSafeValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        model: APIHelper.getSafeStringValue(json['model']),
        categories: APIHelper.getSafeListValue(json['categories'])
            .map((e) => AuctionProductCategory.getAPIResponseObjectSafeValue(e))
            .toList(),
        subcategories: APIHelper.getSafeListValue(json['subcategories'])
            .map((e) =>
                AuctionProductSubcategory.getAPIResponseObjectSafeValue(e))
            .toList(),
        quantity: AuctionProductQuantity.getAPIResponseObjectSafeValue(
            json['quantity']),
        tags: APIHelper.getSafeListValue(json['tags']),
        galleryImages: APIHelper.getSafeListValue(json['gallery_images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        stockAvailable: APIHelper.getSafeBoolValue(json['stock_available']),
        stockVisibility: APIHelper.getSafeBoolValue(json['stock_visibility']),
        flashDeal: APIHelper.getSafeBoolValue(json['flash_deal']),
        newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
        userRequested: APIHelper.getSafeBoolValue(json['user_requested']),
        isStatus: APIHelper.getSafeBoolValue(json['is_status']),
        quantityBasedPrice:
            APIHelper.getSafeListValue(json['quantity_based_price']),
        attribute: APIHelper.getSafeListValue(json['attribute'])
            .map(
                (e) => AuctionProductAttribute.getAPIResponseObjectSafeValue(e))
            .toList(),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        brand: AuctionProductBrand.getAPIResponseObjectSafeValue(json['brand']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
            json['product_location']),
        description: AuctionProductDescription.getAPIResponseObjectSafeValue(
            json['description']),
        specificationDescription:
            APIHelper.getSafeStringValue(json['specification_description']),
        productImage: APIHelper.getSafeStringValue(json['product_image']),
        thumbImage: APIHelper.getSafeStringValue(json['thumb_image']),
        deliveryInfo: AuctionProductDeliveryInfo.getAPIResponseObjectSafeValue(
            json['delivery_info']),
        relatedProducts: APIHelper.getSafeListValue(json['related_products']),
        auctionInfo: AuctionProductAuctionInfo.getAPIResponseObjectSafeValue(
            json['auction_info']),
        specification: APIHelper.getSafeListValue(json['specifications'])
            .map((e) =>
                BidDetailsProductSpecification.getAPIResponseObjectSafeValue(e))
            .toList(),
        isFavorite: APIHelper.getSafeBoolValue(json['isFavorite']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'store': store.toJson(),
        'name': name,
        'model': model,
        'categories': categories.map((e) => e.toJson()).toList(),
        'subcategories': subcategories.map((e) => e.toJson()).toList(),
        'quantity': quantity.toJson(),
        'tags': tags,
        'gallery_images': galleryImages,
        'stock_available': stockAvailable,
        'stock_visibility': stockVisibility,
        'flash_deal': flashDeal,
        'new_arrival': newArrival,
        'user_requested': userRequested,
        'is_status': isStatus,
        'quantity_based_price': quantityBasedPrice,
        'attribute': attribute.map((e) => e.toJson()).toList(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'brand': brand.toJson(),
        'unit': unit,
        'product_location': productLocation.toJson(),
        'description': description.toJson(),
        'specification_description': specificationDescription,
        'product_image': productImage,
        'thumb_image': thumbImage,
        'delivery_info': deliveryInfo.toJson(),
        'related_products': relatedProducts.map((e) => e.toJson()).toList(),
        'auction_info': auctionInfo.toJson(),
        'specifications': specification.map((e) => e.toJson()).toList(),
        'isFavorite': isFavorite,
      };

  factory AuctionProductDetails.empty() => AuctionProductDetails(
        auctionInfo: AuctionProductAuctionInfo.empty(),
        brand: AuctionProductBrand(),
        deliveryInfo: AuctionProductDeliveryInfo.empty(),
        store: Store.empty(),
        quantity: AuctionProductQuantity(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        productLocation: ProductDetailsLocation.empty(),
        description: AuctionProductDescription(),
      );
  static AuctionProductDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductDetails.empty();
}

class Store {
  List<AuctionProductRelatedProductProduct> products;
  Info info;
  String status;
  bool verified;

  Store({
    this.products = const [],
    required this.info,
    this.status = '',
    this.verified = false,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        status: APIHelper.getSafeStringValue(json['status']),
        verified: APIHelper.getSafeBoolValue(json['verified']),
        products: APIHelper.getSafeListValue(json['products']),
        info: Info.getAPIResponseObjectSafeValue(json['info']),
      );

  Map<String, dynamic> toJson() => {
        'products': products.map((e) => e.toJson()).toList(),
        'info': info.toJson(),
        'status': status,
        'verified': verified,
      };

  factory Store.empty() => Store(info: Info.empty());
  static Store getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Store.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Store.empty();
}

class Info {
  int totalRating;
  String name;
  String logo;
  Category category;
  bool verified;
  String id;
  int sellerReviews;
  int positiveSellerReview;
  double avgRating;
  String type;

  Info({
    this.totalRating = 0,
    this.name = '',
    this.logo = '',
    required this.category,
    this.verified = false,
    this.id = '',
    this.sellerReviews = 0,
    this.avgRating = 0,
    this.type = '',
    this.positiveSellerReview = 0,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        totalRating: APIHelper.getSafeIntValue(json['totalRating']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
        verified: APIHelper.getSafeBoolValue(json['verified']),
        id: APIHelper.getSafeStringValue(json['_id']),
        sellerReviews: APIHelper.getSafeIntValue(json['seller_reviews']),
        positiveSellerReview:
            APIHelper.getSafeIntValue(json['positiveSellerReview']),
        avgRating: APIHelper.getSafeDoubleValue(json['avg_rating']),
        type: APIHelper.getSafeStringValue(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'totalRating': totalRating,
        'name': name,
        'logo': logo,
        'category': category.toJson(),
        'verified': verified,
        '_id': id,
        'seller_reviews': sellerReviews,
        'positiveSellerReview': positiveSellerReview,
        'avg_rating': avgRating,
        'type': type,
      };

  factory Info.empty() => Info(category: Category());
  static Info getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Info.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Info.empty();

  SellerStatus get storeType => SellerStatus.toEnumValueFromViewable(type);
}

class Category {
  String id;
  String name;

  Category({this.id = '', this.name = ''});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category();
}

class AuctionProductRelatedProduct {
  String id;
  String name;
  int price;
  bool newArrival;
  bool isAuction;
  DateTime createdAt;
  String image;
  int rating;
  bool discount;
  AuctionProductRelatedProductDiscountValue discountValue;
  int currentPrice;
  bool isFavorite;
  DateTime startDate;
  DateTime endDate;
  bool isEnd;
  AuctionProductRelatedProductProduct product;
  int currentAuctionPrice;

  AuctionProductRelatedProduct({
    this.id = '',
    this.name = '',
    this.price = 0,
    this.newArrival = false,
    this.isAuction = false,
    required this.createdAt,
    this.image = '',
    this.rating = 0,
    this.discount = false,
    required this.discountValue,
    this.currentPrice = 0,
    this.isFavorite = false,
    required this.startDate,
    required this.endDate,
    this.isEnd = false,
    required this.product,
    this.currentAuctionPrice = 0,
  });

  factory AuctionProductRelatedProduct.fromJson(Map<String, dynamic> json) {
    return AuctionProductRelatedProduct(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      price: APIHelper.getSafeIntValue(json['price']),
      newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
      isAuction: APIHelper.getSafeBoolValue(json['is_auction']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      image: APIHelper.getSafeStringValue(json['image']),
      rating: APIHelper.getSafeIntValue(json['rating']),
      discount: APIHelper.getSafeBoolValue(json['discount']),
      discountValue: (json['discount_value']),
      currentPrice: APIHelper.getSafeIntValue(json['current_price']),
      isFavorite: APIHelper.getSafeBoolValue(json['isFavorite']),
      startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
      endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
      isEnd: APIHelper.getSafeBoolValue(json['is_end']),
      product: (json['product']),
      currentAuctionPrice:
          APIHelper.getSafeIntValue(json['current_auction_price']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'price': price,
        'new_arrival': newArrival,
        'is_auction': isAuction,
        'createdAt': createdAt,
        'image': image,
        'rating': rating,
        'discount': discount,
        'discount_value': discountValue.toJson(),
        'current_price': currentPrice,
        'isFavorite': isFavorite,
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'is_end': isEnd,
        'product': product.toJson(),
        'current_auction_price': currentAuctionPrice,
      };

  factory AuctionProductRelatedProduct.empty() => AuctionProductRelatedProduct(
        discountValue: AuctionProductRelatedProductDiscountValue.empty(),
        endDate: AppComponents.defaultUnsetDateTime,
        startDate: AppComponents.defaultUnsetDateTime,
        product: AuctionProductRelatedProductProduct.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
      );
  static AuctionProductRelatedProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductRelatedProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductRelatedProduct.empty();
}

class AuctionProductRelatedProductDiscountValue {
  String type;
  double amount;
  DateTime startDate;
  DateTime endDate;

  AuctionProductRelatedProductDiscountValue(
      {this.type = '',
      this.amount = 0,
      required this.startDate,
      required this.endDate});

  factory AuctionProductRelatedProductDiscountValue.fromJson(
          Map<String, dynamic> json) =>
      AuctionProductRelatedProductDiscountValue(
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

  factory AuctionProductRelatedProductDiscountValue.empty() =>
      AuctionProductRelatedProductDiscountValue(
        endDate: AppComponents.defaultUnsetDateTime,
        startDate: AppComponents.defaultUnsetDateTime,
      );
  static AuctionProductRelatedProductDiscountValue
      getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? AuctionProductRelatedProductDiscountValue.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : AuctionProductRelatedProductDiscountValue.empty();
}

class AuctionProductRelatedProductProduct {
  String id;
  String name;
  int price;
  bool newArrival;
  DateTime createdAt;
  String image;
  int rating;
  bool discount;
  AuctionProductRelatedProductDiscountValue discountValue;
  int currentPrice;

  AuctionProductRelatedProductProduct({
    this.id = '',
    this.name = '',
    this.price = 0,
    this.newArrival = false,
    required this.createdAt,
    this.image = '',
    this.rating = 0,
    this.discount = false,
    required this.discountValue,
    this.currentPrice = 0,
  });

  factory AuctionProductRelatedProductProduct.fromJson(
          Map<String, dynamic> json) =>
      AuctionProductRelatedProductProduct(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        price: APIHelper.getSafeIntValue(json['price']),
        newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        image: APIHelper.getSafeStringValue(json['image']),
        rating: APIHelper.getSafeIntValue(json['rating']),
        discount: APIHelper.getSafeBoolValue(json['discount']),
        discountValue: (json['discount_value']),
        currentPrice: APIHelper.getSafeIntValue(json['current_price']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'price': price,
        'new_arrival': newArrival,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        'rating': rating,
        'discount': discount,
        'discount_value': discountValue.toJson(),
        'current_price': currentPrice,
      };

  factory AuctionProductRelatedProductProduct.empty() =>
      AuctionProductRelatedProductProduct(
        discountValue: AuctionProductRelatedProductDiscountValue.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
      );
  static AuctionProductRelatedProductProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductRelatedProductProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductRelatedProductProduct.empty();
}

class AuctionProductCategory {
  String id;
  String name;

  AuctionProductCategory({this.id = '', this.name = ''});

  factory AuctionProductCategory.fromJson(Map<String, dynamic> json) =>
      AuctionProductCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static AuctionProductCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductCategory();
}

class AuctionProductSubcategory {
  String id;
  String name;

  AuctionProductSubcategory({this.id = '', this.name = ''});

  factory AuctionProductSubcategory.fromJson(Map<String, dynamic> json) =>
      AuctionProductSubcategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static AuctionProductSubcategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductSubcategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductSubcategory();
}

class AuctionProductQuantity {
  int unitQuantity;
  int stockQuantity;
  int minPurchaseQuantity;
  int stockAlertQuantity;

  AuctionProductQuantity({
    this.unitQuantity = 0,
    this.stockQuantity = 0,
    this.minPurchaseQuantity = 0,
    this.stockAlertQuantity = 0,
  });

  factory AuctionProductQuantity.fromJson(Map<String, dynamic> json) =>
      AuctionProductQuantity(
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

  static AuctionProductQuantity getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductQuantity.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductQuantity();
}

class AuctionProductAttribute {
  String key;
  List<AuctionProductAttributeOption> options;
  String id;

  AuctionProductAttribute(
      {this.key = '', this.options = const [], this.id = ''});

  factory AuctionProductAttribute.fromJson(Map<String, dynamic> json) =>
      AuctionProductAttribute(
        key: APIHelper.getSafeStringValue(json['key']),
        options: APIHelper.getSafeListValue(json['options']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'options': options.map((e) => e.toJson()).toList(),
        '_id': id,
      };

  static AuctionProductAttribute getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductAttribute.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductAttribute();
}

class AuctionProductAttributeOption {
  String label;
  int price;
  String id;

  AuctionProductAttributeOption(
      {this.label = '', this.price = 0, this.id = ''});

  factory AuctionProductAttributeOption.fromJson(Map<String, dynamic> json) =>
      AuctionProductAttributeOption(
        label: APIHelper.getSafeStringValue(json['label']),
        price: APIHelper.getSafeIntValue(json['price']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'price': price,
        '_id': id,
      };

  static AuctionProductAttributeOption getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductAttributeOption.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductAttributeOption();
}

class AuctionProductBrand {
  String id;
  String name;

  AuctionProductBrand({this.id = '', this.name = ''});

  factory AuctionProductBrand.fromJson(Map<String, dynamic> json) =>
      AuctionProductBrand(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static AuctionProductBrand getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductBrand.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductBrand();
}

class AuctionProductLocation {
  String type;
  AuctionProductLocationReplayPoint replayPoint;

  AuctionProductLocation({this.type = '', required this.replayPoint});

  factory AuctionProductLocation.fromJson(Map<String, dynamic> json) {
    return AuctionProductLocation(
      type: APIHelper.getSafeStringValue(json['type']),
      replayPoint:
          AuctionProductLocationReplayPoint.getAPIResponseObjectSafeValue(
              json['replay_point']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'replay_point': replayPoint.toJson(),
      };

  factory AuctionProductLocation.empty() => AuctionProductLocation(
      replayPoint: AuctionProductLocationReplayPoint.empty());
  static AuctionProductLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductLocation.empty();
}

class AuctionProductLocationReplayPoint {
  AuctionProductLocationReplayPointLocation location;
  String id;
  String name;
  String address;

  AuctionProductLocationReplayPoint(
      {required this.location,
      this.id = '',
      this.name = '',
      this.address = ''});

  factory AuctionProductLocationReplayPoint.fromJson(
          Map<String, dynamic> json) =>
      AuctionProductLocationReplayPoint(
        location: AuctionProductLocationReplayPointLocation
            .getAPIResponseObjectSafeValue(json['location']),
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        '_id': id,
        'name': name,
        'address': address,
      };

  factory AuctionProductLocationReplayPoint.empty() =>
      AuctionProductLocationReplayPoint(
          location: AuctionProductLocationReplayPointLocation());
  static AuctionProductLocationReplayPoint getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductLocationReplayPoint.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductLocationReplayPoint.empty();
}

class AuctionProductLocationReplayPointLocation {
  double latitude;
  double longitude;

  AuctionProductLocationReplayPointLocation(
      {this.latitude = 0, this.longitude = 0});

  factory AuctionProductLocationReplayPointLocation.fromJson(
          Map<String, dynamic> json) =>
      AuctionProductLocationReplayPointLocation(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static AuctionProductLocationReplayPointLocation
      getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? AuctionProductLocationReplayPointLocation.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : AuctionProductLocationReplayPointLocation();
}

class AuctionProductDescription {
  String short;
  String long;

  AuctionProductDescription({this.short = '', this.long = ''});

  factory AuctionProductDescription.fromJson(Map<String, dynamic> json) =>
      AuctionProductDescription(
        short: APIHelper.getSafeStringValue(json['short']),
        long: APIHelper.getSafeStringValue(json['long']),
      );

  Map<String, dynamic> toJson() => {
        'short': short,
        'long': long,
      };

  static AuctionProductDescription getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductDescription.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductDescription();
}

class AuctionProductDeliveryInfo {
  int delivery;
  int shipping;
  AuctionProductDeliveryInfoProductReturn productReturn;

  AuctionProductDeliveryInfo(
      {this.delivery = 0, this.shipping = 0, required this.productReturn});

  factory AuctionProductDeliveryInfo.fromJson(Map<String, dynamic> json) =>
      AuctionProductDeliveryInfo(
        delivery: APIHelper.getSafeIntValue(json['delivery']),
        shipping: APIHelper.getSafeIntValue(json['shipping']),
        productReturn: AuctionProductDeliveryInfoProductReturn
            .getAPIResponseObjectSafeValue(json['product_return']),
      );

  Map<String, dynamic> toJson() => {
        'delivery': delivery,
        'shipping': shipping,
        'product_return': productReturn.toJson(),
      };

  factory AuctionProductDeliveryInfo.empty() => AuctionProductDeliveryInfo(
      productReturn: AuctionProductDeliveryInfoProductReturn());
  static AuctionProductDeliveryInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductDeliveryInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductDeliveryInfo.empty();
}

class AuctionProductDeliveryInfoProductReturn {
  int days;
  String msg;

  AuctionProductDeliveryInfoProductReturn({this.days = 0, this.msg = ''});

  factory AuctionProductDeliveryInfoProductReturn.fromJson(
          Map<String, dynamic> json) =>
      AuctionProductDeliveryInfoProductReturn(
        days: APIHelper.getSafeIntValue(json['days']),
        msg: APIHelper.getSafeStringValue(json['msg']),
      );

  Map<String, dynamic> toJson() => {
        'days': days,
        'msg': msg,
      };

  static AuctionProductDeliveryInfoProductReturn getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductDeliveryInfoProductReturn.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductDeliveryInfoProductReturn();
}

class BidDetailsProductSpecification {
  String key;
  String value;
  String id;

  BidDetailsProductSpecification(
      {this.key = '', this.value = '', this.id = ''});

  factory BidDetailsProductSpecification.fromJson(Map<String, dynamic> json) =>
      BidDetailsProductSpecification(
        key: APIHelper.getSafeStringValue(json['key']),
        value: APIHelper.getSafeStringValue(json['value']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
        '_id': id,
      };

  static BidDetailsProductSpecification getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProductSpecification.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProductSpecification();
}

class BidDetailsBidUser {
  String id;
  String firstName;
  String lastName;
  String image;
  double bidAmount;
  DateTime date;

  BidDetailsBidUser(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.image = '',
      this.bidAmount = 0,
      required this.date});

  factory BidDetailsBidUser.fromJson(Map<String, dynamic> json) =>
      BidDetailsBidUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        image: APIHelper.getSafeStringValue(json['image']),
        bidAmount: APIHelper.getSafeDoubleValue(json['bid_amount']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'image': image,
        'bid_amount': bidAmount,
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
      };

  factory BidDetailsBidUser.empty() =>
      BidDetailsBidUser(date: AppComponents.defaultUnsetDateTime);

  static BidDetailsBidUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsBidUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsBidUser.empty();
}

class AuctionProductAuctionInfo {
  String id;
  String winner;
  DateTime startDate;
  DateTime endDate;
  bool isEnd;
  double currentPrice;
  DateTime createdAt;
  DateTime updatedAt;
  List<BidDetailsBidUser> bidUsers;
  bool isBid;

  AuctionProductAuctionInfo({
    this.id = '',
    this.winner = '',
    required this.startDate,
    required this.endDate,
    this.isEnd = false,
    this.currentPrice = 0,
    required this.createdAt,
    required this.updatedAt,
    this.bidUsers = const [],
    this.isBid = false,
  });

  factory AuctionProductAuctionInfo.fromJson(Map<String, dynamic> json) =>
      AuctionProductAuctionInfo(
        id: APIHelper.getSafeStringValue(json['_id']),
        winner: APIHelper.getSafeStringValue(json['winner']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        isEnd: APIHelper.getSafeBoolValue(json['is_end']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        bidUsers: APIHelper.getSafeListValue(json['bid_users'])
            .map((e) => BidDetailsBidUser.getAPIResponseObjectSafeValue(e))
            .toList(),
        isBid: APIHelper.getSafeBoolValue(json['is_bid']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'winner': winner,
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'is_end': isEnd,
        'current_price': currentPrice,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'bid_users': bidUsers,
        'is_bid': isBid,
      };

  factory AuctionProductAuctionInfo.empty() => AuctionProductAuctionInfo(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
        startDate: AppComponents.defaultUnsetDateTime,
      );
  static AuctionProductAuctionInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionProductAuctionInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionProductAuctionInfo.empty();
}
