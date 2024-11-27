import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SingleProductReviewResponse {
  bool error;
  String msg;
  PaginatedDataResponse<SingleProductReviewShortItem> data;

  SingleProductReviewResponse(
      {this.error = false, this.msg = '', required this.data});

  factory SingleProductReviewResponse.fromJson(Map<String, dynamic> json) {
    return SingleProductReviewResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            SingleProductReviewShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory SingleProductReviewResponse.empty() =>
      SingleProductReviewResponse(data: PaginatedDataResponse.empty());

  static SingleProductReviewResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductReviewResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductReviewResponse.empty();
}

class SingleProductReviewShortItem {
  String id;
  SingleProductUser user;
  String product;
  String store;
  double rating;
  String review;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  SingleProductReviewShortItem({
    this.id = '',
    required this.user,
    this.product = '',
    this.store = '',
    this.rating = 0,
    this.review = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SingleProductReviewShortItem.fromJson(Map<String, dynamic> json) =>
      SingleProductReviewShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: SingleProductUser.getAPIResponseObjectSafeValue(json['user']),
        product: APIHelper.getSafeStringValue(json['product']),
        store: APIHelper.getSafeStringValue(json['store']),
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
        'store': store,
        'rating': rating,
        'review': review,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SingleProductReviewShortItem.empty() => SingleProductReviewShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        user: SingleProductUser(),
      );

  static SingleProductReviewShortItem getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductReviewShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductReviewShortItem.empty();
}

class SingleProductUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String image;

  SingleProductUser(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.image = ''});

  factory SingleProductUser.fromJson(Map<String, dynamic> json) =>
      SingleProductUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'image': image,
      };
  static SingleProductUser getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductUser();
}
