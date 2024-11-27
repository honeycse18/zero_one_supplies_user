import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ProductPageResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ProductShortItem> data;

  ProductPageResponse({this.error = false, this.msg = '', required this.data});

  factory ProductPageResponse.fromJson(Map<String, dynamic> json) {
    return ProductPageResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            ProductShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ProductPageResponse.empty() =>
      ProductPageResponse(data: PaginatedDataResponse.empty());

  static ProductPageResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductPageResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductPageResponse.empty();
}

class ProductShortItem {
  String id;
  Store store;
  String name;
  double originalPrice;
  bool newArrival;
  DateTime createdAt;
  String image;
  double rating;
  int totalReview;
  bool discount;
  DiscountValue discountValue;
  double currentPrice;
  bool isFavorite;
  bool isAddedToCart;
  String productCondition;
  ProductDetailsLocation productLocation;
  List<String> tags;

  ProductShortItem({
    this.id = '',
    required this.store,
    this.name = '',
    this.originalPrice = 0,
    this.newArrival = false,
    required this.createdAt,
    this.image = '',
    this.rating = 0,
    this.totalReview = 0,
    this.discount = false,
    required this.discountValue,
    this.currentPrice = 0,
    this.isFavorite = false,
    this.isAddedToCart = false,
    this.productCondition = '',
    required this.productLocation,
    this.tags = const [],
  });

  factory ProductShortItem.fromJson(Map<String, dynamic> json) =>
      ProductShortItem(
          id: APIHelper.getSafeStringValue(json['_id']),
          store: Store.getAPIResponseObjectSafeValue(json['store']),
          name: APIHelper.getSafeStringValue(json['name']),
          originalPrice: APIHelper.getSafeDoubleValue(json['price']),
          newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
          createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
          image: APIHelper.getSafeStringValue(json['image']),
          rating: APIHelper.getSafeDoubleValue(json['rating']),
          totalReview: APIHelper.getSafeIntValue(json['total_review']),
          discount: APIHelper.getSafeBoolValue(json['discount']),
          discountValue: DiscountValue.getAPIResponseObjectSafeValue(
              json['discount_value']),
          currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
          isFavorite: APIHelper.getSafeBoolValue(json['isFavorite']),
          isAddedToCart: APIHelper.getSafeBoolValue(json['isAddedToCart']),
          productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
              json['product_location']),
          productCondition:
              APIHelper.getSafeStringValue(json['product_condition']),
          tags: APIHelper.getSafeListValue(json['tags'])
              .map((e) => APIHelper.getSafeStringValue(e))
              .toList());

  Map<String, dynamic> toJson() => {
        '_id': id,
        'store': store.toJson(),
        'name': name,
        'price': originalPrice,
        'new_arrival': newArrival,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        'rating': rating,
        'total_review': totalReview,
        'discount': discount,
        'discount_value': discountValue.toJson(),
        'current_price': currentPrice,
        'isFavorite': isFavorite,
        'isAddedToCart': isAddedToCart,
        'product_condition': productCondition,
        'product_location': productLocation.toJson(),
        'tags': tags,
      };
  factory ProductShortItem.empty() => ProductShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        discountValue: DiscountValue.empty(),
        store: Store(),
        productLocation: ProductDetailsLocation.empty(),
      );

  static ProductShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductShortItem.empty();

  ProductConditionStatus get productConditionStatus =>
      ProductConditionStatus.toEnumValue(productCondition);
}

//=======Discount Value============
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
//=========Store================

class Store {
  String id;
  String name;
  bool isVerified;

  Store({this.id = '', this.name = '', this.isVerified = false});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static Store getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Store.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Store();
}
