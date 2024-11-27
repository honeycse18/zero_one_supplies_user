import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ProductDetailsReview {
  ProductDetailsReviewUser user;
  String review;
  double rating;
  DateTime createdAt;

  ProductDetailsReview({
    required this.user,
    this.review = '',
    this.rating = 0,
    required this.createdAt,
  });

  factory ProductDetailsReview.fromJson(Map<String, dynamic> json) {
    return ProductDetailsReview(
      user:
          ProductDetailsReviewUser.getAPIResponseObjectSafeValue(json['user']),
      review: APIHelper.getSafeStringValue(json['review']),
      rating: APIHelper.getSafeDoubleValue(json['rating']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'review': review,
        'rating': rating,
        'createdAt': createdAt.toIso8601String(),
      };

  factory ProductDetailsReview.empty() => ProductDetailsReview(
      user: ProductDetailsReviewUser(),
      createdAt: AppComponents.defaultUnsetDateTime);

  static ProductDetailsReview getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsReview.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsReview.empty();
}

class ProductDetailsReviewUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String image;

  ProductDetailsReviewUser(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.image = ''});

  factory ProductDetailsReviewUser.fromJson(Map<String, dynamic> json) =>
      ProductDetailsReviewUser(
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

  static ProductDetailsReviewUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsReviewUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsReviewUser();
}
