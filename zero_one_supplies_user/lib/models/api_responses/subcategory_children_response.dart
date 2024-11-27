import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SubcategoryChildrenResponse {
  bool error;
  String msg;
  SubsChildrenDataResponse data;

  SubcategoryChildrenResponse(
      {this.error = false, this.msg = '', required this.data});

  factory SubcategoryChildrenResponse.fromJson(Map<String, dynamic> json) {
    return SubcategoryChildrenResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data:
          SubsChildrenDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SubcategoryChildrenResponse.empty() =>
      SubcategoryChildrenResponse(data: SubsChildrenDataResponse());

  static SubcategoryChildrenResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubcategoryChildrenResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubcategoryChildrenResponse.empty();
}

class SubsChildrenDataResponse {
  List<SubsChildrenDocResponse> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;

  SubsChildrenDataResponse({
    this.docs = const [],
    this.totalDocs = 0,
    this.limit = 0,
    this.page = 0,
    this.totalPages = 0,
    this.pagingCounter = 0,
    this.hasPrevPage = false,
    this.hasNextPage = false,
    this.prevPage = 0,
    this.nextPage = 0,
  });

  factory SubsChildrenDataResponse.fromJson(Map<String, dynamic> json) =>
      SubsChildrenDataResponse(
        docs: APIHelper.getSafeListValue(json['docs'])
            .map(
                (e) => SubsChildrenDocResponse.getAPIResponseObjectSafeValue(e))
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
        'page': page,
        'totalPages': totalPages,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
      };

  static SubsChildrenDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubsChildrenDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubsChildrenDataResponse();
}

class SubsChildrenDocResponse {
  String id;
  String name;
  String description;
  String image;
  bool active;
  String subcategory;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<ChildrenTotalProductResponse> totalProducts;

  SubsChildrenDocResponse({
    this.id = '',
    this.name = '',
    this.description = '',
    this.image = '',
    this.active = false,
    this.subcategory = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
    this.totalProducts = const [],
  });

  factory SubsChildrenDocResponse.fromJson(Map<String, dynamic> json) =>
      SubsChildrenDocResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        description: APIHelper.getSafeStringValue(json['description']),
        image: APIHelper.getSafeStringValue(json['image']),
        active: APIHelper.getSafeBoolValue(json['active']),
        subcategory: APIHelper.getSafeStringValue(json['subcategory']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
        totalProducts: APIHelper.getSafeListValue(json['totalProducts'])
            .map((e) =>
                ChildrenTotalProductResponse.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'image': image,
        'active': active,
        'subcategory': subcategory,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
        'totalProducts': totalProducts.map((e) => e.toJson()).toList(),
      };

  factory SubsChildrenDocResponse.empty() => SubsChildrenDocResponse(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static SubsChildrenDocResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SubsChildrenDocResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SubsChildrenDocResponse.empty();
}

class ChildrenTotalProductResponse {
  String id;
  int count;

  ChildrenTotalProductResponse({this.id = '', this.count = 0});

  factory ChildrenTotalProductResponse.fromJson(Map<String, dynamic> json) =>
      ChildrenTotalProductResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        count: APIHelper.getSafeIntValue(json['count']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'count': count,
      };
  static ChildrenTotalProductResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChildrenTotalProductResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChildrenTotalProductResponse();
}
