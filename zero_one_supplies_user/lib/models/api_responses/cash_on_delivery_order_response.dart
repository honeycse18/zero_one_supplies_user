import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class CashOnDeliveryOrderResponse {
  bool status;
  bool error;
  String msg;
  List<CashOnDeliveryOrderData> data;

  CashOnDeliveryOrderResponse(
      {this.error = false,
      this.status = false,
      this.msg = '',
      this.data = const []});

  factory CashOnDeliveryOrderResponse.fromJson(Map<String, dynamic> json) {
    return CashOnDeliveryOrderResponse(
      status: APIHelper.getSafeBoolValue(json['status']),
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: (APIHelper.getSafeListValue(json['data']))
          .map((e) => CashOnDeliveryOrderData.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'status': status,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static CashOnDeliveryOrderResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CashOnDeliveryOrderResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CashOnDeliveryOrderResponse();
}

class CashOnDeliveryOrderData {
  String id;
  String user;
  String order;
  double amount;
  String paymentMethod;
  String status;
  String tranId;
  DateTime tranDate;
  DateTime createdAt;
  DateTime updatedAt;

  CashOnDeliveryOrderData({
    this.id = '',
    this.user = '',
    this.order = '',
    this.amount = 0,
    this.paymentMethod = '',
    this.status = '',
    this.tranId = '',
    required this.tranDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CashOnDeliveryOrderData.fromJson(Map<String, dynamic> json) =>
      CashOnDeliveryOrderData(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        order: APIHelper.getSafeStringValue(json['order']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        status: APIHelper.getSafeStringValue(json['status']),
        tranId: APIHelper.getSafeStringValue(json['tran_id']),
        tranDate: APIHelper.getSafeDateTimeValue(json['tran_date']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'order': order,
        'amount': amount,
        'payment_method': paymentMethod,
        'status': status,
        'tran_id': tranId,
        'tran_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(tranDate),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory CashOnDeliveryOrderData.empty() => CashOnDeliveryOrderData(
      tranDate: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static CashOnDeliveryOrderData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CashOnDeliveryOrderData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CashOnDeliveryOrderData.empty();
}
