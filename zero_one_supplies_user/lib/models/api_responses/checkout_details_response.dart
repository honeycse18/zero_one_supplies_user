import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class CheckoutDetailsResponse {
  bool error;
  String msg;
  CheckoutDetails data;

  CheckoutDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory CheckoutDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: CheckoutDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory CheckoutDetailsResponse.empty() =>
      CheckoutDetailsResponse(data: CheckoutDetails.empty());

  static CheckoutDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CheckoutDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CheckoutDetailsResponse.empty();
}

class CheckoutDetails {
  String id;
  String user;
  StoreWiseCarts cartData;
  DateTime createdAt;
  DateTime updatedAt;

  CheckoutDetails({
    this.id = '',
    this.user = '',
    required this.cartData,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CheckoutDetails.fromJson(Map<String, dynamic> json) =>
      CheckoutDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        cartData:
            StoreWiseCarts.getAPIResponseObjectSafeValue(json['cartData']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'cartData': cartData,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory CheckoutDetails.empty() => CheckoutDetails(
      cartData: StoreWiseCarts.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static CheckoutDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CheckoutDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CheckoutDetails.empty();
}
