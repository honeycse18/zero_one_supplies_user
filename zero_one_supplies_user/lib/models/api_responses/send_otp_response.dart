import 'package:ecomik/utils/helpers/api_helper.dart';

class SendOtpResponse {
  bool error;
  String msg;
  String code;

  SendOtpResponse({this.error = false, this.msg = '', this.code = ''});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      code: APIHelper.getSafeStringValue(json['code']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'code': code,
      };

  factory SendOtpResponse.empty() => SendOtpResponse();

  static SendOtpResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SendOtpResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SendOtpResponse.empty();
}
