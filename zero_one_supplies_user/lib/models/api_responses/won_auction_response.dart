import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class WonAuctionResponse {
  bool error;
  String msg;
  PaginatedDataResponse<WonAuctionShortItem> data;

  WonAuctionResponse({this.error = false, this.msg = '', required this.data});

  factory WonAuctionResponse.fromJson(Map<String, dynamic> json) {
    return WonAuctionResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            WonAuctionShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson((item) => item.toJson()),
      };

  factory WonAuctionResponse.empty() =>
      WonAuctionResponse(data: PaginatedDataResponse.empty());

  static WonAuctionResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WonAuctionResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WonAuctionResponse.empty();
}

class WonAuctionShortItem {
  String id;
  WonAuctionProduct product;
  DateTime startDate;
  DateTime endDate;
  double currentPrice;
  bool status;
  DateTime createdAt;
  String user;
  bool isEnd;
  bool isFavorite;

  WonAuctionShortItem({
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

  factory WonAuctionShortItem.fromJson(Map<String, dynamic> json) =>
      WonAuctionShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        product:
            WonAuctionProduct.getAPIResponseObjectSafeValue(json['product']),
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
        'isFavorite': isEnd,
      };
  factory WonAuctionShortItem.empty() => WonAuctionShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
        product: WonAuctionProduct(),
        startDate: AppComponents.defaultUnsetDateTime,
      );

  static WonAuctionShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WonAuctionShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WonAuctionShortItem.empty();
}

/* ======================WonAuctionProduct=================== */
class WonAuctionProduct {
  String id;
  String name;
  String image;

  WonAuctionProduct({this.id = '', this.name = '', this.image = ''});

  factory WonAuctionProduct.fromJson(Map<String, dynamic> json) =>
      WonAuctionProduct(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };
  static WonAuctionProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WonAuctionProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WonAuctionProduct();
}
