import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class CategoriesResponse {
  bool error;
  String msg;
  CategoryDataResponse data;

  CategoriesResponse({this.error = false, this.msg = '', required this.data});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: CategoryDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory CategoriesResponse.empty() =>
      CategoriesResponse(data: CategoryDataResponse());

  static CategoriesResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CategoriesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CategoriesResponse.empty();
}

class CategoryDataResponse {
  List<CategoryDocResponse> docs;
  int totalDocs;
  int limit;
  int totalPages;
  int page;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;

  CategoryDataResponse({
    this.docs = const [],
    this.totalDocs = 0,
    this.limit = 0,
    this.totalPages = 0,
    this.page = 0,
    this.pagingCounter = 0,
    this.hasPrevPage = false,
    this.hasNextPage = false,
    this.prevPage = 0,
    this.nextPage = 0,
  });

  factory CategoryDataResponse.fromJson(Map<String, dynamic> json) =>
      CategoryDataResponse(
        docs: APIHelper.getSafeListValue(json['docs'])
            .map((e) => CategoryDocResponse.getAPIResponseObjectSafeValue(e))
            .toList(),
        totalDocs: APIHelper.getSafeIntValue(json['totalDocs']),
        limit: APIHelper.getSafeIntValue(json['limit']),
        totalPages: APIHelper.getSafeIntValue(json['totalPages']),
        page: APIHelper.getSafeIntValue(json['page']),
        pagingCounter: APIHelper.getSafeIntValue(json['pagingCounter']),
        hasPrevPage: APIHelper.getSafeBoolValue(json['hasPrevPage']),
        hasNextPage: APIHelper.getSafeBoolValue(json['hasNextPage']),
        prevPage: APIHelper.getSafeIntValue(json['prevPage']),
        nextPage: APIHelper.getSafeIntValue(json['nextPage']),
      );

  Map<String, dynamic> toJson() => {
        'docs': docs.map((e) => e.toJson()).toList(),
        'totalDocs': totalDocs,
        'limit': limit,
        'totalPages': totalPages,
        'page': page,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
      };

  static CategoryDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CategoryDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CategoryDataResponse();
}

class CategoryDocResponse {
  String id;
  String name;
  String color;
  String description;
  String image;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  CategoryDocResponse({
    this.id = '',
    this.name = '',
    this.color = '',
    this.description = '',
    this.image = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryDocResponse.fromJson(Map<String, dynamic> json) =>
      CategoryDocResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        color: APIHelper.getSafeStringValue(json['color']),
        description: APIHelper.getSafeStringValue(json['description']),
        image: APIHelper.getSafeStringValue(json['image']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'color': color,
        'description': description,
        'image': image,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory CategoryDocResponse.empty() => CategoryDocResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static CategoryDocResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CategoryDocResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CategoryDocResponse.empty();
}
