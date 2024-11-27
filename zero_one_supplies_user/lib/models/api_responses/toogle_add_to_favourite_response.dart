import 'package:ecomik/utils/helpers/api_helper.dart';

class ToggleAddToFavoriteResponse {
  bool error;
  String msg;

  ToggleAddToFavoriteResponse({this.error = false, this.msg = ''});

  factory ToggleAddToFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return ToggleAddToFavoriteResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };

  static ToggleAddToFavoriteResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ToggleAddToFavoriteResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ToggleAddToFavoriteResponse();
}
