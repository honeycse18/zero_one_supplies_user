import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class AuctionsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<AuctionShortItem> data;

  AuctionsResponse({this.error = false, this.msg = '', required this.data});

  factory AuctionsResponse.fromJson(Map<String, dynamic> json) {
    return AuctionsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            AuctionShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson((item) => item.toJson()),
      };

  factory AuctionsResponse.empty() =>
      AuctionsResponse(data: PaginatedDataResponse.empty());

  static AuctionsResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionsResponse.empty();
}

// import 'product.dart';

class AuctionShortItem {
  String id;
  DateTime startDate;
  DateTime endDate;
  double currentPrice;
  bool status;
  DateTime createdAt;
  bool isEnd;
  bool isWishListed;
  String name;
  String image;
  AuctionShortItemProductStore store;

  AuctionShortItem({
    this.id = '',
    required this.startDate,
    required this.endDate,
    this.currentPrice = 0,
    this.status = false,
    required this.createdAt,
    this.isEnd = false,
    this.isWishListed = false,
    this.name = '',
    this.image = '',
    required this.store,
  });

  factory AuctionShortItem.fromJson(Map<String, dynamic> json) =>
      AuctionShortItem(
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        store: AuctionShortItemProductStore.getAPIResponseObjectSafeValue(
            json['store']),
        id: APIHelper.getSafeStringValue(json['_id']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        status: APIHelper.getSafeBoolValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        isEnd: APIHelper.getSafeBoolValue(json['is_end']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'current_price': currentPrice,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'is_end': isEnd,
        'name': name,
        'image': image,
        'store': store.toJson(),
      };
  factory AuctionShortItem.empty() => AuctionShortItem(
      store: AuctionShortItemProductStore(),
      startDate: AppComponents.defaultUnsetDateTime,
      endDate: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime);

  static AuctionShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AuctionShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AuctionShortItem.empty();
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
