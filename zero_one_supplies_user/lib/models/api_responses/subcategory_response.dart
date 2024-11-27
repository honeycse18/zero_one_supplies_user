import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SubcategoryResponse {
  bool error;
  String msg;
  SubcategoryDataResponse data;

  SubcategoryResponse({this.error = false, this.msg = '', required this.data});

  factory SubcategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubcategoryResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: SubcategoryDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SubcategoryResponse.empty() =>
      SubcategoryResponse(data: SubcategoryDataResponse());

  static SubcategoryResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubcategoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubcategoryResponse.empty();
}

class SubcategoryDataResponse {
  List<SubcategoryDocResponse> docs;
  int totalDocs;
  int limit;
  int totalPages;
  int page;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;

  SubcategoryDataResponse({
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

  factory SubcategoryDataResponse.fromJson(Map<String, dynamic> json) =>
      SubcategoryDataResponse(
        docs: APIHelper.getSafeListValue(json['docs'])
            .map((e) => SubcategoryDocResponse.getAPIResponseObjectSafeValue(e))
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

  static SubcategoryDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubcategoryDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubcategoryDataResponse();
}

class SubcategoryDocResponse {
  String id;
  String name;
  String description;
  String image;
  bool active;
  String parent;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SubcategoryDocResponse({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.active = false,
    this.parent = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory SubcategoryDocResponse.fromJson(Map<String, dynamic> json) =>
      SubcategoryDocResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        description: APIHelper.getSafeStringValue(json['description']),
        image: APIHelper.getSafeStringValue(json['image']),
        active: APIHelper.getSafeBoolValue(json['active']),
        parent: APIHelper.getSafeStringValue(json['parent']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'active': active,
        'parent': parent,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory SubcategoryDocResponse.empty() => SubcategoryDocResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static SubcategoryDocResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubcategoryDocResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubcategoryDocResponse.empty();
}
