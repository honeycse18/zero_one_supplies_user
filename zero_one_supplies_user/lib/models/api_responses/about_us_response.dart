import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class AboutUsResponse {
  bool error;
  String msg;
  AboutUsShortItem data;

  AboutUsResponse({this.error = false, this.msg = '', required this.data});

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) {
    return AboutUsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: AboutUsShortItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory AboutUsResponse.empty() => AboutUsResponse(
        data: AboutUsShortItem.empty(),
      );

  static AboutUsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AboutUsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AboutUsResponse.empty();
}

class AboutUsShortItem {
  String id;
  String title;
  String description;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  String key;

  AboutUsShortItem({
    this.id = '',
    this.title = '',
    this.description = '',
    this.status = false,
    required this.createdAt,
    required this.updatedAt,
    this.key = '',
  });

  factory AboutUsShortItem.fromJson(Map<String, dynamic> json) =>
      AboutUsShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        title: APIHelper.getSafeStringValue(json['title']),
        description: APIHelper.getSafeStringValue(json['description']),
        status: APIHelper.getSafeBoolValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        key: APIHelper.getSafeStringValue(json['key']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'key': key,
      };

  factory AboutUsShortItem.empty() => AboutUsShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );

  static AboutUsShortItem getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AboutUsShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AboutUsShortItem.empty();
}
