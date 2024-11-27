import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class BrandListsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<BrandShortItem> data;

  BrandListsResponse({this.error = false, this.msg = '', required this.data});

  factory BrandListsResponse.fromJson(Map<String, dynamic> json) {
    return BrandListsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            BrandShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson((item) => item.toJson()),
      };

  factory BrandListsResponse.empty() =>
      BrandListsResponse(data: PaginatedDataResponse.empty());

  static BrandListsResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BrandListsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : BrandListsResponse.empty();
}

class BrandShortItem {
  String id;
  String name;
  String description;
  String image;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  BrandShortItem({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandShortItem.fromJson(Map<String, dynamic> json) => BrandShortItem(
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

  factory BrandShortItem.empty() => BrandShortItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static BrandShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? BrandShortItem.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : BrandShortItem.empty();
}
