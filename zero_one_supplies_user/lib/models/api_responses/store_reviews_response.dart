import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class StoreReviewsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<StoreReviewsShortItem> data;

  StoreReviewsResponse({this.error = false, this.msg = '', required this.data});

  factory StoreReviewsResponse.fromJson(Map<String, dynamic> json) {
    return StoreReviewsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            StoreReviewsShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory StoreReviewsResponse.empty() =>
      StoreReviewsResponse(data: PaginatedDataResponse.empty());

  static StoreReviewsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreReviewsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreReviewsResponse.empty();
}

class StoreReviewsShortItem {
  String id;
  StoreUser user;
  String product;
  Store store;
  double rating;
  String review;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  StoreReviewsShortItem({
    this.id = '',
    required this.user,
    this.product = '',
    required this.store,
    this.rating = 0,
    this.review = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoreReviewsShortItem.fromJson(Map<String, dynamic> json) =>
      StoreReviewsShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: StoreUser.getAPIResponseObjectSafeValue(json['user']),
        product: APIHelper.getSafeStringValue(json['product']),
        store: Store.getAPIResponseObjectSafeValue(json['store']),
        rating: APIHelper.getSafeDoubleValue(json['rating']),
        review: APIHelper.getSafeStringValue(json['review']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'product': product,
        'store': store.toJson(),
        'rating': rating,
        'review': review,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory StoreReviewsShortItem.empty() => StoreReviewsShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        store: Store(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        user: StoreUser(),
      );

  static StoreReviewsShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreReviewsShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreReviewsShortItem.empty();
}

class StoreUser {
  String id;
  String firstName;
  String lastName;
  String image;

  StoreUser(
      {this.id = '', this.firstName = '', this.lastName = '', this.image = ''});

  factory StoreUser.fromJson(Map<String, dynamic> json) => StoreUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'image': image,
      };

  static StoreUser getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreUser.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : StoreUser();
}

class Store {
  String id;

  Store({this.id = ''});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
      };

  static Store getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Store.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Store();
}
