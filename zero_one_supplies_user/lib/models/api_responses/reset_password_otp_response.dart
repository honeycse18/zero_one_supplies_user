import 'package:ecomik/utils/helpers/api_helper.dart';

class ResetPasswordOtpResponse {
  bool error;
  String msg;
  ResetPasswordOtpData data;

  ResetPasswordOtpResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ResetPasswordOtpResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordOtpResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: ResetPasswordOtpData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ResetPasswordOtpResponse.empty() =>
      ResetPasswordOtpResponse(data: ResetPasswordOtpData.empty());

  static ResetPasswordOtpResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ResetPasswordOtpResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ResetPasswordOtpResponse.empty();
}

class ResetPasswordOtpData {
  String otp;
  String userInput;

  ResetPasswordOtpData({this.otp = '', this.userInput = ''});

  factory ResetPasswordOtpData.fromJson(Map<String, dynamic> json) =>
      ResetPasswordOtpData(
        otp: APIHelper.getSafeStringValue(json['otp']),
        userInput: APIHelper.getSafeStringValue(json['user_input']),
      );

  Map<String, dynamic> toJson() => {
        'otp': otp,
        'user_input': userInput,
      };

  factory ResetPasswordOtpData.empty() => ResetPasswordOtpData();

  static ResetPasswordOtpData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ResetPasswordOtpData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ResetPasswordOtpData.empty();
}
