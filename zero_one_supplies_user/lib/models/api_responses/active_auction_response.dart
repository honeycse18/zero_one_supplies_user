import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ActiveAuctionResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ActiveAuctionShortItem> data;

  ActiveAuctionResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ActiveAuctionResponse.fromJson(Map<String, dynamic> json) {
    return ActiveAuctionResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            ActiveAuctionShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ActiveAuctionResponse.empty() =>
      ActiveAuctionResponse(data: PaginatedDataResponse.empty());

  static ActiveAuctionResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveAuctionResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveAuctionResponse.empty();
}

class ActiveAuctionShortItem {
  String id;
  ActiveAuctionProduct product;
  DateTime startDate;
  DateTime endDate;
  double currentPrice;
  bool status;
  DateTime createdAt;
  String user;
  bool isEnd;
  bool isFavorite;

  ActiveAuctionShortItem({
    this.id = '',
    required this.product,
    required this.startDate,
    required this.endDate,
    this.currentPrice = 0,
    this.status = false,
    required this.createdAt,
    this.user = '',
    this.isEnd = false,
    this.isFavorite = false,
  });

  factory ActiveAuctionShortItem.fromJson(Map<String, dynamic> json) =>
      ActiveAuctionShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        product:
            ActiveAuctionProduct.getAPIResponseObjectSafeValue(json['product']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        status: APIHelper.getSafeBoolValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        user: APIHelper.getSafeStringValue(json['user']),
        isEnd: APIHelper.getSafeBoolValue(json['is_end']),
        isFavorite: APIHelper.getSafeBoolValue(json['isFavorite']),
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
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'user': user,
        'is_end': isEnd,
        'isFavorite': isFavorite,
      };
  factory ActiveAuctionShortItem.empty() => ActiveAuctionShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
        product: ActiveAuctionProduct.empty(),
        startDate: AppComponents.defaultUnsetDateTime,
      );

  static ActiveAuctionShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveAuctionShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveAuctionShortItem.empty();
}

/* ======================ActiveAuctionProduct=================== */
class ActiveAuctionProduct {
  String id;
  String name;
  String image;
  ActiveAuctionProductStore store;

  ActiveAuctionProduct(
      {this.id = '', this.name = '', this.image = '', required this.store});

  factory ActiveAuctionProduct.fromJson(Map<String, dynamic> json) =>
      ActiveAuctionProduct(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        store: ActiveAuctionProductStore.getAPIResponseObjectSafeValue(
            json['store']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
        'store': store.toJson(),
      };

  factory ActiveAuctionProduct.empty() =>
      ActiveAuctionProduct(store: ActiveAuctionProductStore());

  static ActiveAuctionProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveAuctionProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveAuctionProduct.empty();
}

class ActiveAuctionProductStore {
  String id;
  String name;
  bool isVerified;

  ActiveAuctionProductStore({
    this.id = '',
    this.name = '',
    this.isVerified = false,
  });

  factory ActiveAuctionProductStore.fromJson(Map<String, dynamic> json) =>
      ActiveAuctionProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static ActiveAuctionProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ActiveAuctionProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ActiveAuctionProductStore();
}
