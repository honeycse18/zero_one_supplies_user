import 'package:ecomik/utils/helpers/api_helper.dart';

class SignUpOtpVerificationResponse {
  bool error;
  String msg;

  SignUpOtpVerificationResponse({this.error = false, this.msg = ''});

  factory SignUpOtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return SignUpOtpVerificationResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };

  static SignUpOtpVerificationResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SignUpOtpVerificationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SignUpOtpVerificationResponse();
}
