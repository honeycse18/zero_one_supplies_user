import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class WishlistResponse {
  bool error;
  String msg;
  WishlistDataResponse data;

  WishlistResponse({this.error = false, this.msg = '', required this.data});

  factory WishlistResponse.fromJson(Map<String, dynamic> json) {
    return WishlistResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: WishlistDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory WishlistResponse.empty() =>
      WishlistResponse(data: WishlistDataResponse.empty());

  static WishlistResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WishlistResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WishlistResponse.empty();
}

class WishlistDataResponse {
  FavoritesResponse favorites;

  WishlistDataResponse({required this.favorites});

  factory WishlistDataResponse.fromJson(Map<String, dynamic> json) =>
      WishlistDataResponse(
        favorites:
            FavoritesResponse.getAPIResponseObjectSafeValue(json['favorites']),
      );

  Map<String, dynamic> toJson() => {
        'favorites': favorites.toJson(),
      };

  factory WishlistDataResponse.empty() =>
      WishlistDataResponse(favorites: FavoritesResponse.empty());

  static WishlistDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WishlistDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WishlistDataResponse.empty();
}

class FavoritesResponse {
  List<WishlistDocResponse> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;

  FavoritesResponse({
    required this.docs,
    this.totalDocs = 0,
    this.limit = 0,
    this.page = 0,
    this.totalPages = 0,
    this.pagingCounter = 0,
    this.hasPrevPage = false,
    this.hasNextPage = false,
    this.prevPage = 0,
    this.nextPage = 0,
  });

  factory FavoritesResponse.fromJson(Map<String, dynamic> json) =>
      FavoritesResponse(
        docs: APIHelper.getSafeListValue(json['docs'])
            .map((e) => WishlistDocResponse.getAPIResponseObjectSafeValue(e))
            .toList(),
        totalDocs: APIHelper.getSafeIntValue(json['totalDocs']),
        limit: APIHelper.getSafeIntValue(json['limit']),
        page: APIHelper.getSafeIntValue(json['page']),
        totalPages: APIHelper.getSafeIntValue(json['totalPages']),
        pagingCounter: APIHelper.getSafeIntValue(json['pagingCounter']),
        hasPrevPage: APIHelper.getSafeBoolValue(json['hasPrevPage']),
        hasNextPage: APIHelper.getSafeBoolValue(json['hasNextPage']),
        prevPage: APIHelper.getSafeIntValue(json['prevPage']),
        nextPage: APIHelper.getSafeIntValue(json['nextPage']),
      );

  Map<String, dynamic> toJson() => {
        'docs': docs.map((e) => e.toJson()).toList(),
        'totalDocs': totalDocs,
        'limit': limit,
        'page': page,
        'totalPages': totalPages,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
      };

  factory FavoritesResponse.empty() => FavoritesResponse(docs: const []);

  static FavoritesResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? FavoritesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : FavoritesResponse.empty();
}

class WishlistDocResponse {
  String id;
  String user;
  WishlistProductResponse product;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  WishlistDocResponse({
    this.id = '',
    this.user = '',
    required this.product,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory WishlistDocResponse.fromJson(Map<String, dynamic> json) =>
      WishlistDocResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        product: WishlistProductResponse.getAPIResponseObjectSafeValue(
            json['product']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'product': product.toJson(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory WishlistDocResponse.empty() => WishlistDocResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime,
      product: WishlistProductResponse.empty());

  static WishlistDocResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WishlistDocResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WishlistDocResponse.empty();
}

class WishlistProductResponse {
  String id;
  String name;
  bool newArrival;
  DateTime createdAt;
  double originalPrice;
  double currentPrice;
  String image;
  int rating;
  bool discount;
  DiscountValueResponse discountValue;
  bool isFavorite;
  bool isAddToCart;
  WishlistProductStore store;
  String productCondition;

  WishlistProductResponse(
      {this.id = '',
      this.name = '',
      this.newArrival = false,
      required this.createdAt,
      this.originalPrice = 0,
      this.currentPrice = 0,
      this.image = '',
      this.rating = 0,
      this.discount = false,
      required this.discountValue,
      this.isFavorite = true,
      this.isAddToCart = false,
      required this.store,
      this.productCondition = ''});

  factory WishlistProductResponse.fromJson(Map<String, dynamic> json) =>
      WishlistProductResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        originalPrice: APIHelper.getSafeDoubleValue(json['price']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price'], 0),
        image: APIHelper.getSafeStringValue(json['image']),
        rating: APIHelper.getSafeIntValue(json['rating']),
        discount: APIHelper.getSafeBoolValue(json['discount']),
        discountValue: DiscountValueResponse.getAPIResponseObjectSafeValue(
            json['discount_value']),
        store:
            WishlistProductStore.getAPIResponseObjectSafeValue(json['store']),
        productCondition:
            APIHelper.getSafeStringValue(json['product_condition']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'new_arrival': newArrival,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'price': originalPrice,
        'current_price': currentPrice,
        'image': image,
        'rating': rating,
        'discount': discount,
        'discount_value': discountValue.toJson(),
        'store': store.toJson(),
        'product_condition': productCondition,
      };

  factory WishlistProductResponse.empty() => WishlistProductResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      discountValue: DiscountValueResponse.empty(),
      store: WishlistProductStore());

  static WishlistProductResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WishlistProductResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WishlistProductResponse.empty();

  ProductConditionStatus get productConditionStatus =>
      ProductConditionStatus.toEnumValue(productCondition);
}

class WishlistProductStore {
  String id;
  String name;
  bool isVerified;

  WishlistProductStore({
    this.id = '',
    this.name = '',
    this.isVerified = false,
  });

  factory WishlistProductStore.fromJson(Map<String, dynamic> json) =>
      WishlistProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static WishlistProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WishlistProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WishlistProductStore();
}

class DiscountValueResponse {
  String type;
  double amount;
  DateTime startDate;
  DateTime endDate;

  DiscountValueResponse(
      {this.type = '',
      this.amount = 0,
      required this.startDate,
      required this.endDate});

  factory DiscountValueResponse.fromJson(Map<String, dynamic> json) =>
      DiscountValueResponse(
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

  factory DiscountValueResponse.empty() => DiscountValueResponse(
      startDate: AppComponents.defaultUnsetDateTime,
      endDate: AppComponents.defaultUnsetDateTime);

  static DiscountValueResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DiscountValueResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DiscountValueResponse.empty();
}
