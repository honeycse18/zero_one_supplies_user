import 'package:ecomik/utils/helpers/api_helper.dart';

class InitializeCinetPaymentResponse {
  bool error;
  String msg;
  InitializeCinetPayment data;

  InitializeCinetPaymentResponse(
      {this.error = false, this.msg = '', required this.data});

  factory InitializeCinetPaymentResponse.fromJson(Map<String, dynamic> json) {
    return InitializeCinetPaymentResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: InitializeCinetPayment.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory InitializeCinetPaymentResponse.empty() =>
      InitializeCinetPaymentResponse(data: InitializeCinetPayment.empty());

  static InitializeCinetPaymentResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? InitializeCinetPaymentResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : InitializeCinetPaymentResponse.empty();
}

class InitializeCinetPayment {
  int code;
  String message;
  String description;
  InitializeCinetPaymentData data;
  String apiResponseId;

  InitializeCinetPayment({
    this.code = 0,
    this.message = '',
    this.description = '',
    required this.data,
    this.apiResponseId = '',
  });

  factory InitializeCinetPayment.fromJson(Map<String, dynamic> json) =>
      InitializeCinetPayment(
        code: APIHelper.getSafeIntValue(json['code']),
        message: APIHelper.getSafeStringValue(json['message']),
        description: APIHelper.getSafeStringValue(json['description']),
        data: InitializeCinetPaymentData.getAPIResponseObjectSafeValue(
            json['data']),
        apiResponseId: APIHelper.getSafeStringValue(json['api_response_id']),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'description': description,
        'data': data.toJson(),
        'api_response_id': apiResponseId,
      };

  factory InitializeCinetPayment.empty() =>
      InitializeCinetPayment(data: InitializeCinetPaymentData());

  static InitializeCinetPayment getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? InitializeCinetPayment.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : InitializeCinetPayment.empty();
}

class InitializeCinetPaymentData {
  String paymentToken;
  String paymentURL;

  InitializeCinetPaymentData({this.paymentToken = '', this.paymentURL = ''});

  factory InitializeCinetPaymentData.fromJson(Map<String, dynamic> json) =>
      InitializeCinetPaymentData(
        paymentToken: APIHelper.getSafeStringValue(json['payment_token']),
        paymentURL: APIHelper.getSafeStringValue(json['payment_url']),
      );

  Map<String, dynamic> toJson() => {
        'payment_token': paymentToken,
        'payment_url': paymentURL,
      };

  static InitializeCinetPaymentData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? InitializeCinetPaymentData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : InitializeCinetPaymentData();
}
