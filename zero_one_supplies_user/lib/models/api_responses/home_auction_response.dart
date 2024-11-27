import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class HomeAuctionsResponse {
  bool error;
  String msg;
  List<HomeAuctionShortItem> data;

  HomeAuctionsResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory HomeAuctionsResponse.fromJson(Map<String, dynamic> json) {
    return HomeAuctionsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => HomeAuctionShortItem.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static HomeAuctionsResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HomeAuctionsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : HomeAuctionsResponse();
}

// import 'product.dart';

class HomeAuctionShortItem {
  String id;
  DateTime createdAt;
  DateTime startDate;
  DateTime endDate;
  double currentPrice;
  bool isEnd;
  AuctionShortItemProduct product;
  bool status;
  bool isWishListed;

  HomeAuctionShortItem({
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

  factory HomeAuctionShortItem.fromJson(Map<String, dynamic> json) =>
      HomeAuctionShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        product: AuctionShortItemProduct.getAPIResponseObjectSafeValue(
            json['product']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        status: APIHelper.getSafeBoolValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        isEnd: APIHelper.getSafeBoolValue(json['is_end']),
      );

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
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'is_end': isEnd,
      };
  factory HomeAuctionShortItem.empty() => HomeAuctionShortItem(
      product: AuctionShortItemProduct.empty(),
      startDate: AppComponents.defaultUnsetDateTime,
      endDate: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime);

  static HomeAuctionShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HomeAuctionShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : HomeAuctionShortItem.empty();
}

class AuctionShortItemProduct {
  String id;
  String name;
  String image;
  AuctionShortItemProductStore store;

  AuctionShortItemProduct(
      {this.id = '', this.name = '', this.image = '', required this.store});

  factory AuctionShortItemProduct.fromJson(Map<String, dynamic> json) {
    return AuctionShortItemProduct(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      image: APIHelper.getSafeStringValue(json['image']),
      store: AuctionShortItemProductStore.getAPIResponseObjectSafeValue(
          json['store']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
        'store': store.toJson(),
      };

  factory AuctionShortItemProduct.empty() =>
      AuctionShortItemProduct(store: AuctionShortItemProductStore());

  static AuctionShortItemProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionShortItemProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionShortItemProduct.empty();
}

class AuctionShortItemProductStore {
  String id;
  String name;
  bool isVerified;

  AuctionShortItemProductStore({
    this.id = '',
    this.name = '',
    this.isVerified = false,
  });

  factory AuctionShortItemProductStore.fromJson(Map<String, dynamic> json) =>
      AuctionShortItemProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static AuctionShortItemProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionShortItemProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionShortItemProductStore();
}
