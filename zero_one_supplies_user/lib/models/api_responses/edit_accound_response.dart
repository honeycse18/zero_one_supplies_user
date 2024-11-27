import 'package:ecomik/utils/helpers/api_helper.dart';

class EditAccountResponse {
  bool error;
  String msg;

  EditAccountResponse({this.error = false, this.msg = ''});

  factory EditAccountResponse.fromJson(Map<String, dynamic> json) {
    return EditAccountResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };
  static EditAccountResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? EditAccountResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : EditAccountResponse();
}
