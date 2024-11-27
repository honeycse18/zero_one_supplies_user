import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/models/api_responses/mixed_product_auction_response.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ProductsWithTagsResponse {
  bool error;
  String msg;
  ProductsWithTagsPaginated data;

  ProductsWithTagsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ProductsWithTagsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsWithTagsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: ProductsWithTagsPaginated.getAPIResponseObjectSafeValue(
        json['data'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ProductsWithTagsResponse.empty() =>
      ProductsWithTagsResponse(data: ProductsWithTagsPaginated.empty());

  static ProductsWithTagsResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductsWithTagsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductsWithTagsResponse.empty();
}

class ProductsWithTags {
  bool error;
  String msg;
  List<String> tags;
  PaginatedDataResponse<MixedAuctionProductItem> data;

  ProductsWithTags({
    this.error = false,
    this.msg = '',
    required this.data,
    this.tags = const [],
  });

  factory ProductsWithTags.fromJson(Map<String, dynamic> json) {
    return ProductsWithTags(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
          json['data'],
          docFromJson: (data) =>
              MixedAuctionProductItem.getAPIResponseObjectSafeValue(data),
        ),
        tags: APIHelper.getSafeListValue(json['tags'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
        'tags': tags,
      };

  factory ProductsWithTags.empty() =>
      ProductsWithTags(data: PaginatedDataResponse.empty());

  static ProductsWithTags getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductsWithTags.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductsWithTags.empty();
}

class ProductsWithTagsPaginated<T> {
  List<MixedAuctionProductItem> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;
  List<String> tags;

  ProductsWithTagsPaginated({
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
    this.tags = const [],
  });

  factory ProductsWithTagsPaginated.fromJson(Map<String, dynamic> json) =>
      ProductsWithTagsPaginated(
        docs: APIHelper.getSafeListValue(json['docs'])
            .map(
                (e) => MixedAuctionProductItem.getAPIResponseObjectSafeValue(e))
            .toList(),
        totalDocs: APIHelper.getSafeIntValue(json['totalDocs']),
        limit: APIHelper.getSafeIntValue(json['limit']),
        page: APIHelper.getSafeIntValue(json['page']),
        totalPages: APIHelper.getSafeIntValue(json['totalPages']),
        pagingCounter: APIHelper.getSafeIntValue(json['pagingCounter']),
        hasPrevPage: APIHelper.getSafeBoolValue(json['hasPrevPage']),
        hasNextPage: APIHelper.getSafeBoolValue(json['hasNextPage']),
        prevPage: APIHelper.getSafeIntValue(json['prevPage']),
        nextPage: APIHelper.getSafeIntValue(json['nextPage']),
        tags: APIHelper.getSafeListValue(json['tags'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
      );

  factory ProductsWithTagsPaginated.empty() => ProductsWithTagsPaginated<T>();

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
        'tags': tags
      };

  static ProductsWithTagsPaginated<T> getAPIResponseObjectSafeValue<T>(
    Object? unsafeResponseValue,
  ) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductsWithTagsPaginated.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductsWithTagsPaginated.empty();

  ProductsAndTags get productsAndTags =>
      ProductsAndTags(products: docs, tags: tags);
}

class ProductsAndTags {
  List<MixedAuctionProductItem> products;
  List<String> tags;
  int selectedTagIndex;

  ProductsAndTags({
    this.products = const [],
    this.tags = const [],
    this.selectedTagIndex = -1,
  });
}
