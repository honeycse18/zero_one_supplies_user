import 'package:ecomik/utils/helpers/api_helper.dart';

class OtpVerifyResponse {
  bool error;
  String msg;
  String token;

  OtpVerifyResponse({this.error = false, this.msg = '', this.token = ''});

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerifyResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      token: APIHelper.getSafeStringValue(json['token']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'token': token,
      };

  factory OtpVerifyResponse.empty() => OtpVerifyResponse();

  static OtpVerifyResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OtpVerifyResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OtpVerifyResponse.empty();
}
