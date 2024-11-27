import 'package:ecomik/utils/helpers/api_helper.dart';

class OrderSubmitResponse {
  bool error;
  String msg;
  OrderSubmitData data;

  OrderSubmitResponse({this.error = false, this.msg = '', required this.data});

  factory OrderSubmitResponse.fromJson(Map<String, dynamic> json) {
    return OrderSubmitResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: OrderSubmitData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory OrderSubmitResponse.empty() =>
      OrderSubmitResponse(data: OrderSubmitData());

  static OrderSubmitResponse getAPIResponseObjectSafeValue<D>(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderSubmitResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderSubmitResponse.empty();
}

class OrderSubmitData {
  String order;
  double total;

  OrderSubmitData({this.order = '', this.total = 0});

  factory OrderSubmitData.fromJson(Map<String, dynamic> json) {
    return OrderSubmitData(
      order: APIHelper.getSafeStringValue(json['order']),
      total: APIHelper.getSafeDoubleValue(json['total']),
    );
  }

  Map<String, dynamic> toJson() => {
        'order': order,
        'total': total,
      };

  static OrderSubmitData getAPIResponseObjectSafeValue<D>(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderSubmitData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderSubmitData();
}
