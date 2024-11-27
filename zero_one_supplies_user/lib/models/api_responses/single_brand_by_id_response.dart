import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SingleBrandByIdResponse {
  bool error;
  String msg;
  SingleBrandDataResponse data;

  SingleBrandByIdResponse(
      {this.error = false, this.msg = '', required this.data});

  factory SingleBrandByIdResponse.fromJson(Map<String, dynamic> json) {
    return SingleBrandByIdResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: SingleBrandDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SingleBrandByIdResponse.empty() =>
      SingleBrandByIdResponse(data: SingleBrandDataResponse.empty());

  static SingleBrandByIdResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleBrandByIdResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleBrandByIdResponse.empty();
}

class SingleBrandDataResponse {
  String id;
  String name;
  String description;
  String image;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  SingleBrandDataResponse({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SingleBrandDataResponse.fromJson(Map<String, dynamic> json) =>
      SingleBrandDataResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        description: APIHelper.getSafeStringValue(json['description']),
        image: APIHelper.getSafeStringValue(json['image']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SingleBrandDataResponse.empty() => SingleBrandDataResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static SingleBrandDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleBrandDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleBrandDataResponse.empty();
}
