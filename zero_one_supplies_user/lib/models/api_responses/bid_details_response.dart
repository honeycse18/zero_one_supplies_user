import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';

class BidDetailsResponse {
  bool error;
  String msg;
  BidDetails data;

  BidDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory BidDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BidDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: BidDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory BidDetailsResponse.empty() =>
      BidDetailsResponse(data: BidDetails.empty());

  static BidDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsResponse.empty();
}

class BidDetails {
  String id;
  BidDetailsProduct product;
  DateTime startDate;
  DateTime endDate;
  List<BidDetailsBidUser> bidUsers;
  double currentPrice;
  bool status;
  DateTime createdAt;
  bool isEnd;
  AuctionDetailsStoreShortItem store;

  BidDetails({
    this.id = '',
    required this.product,
    required this.startDate,
    required this.endDate,
    this.bidUsers = const [],
    this.currentPrice = 0,
    this.status = false,
    required this.createdAt,
    this.isEnd = false,
    required this.store,
  });

  factory BidDetails.fromJson(Map<String, dynamic> json) => BidDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        product:
            BidDetailsProduct.getAPIResponseObjectSafeValue(json['product']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        bidUsers: APIHelper.getSafeListValue(json['bid_users'])
            .map((e) => BidDetailsBidUser.getAPIResponseObjectSafeValue(e))
            .toList(),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        status: APIHelper.getSafeBoolValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        isEnd: APIHelper.getSafeBoolValue(json['is_end']),
        store: AuctionDetailsStoreShortItem.getAPIResponseObjectSafeValue(
            json['store']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'product': product.toJson(),
        'start_date': startDate,
        'end_date': endDate,
        'bid_users': bidUsers.map((e) => e.toJson()).toList(),
        'current_price': currentPrice,
        'status': status,
        'createdAt': createdAt,
        'is_end': isEnd,
        'store': store.toJson(),
      };

  factory BidDetails.empty() => BidDetails(
      store: AuctionDetailsStoreShortItem.empty(),
      product: BidDetailsProduct.empty(),
      startDate: AppComponents.defaultUnsetDateTime,
      endDate: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime);

  static BidDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : BidDetails.empty();
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

class BidDetailsProduct {
  String id;
  BidDetailsProductStore store;
  String name;
  List<BidDetailsProductCategory> categories;
  List<BidDetailsProductSubcategory> subcategories;
  List<String> galleryImages;
  List<BidDetailsProductSpecification> specifications;
  String image;
  double rating;
  BidDetailsProductDeliveryInfo deliveryInfo;
  BidDetailsProductReview reviews;
  String description;

  BidDetailsProduct({
    this.id = '',
    required this.store,
    this.name = '',
    this.categories = const [],
    this.subcategories = const [],
    this.galleryImages = const [],
    this.specifications = const [],
    this.image = '',
    this.rating = 0,
    required this.deliveryInfo,
    required this.reviews,
    this.description = '',
  });

  factory BidDetailsProduct.fromJson(Map<String, dynamic> json) =>
      BidDetailsProduct(
        id: APIHelper.getSafeStringValue(json['_id']),
        store:
            BidDetailsProductStore.getAPIResponseObjectSafeValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        categories: (APIHelper.getSafeListValue(json['categories']))
            .map((e) =>
                BidDetailsProductCategory.getAPIResponseObjectSafeValue(e))
            .toList(),
        subcategories: (APIHelper.getSafeListValue(json['subcategories']))
            .map((e) =>
                BidDetailsProductSubcategory.getAPIResponseObjectSafeValue(e))
            .toList(),
        galleryImages: APIHelper.getSafeListValue(json['gallery_images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        specifications: (APIHelper.getSafeListValue(json['specifications']))
            .map((e) =>
                BidDetailsProductSpecification.getAPIResponseObjectSafeValue(e))
            .toList(),
        image: APIHelper.getSafeStringValue(json['image']),
        rating: APIHelper.getSafeDoubleValue(json['rating']),
        deliveryInfo:
            BidDetailsProductDeliveryInfo.getAPIResponseObjectSafeValue(
                json['delivery_info']),
        reviews: BidDetailsProductReview.getAPIResponseObjectSafeValue(
            json['reviews']),
        description: APIHelper.getSafeStringValue(json['description']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'store': store.toJson(),
        'name': name,
        'categories': categories.map((e) => e.toJson()).toList(),
        'subcategories': subcategories.map((e) => e.toJson()).toList(),
        'gallery_images': galleryImages,
        'specifications': specifications.map((e) => e.toJson()).toList(),
        'image': image,
        'rating': rating,
        'delivery_info': deliveryInfo.toJson(),
        'reviews': reviews.toJson(),
        'description': description,
      };

  factory BidDetailsProduct.empty() => BidDetailsProduct(
      store: BidDetailsProductStore(info: BidDetailsProductStoreInfo()),
      deliveryInfo: BidDetailsProductDeliveryInfo.empty(),
      reviews: BidDetailsProductReview());

  static BidDetailsProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProduct.empty();
}

class BidDetailsProductCategory {
  String id;
  String name;

  BidDetailsProductCategory({this.id = '', this.name = ''});

  factory BidDetailsProductCategory.fromJson(Map<String, dynamic> json) =>
      BidDetailsProductCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
  static BidDetailsProductCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProductCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProductCategory();
}

class BidDetailsProductDeliveryInfo {
  final double delivery;
  final double shipping;
  final BidDetailsProductDeliveryInfoProductReturn productReturn;
  BidDetailsProductDeliveryInfo(
      {this.delivery = 0, this.shipping = 0, required this.productReturn});

  factory BidDetailsProductDeliveryInfo.fromJson(Map<String, dynamic> json) =>
      BidDetailsProductDeliveryInfo(
        delivery: APIHelper.getSafeDoubleValue(json['delivery']),
        shipping: APIHelper.getSafeDoubleValue(json['shipping']),
        productReturn: BidDetailsProductDeliveryInfoProductReturn
            .getAPIResponseObjectSafeValue(json['product_return']),
      );

  Map<String, dynamic> toJson() {
    return {
      'delivery': delivery,
      'shipping': shipping,
      'product_return': productReturn.toJson(),
    };
  }

  factory BidDetailsProductDeliveryInfo.empty() =>
      BidDetailsProductDeliveryInfo(
          productReturn: BidDetailsProductDeliveryInfoProductReturn());

  static BidDetailsProductDeliveryInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProductDeliveryInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProductDeliveryInfo.empty();
}

class BidDetailsProductDeliveryInfoProductReturn {
  final int days;
  final String msg;
  BidDetailsProductDeliveryInfoProductReturn({this.days = 0, this.msg = ''});

  factory BidDetailsProductDeliveryInfoProductReturn.fromJson(
          Map<String, dynamic> json) =>
      BidDetailsProductDeliveryInfoProductReturn(
        days: APIHelper.getSafeIntValue(json['days']),
        msg: APIHelper.getSafeStringValue(json['msg']),
      );

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'msg': msg,
    };
  }

  static BidDetailsProductDeliveryInfoProductReturn
      getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? BidDetailsProductDeliveryInfoProductReturn.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : BidDetailsProductDeliveryInfoProductReturn();
}

class BidDetailsProductReview {
  BidDetailsProductReview();

  factory BidDetailsProductReview.fromJson(Map<String, dynamic> json) =>
      BidDetailsProductReview();

  Map<String, dynamic> toJson() {
    return {};
  }

  static BidDetailsProductReview getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProductReview.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProductReview();
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

class BidDetailsProductStore {
  String id;
  String name;
  bool isVerified;
  BidDetailsProductStoreInfo info;

  BidDetailsProductStore({
    this.id = '',
    this.name = '',
    this.isVerified = false,
    required this.info,
  });

  factory BidDetailsProductStore.fromJson(Map<String, dynamic> json) =>
      BidDetailsProductStore(
          id: APIHelper.getSafeStringValue(json['_id']),
          name: APIHelper.getSafeStringValue(json['name']),
          isVerified: APIHelper.getSafeBoolValue(json['verified']),
          info: BidDetailsProductStoreInfo.getAPIResponseObjectSafeValue(
              json['info']));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
        'info': info.toJson(),
      };

  factory BidDetailsProductStore.empty() =>
      BidDetailsProductStore(info: BidDetailsProductStoreInfo());

  static BidDetailsProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProductStore.empty();
}

class BidDetailsProductStoreInfo {
  String id;
  String logo;
  String name;

  BidDetailsProductStoreInfo({
    this.id = '',
    this.name = '',
    this.logo = '',
  });

  factory BidDetailsProductStoreInfo.fromJson(Map<String, dynamic> json) =>
      BidDetailsProductStoreInfo(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'logo': logo,
      };

  static BidDetailsProductStoreInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProductStoreInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProductStoreInfo();
}

class BidDetailsProductSubcategory {
  String id;
  String name;

  BidDetailsProductSubcategory({this.id = '', this.name = ''});

  factory BidDetailsProductSubcategory.fromJson(Map<String, dynamic> json) =>
      BidDetailsProductSubcategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
  static BidDetailsProductSubcategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BidDetailsProductSubcategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BidDetailsProductSubcategory();
}
//=====================================================

class AuctionDetailsStoreShortItem {
  double totalRating;
  String name;
  String logo;
  AuctionStoreCategory category;
  String id;
  int sellerReviews;
  int positiveSellerReview;
  double avgRating;
  String type;
  bool isVerified;

  AuctionDetailsStoreShortItem({
    this.totalRating = 0,
    this.name = '',
    this.logo = '',
    required this.category,
    this.id = '',
    this.sellerReviews = 0,
    this.positiveSellerReview = 0,
    this.avgRating = 0,
    this.type = '',
    this.isVerified = false,
  });

  factory AuctionDetailsStoreShortItem.fromJson(Map<String, dynamic> json) =>
      AuctionDetailsStoreShortItem(
        totalRating: APIHelper.getSafeDoubleValue(json['totalRating']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        category: AuctionStoreCategory.getAPIResponseObjectSafeValue(
            json['category']),
        id: APIHelper.getSafeStringValue(json['_id']),
        sellerReviews: APIHelper.getSafeIntValue(json['seller_reviews']),
        positiveSellerReview:
            APIHelper.getSafeIntValue(json['positiveSellerReview']),
        avgRating: APIHelper.getSafeDoubleValue(json['avg_rating']),
        type: APIHelper.getSafeStringValue(json['type']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        'totalRating': totalRating,
        'name': name,
        'logo': logo,
        'category': category.toJson(),
        '_id': id,
        'seller_reviews': sellerReviews,
        'positiveSellerReview': positiveSellerReview,
        'avg_rating': avgRating,
        'type': type,
        'verified': isVerified,
      };

  factory AuctionDetailsStoreShortItem.empty() => AuctionDetailsStoreShortItem(
        category: AuctionStoreCategory(),
      );

  static AuctionDetailsStoreShortItem getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionDetailsStoreShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionDetailsStoreShortItem.empty();

  SellerStatus get status {
    return Helper.getSellerStatus(positiveSellerReview);
  }
}

class AuctionDetailsStoreCategory {
  String id;
  String name;

  AuctionDetailsStoreCategory({
    this.id = '',
    this.name = '',
  });

  factory AuctionDetailsStoreCategory.fromJson(Map<String, dynamic> json) =>
      AuctionDetailsStoreCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
  static AuctionDetailsStoreCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionDetailsStoreCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionDetailsStoreCategory();
}

//=============================================

class AuctionStoreCategory {
  String id;
  String name;

  AuctionStoreCategory({this.id = '', this.name = ''});

  factory AuctionStoreCategory.fromJson(Map<String, dynamic> json) =>
      AuctionStoreCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static AuctionStoreCategory getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionStoreCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionStoreCategory();
}
