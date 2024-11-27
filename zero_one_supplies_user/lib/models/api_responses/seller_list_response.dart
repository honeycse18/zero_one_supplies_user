import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';

class SellerListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<SellerSingleShortItem> data;

  SellerListResponse({this.error = false, this.msg = '', required this.data});

  factory SellerListResponse.fromJson(Map<String, dynamic> json) {
    return SellerListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            SellerSingleShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };
  factory SellerListResponse.empty() =>
      SellerListResponse(data: PaginatedDataResponse.empty());

  static SellerListResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SellerListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SellerListResponse.empty();
}

//===================Seller Single Short Item==================
class SellerSingleShortItem {
  String id;
  String name;
  SellerCategory category;
  String logo;
  int products;
  SellerRating sellerRating;
  bool isVerified;

  SellerSingleShortItem(
      {this.id = '',
      this.name = '',
      required this.category,
      this.logo = '',
      this.products = 0,
      required this.sellerRating,
      this.isVerified = false});

  factory SellerSingleShortItem.fromJson(Map<String, dynamic> json) =>
      SellerSingleShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        category:
            SellerCategory.getAPIResponseObjectSafeValue(json['category']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        products: APIHelper.getSafeIntValue(json['products']),
        sellerRating:
            SellerRating.getAPIResponseObjectSafeValue(json['product_ratings']),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'category': category.toJson(),
        'logo': logo,
        'products': products,
        'product_ratings': sellerRating.toJson(),
        'verified': isVerified,
      };

  factory SellerSingleShortItem.empty() => SellerSingleShortItem(
      category: SellerCategory(), sellerRating: SellerRating());

  static SellerSingleShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SellerSingleShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SellerSingleShortItem.empty();
}

//==========Seller Category============
class SellerCategory {
  String name;

  SellerCategory({this.name = ''});

  factory SellerCategory.fromJson(Map<String, dynamic> json) => SellerCategory(
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };

  static SellerCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SellerCategory.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SellerCategory();
}

class SellerRating {
  String id;
  double totalRating;
  int sellerReviews;
  int positiveSellerReview;
  double averageRating;
  String type;

  SellerRating({
    this.id = '',
    this.type = '',
    this.totalRating = 0,
    this.sellerReviews = 0,
    this.positiveSellerReview = 0,
    this.averageRating = 0,
  });

  factory SellerRating.fromJson(Map<String, dynamic> json) => SellerRating(
        id: APIHelper.getSafeStringValue(json['_id']),
        type: APIHelper.getSafeStringValue(json['type']),
        totalRating: APIHelper.getSafeDoubleValue(json['totalRating'], 0),
        sellerReviews: APIHelper.getSafeIntValue(json['seller_reviews'], 0),
        positiveSellerReview:
            APIHelper.getSafeIntValue(json['positiveSellerReview'], 0),
        averageRating: APIHelper.getSafeDoubleValue(json['avg_rating'], 0),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'type': type,
        'totalRating': totalRating,
        'seller_reviews': sellerReviews,
        'positiveSellerReview': positiveSellerReview,
        'avg_rating': averageRating,
      };

  static SellerRating getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SellerRating.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SellerRating();

  SellerStatus get status {
    return Helper.getSellerStatus(positiveSellerReview);
  }
}
