import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class EndingSoonResponse {
  bool error;
  String msg;
  PaginatedDataResponse<EndingSoonShortItem> data;

  EndingSoonResponse({this.error = false, this.msg = '', required this.data});

  factory EndingSoonResponse.fromJson(Map<String, dynamic> json) {
    return EndingSoonResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            EndingSoonShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory EndingSoonResponse.empty() =>
      EndingSoonResponse(data: PaginatedDataResponse.empty());

  static EndingSoonResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EndingSoonResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EndingSoonResponse.empty();
}

class EndingSoonShortItem {
  String id;
  EndingSoonShortItemProduct product;
  DateTime startDate;
  DateTime endDate;
  double currentPrice;
  bool status;
  DateTime createdAt;
  bool isEnd;
  bool isFavorite;

  EndingSoonShortItem({
    this.id = '',
    required this.product,
    required this.startDate,
    required this.endDate,
    this.currentPrice = 0,
    this.status = false,
    required this.createdAt,
    this.isEnd = false,
    this.isFavorite = false,
  });

  factory EndingSoonShortItem.fromJson(Map<String, dynamic> json) =>
      EndingSoonShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        product: EndingSoonShortItemProduct.getAPIResponseObjectSafeValue(
            json['product']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        status: APIHelper.getSafeBoolValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
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
        'is_end': isEnd,
        'isFavorite': isFavorite,
      };

  factory EndingSoonShortItem.empty() => EndingSoonShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        endDate: AppComponents.defaultUnsetDateTime,
        product: EndingSoonShortItemProduct.empty(),
        startDate: AppComponents.defaultUnsetDateTime,
      );
  static EndingSoonShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EndingSoonShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EndingSoonShortItem.empty();
}

class EndingSoonShortItemProduct {
  String id;
  String name;
  String image;
  EndingSoonShortItemProductStore store;

  EndingSoonShortItemProduct(
      {this.id = '', this.name = '', this.image = '', required this.store});

  factory EndingSoonShortItemProduct.fromJson(Map<String, dynamic> json) =>
      EndingSoonShortItemProduct(
          id: APIHelper.getSafeStringValue(json['_id']),
          name: APIHelper.getSafeStringValue(json['name']),
          image: APIHelper.getSafeStringValue(json['image']),
          store: EndingSoonShortItemProductStore.getAPIResponseObjectSafeValue(
              'store'));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
        'store': store.toJson(),
      };

  factory EndingSoonShortItemProduct.empty() =>
      EndingSoonShortItemProduct(store: EndingSoonShortItemProductStore());

  static EndingSoonShortItemProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EndingSoonShortItemProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EndingSoonShortItemProduct.empty();
}

class EndingSoonShortItemProductStore {
  String id;
  String name;
  bool isVerified;

  EndingSoonShortItemProductStore({
    this.id = '',
    this.name = '',
    this.isVerified = false,
  });

  factory EndingSoonShortItemProductStore.fromJson(Map<String, dynamic> json) =>
      EndingSoonShortItemProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': isVerified,
      };

  static EndingSoonShortItemProductStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EndingSoonShortItemProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EndingSoonShortItemProductStore();
}
