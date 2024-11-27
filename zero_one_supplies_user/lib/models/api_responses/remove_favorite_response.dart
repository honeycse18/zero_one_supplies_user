import 'package:ecomik/utils/helpers/api_helper.dart';

class RemoveFavoriteResponse {
  bool error;
  String msg;

  RemoveFavoriteResponse({this.error = false, this.msg = ''});

  factory RemoveFavoriteResponse.fromJson(Map<String, dynamic> json) {
    return RemoveFavoriteResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
      };

  static RemoveFavoriteResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RemoveFavoriteResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RemoveFavoriteResponse();
}
