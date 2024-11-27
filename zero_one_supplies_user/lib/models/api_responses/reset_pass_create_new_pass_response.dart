import 'package:ecomik/utils/helpers/api_helper.dart';

class ResetPassCreateNewPassResponse {
  bool error;
  String msg;

  ResetPassCreateNewPassResponse({this.error = false, this.msg = ''});

  factory ResetPassCreateNewPassResponse.fromJson(Map<String, dynamic> json) {
    return ResetPassCreateNewPassResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };

  static ResetPassCreateNewPassResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ResetPassCreateNewPassResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ResetPassCreateNewPassResponse();
}
