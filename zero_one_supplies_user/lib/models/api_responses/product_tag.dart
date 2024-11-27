import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/extensions/datetime.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ProductTagResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ProductTag> data;

  ProductTagResponse({this.error = false, this.msg = '', required this.data});

  factory ProductTagResponse.fromJson(Map<String, dynamic> json) {
    return ProductTagResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) => ProductTag.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ProductTagResponse.empty() =>
      ProductTagResponse(data: PaginatedDataResponse.empty());

  static ProductTagResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductTagResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductTagResponse.empty();
}

class ProductTag {
  String id;
  String name;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  ProductTag({
    this.id = '',
    this.name = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductTag.fromJson(Map<String, dynamic> json) => ProductTag(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'active': active,
        'createdAt': createdAt.toServerDateTimeFormatted,
        'updatedAt': updatedAt.toServerDateTimeFormatted,
      };

  factory ProductTag.empty() => ProductTag(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static ProductTag getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductTag.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ProductTag.empty();
}
