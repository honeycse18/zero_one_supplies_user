import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ReviewCountResponse {
  bool error;
  String msg;
  StoreReviewCountShortItem data;

  ReviewCountResponse({this.error = false, this.msg = '', required this.data});

  factory ReviewCountResponse.fromJson(Map<String, dynamic> json) {
    return ReviewCountResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data:
          StoreReviewCountShortItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ReviewCountResponse.empty() =>
      ReviewCountResponse(data: StoreReviewCountShortItem.empty());

  static ReviewCountResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ReviewCountResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ReviewCountResponse.empty();
}

class StoreReviewCountShortItem {
  String id;
  String name;
  StoreCategory category;
  String location;
  String description;
  String nidNumber;
  String taxName;
  String taxNumber;
  String status;
  String vendor;
  DateTime createdAt;
  DateTime updatedAt;
  String accountName;
  String accountNumber;
  String addressProof;
  String bankName;
  String branch;
  String companyCity;
  String companyCountry;
  String companyEmail;
  String companyPhone;
  String companyState;
  String companyZipCode;
  String currencyCode;
  String currencySymbol;
  String logo;
  String nidImage;
  String tradeLicense;
  String tradeLicenseImage;
  String vatCertificateImage;
  DateTime tradeLicenseValidity;
  String vatRegistrationNo;
  StoreBasedRating rating;
  List<RatingPercentage> ratingPercentage;

  StoreReviewCountShortItem({
    this.id = '',
    this.name = '',
    required this.category,
    this.location = '',
    this.description = '',
    this.nidNumber = '',
    this.taxName = '',
    this.taxNumber = '',
    this.status = '',
    this.vendor = '',
    required this.createdAt,
    required this.updatedAt,
    this.accountName = '',
    this.accountNumber = '',
    this.addressProof = '',
    this.bankName = '',
    this.branch = '',
    this.companyCity = '',
    this.companyCountry = '',
    this.companyEmail = '',
    this.companyPhone = '',
    this.companyState = '',
    this.companyZipCode = '',
    this.currencyCode = '',
    this.currencySymbol = '',
    this.logo = '',
    this.nidImage = '',
    this.tradeLicense = '',
    this.tradeLicenseImage = '',
    this.vatCertificateImage = '',
    required this.tradeLicenseValidity,
    this.vatRegistrationNo = '',
    required this.rating,
    this.ratingPercentage = const [],
  });

  factory StoreReviewCountShortItem.fromJson(Map<String, dynamic> json) =>
      StoreReviewCountShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: StoreCategory.getAPIResponseObjectSafeValue(json['category']),
        location: APIHelper.getSafeStringValue(json['location']),
        description: APIHelper.getSafeStringValue(json['description']),
        nidNumber: APIHelper.getSafeStringValue(json['nid_number']),
        taxName: APIHelper.getSafeStringValue(json['tax_name']),
        taxNumber: APIHelper.getSafeStringValue(json['tax_number']),
        status: APIHelper.getSafeStringValue(json['status']),
        vendor: APIHelper.getSafeStringValue(json['vendor']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        accountName: APIHelper.getSafeStringValue(json['account_name']),
        accountNumber: APIHelper.getSafeStringValue(json['account_number']),
        addressProof: APIHelper.getSafeStringValue(json['address_proof']),
        bankName: APIHelper.getSafeStringValue(json['bank_name']),
        branch: APIHelper.getSafeStringValue(json['branch']),
        companyCity: APIHelper.getSafeStringValue(json['company_city']),
        companyCountry: APIHelper.getSafeStringValue(json['company_country']),
        companyEmail: APIHelper.getSafeStringValue(json['company_email']),
        companyPhone: APIHelper.getSafeStringValue(json['company_phone']),
        companyState: APIHelper.getSafeStringValue(json['company_state']),
        companyZipCode: APIHelper.getSafeStringValue(json['company_zipcode']),
        currencyCode: APIHelper.getSafeStringValue(json['currency_code']),
        currencySymbol: APIHelper.getSafeStringValue(json['currency_symbol']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        nidImage: APIHelper.getSafeStringValue(json['nid_image']),
        tradeLicense: APIHelper.getSafeStringValue(json['trade_license']),
        tradeLicenseImage:
            APIHelper.getSafeStringValue(json['trade_license_image']),
        vatCertificateImage:
            APIHelper.getSafeStringValue(json['vat_certificate_image']),
        tradeLicenseValidity:
            APIHelper.getSafeDateTimeValue(json['trade_license_validity']),
        vatRegistrationNo:
            APIHelper.getSafeStringValue(json['vat_registration_no']),
        rating: StoreBasedRating.getAPIResponseObjectSafeValue(json['rating']),
        ratingPercentage: APIHelper.getSafeListValue(json['ratingPercentage'])
            .map((e) => RatingPercentage.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'category': category.toJson(),
        'location': location,
        'description': description,
        'nid_number': nidNumber,
        'tax_name': taxName,
        'tax_number': taxNumber,
        'status': status,
        'vendor': vendor,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'account_name': accountName,
        'account_number': accountNumber,
        'address_proof': addressProof,
        'bank_name': bankName,
        'branch': branch,
        'company_city': companyCity,
        'company_country': companyCountry,
        'company_email': companyEmail,
        'company_phone': companyPhone,
        'company_state': companyState,
        'company_zipcode': companyZipCode,
        'currency_code': currencyCode,
        'currency_symbol': currencySymbol,
        'logo': logo,
        'nid_image': nidImage,
        'trade_license': tradeLicense,
        'trade_license_image': tradeLicenseImage,
        'vat_certificate_image': vatCertificateImage,
        'trade_license_validity':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(
                tradeLicenseValidity),
        'vat_registration_no': vatRegistrationNo,
        'rating': rating.toJson(),
        'ratingPercentage': ratingPercentage.map((e) => e.toJson()).toList(),
      };

  factory StoreReviewCountShortItem.empty() => StoreReviewCountShortItem(
        category: StoreCategory(),
        createdAt: AppComponents.defaultUnsetDateTime,
        rating: StoreBasedRating.empty(),
        tradeLicenseValidity: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );

  static StoreReviewCountShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreReviewCountShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreReviewCountShortItem.empty();
}
//======================================

class StoreBasedRating {
  double totalRating;
  String name;
  String logo;
  StoreCategory category;
  String id;
  int sellerReviews;
  int positiveSellerReview;
  double avgRating;
  String type;

  StoreBasedRating({
    this.totalRating = 0,
    this.name = '',
    this.logo = '',
    required this.category,
    this.id = '',
    this.sellerReviews = 0,
    this.positiveSellerReview = 0,
    this.avgRating = 0,
    this.type = '',
  });

  factory StoreBasedRating.fromJson(Map<String, dynamic> json) =>
      StoreBasedRating(
        totalRating: APIHelper.getSafeDoubleValue(json['totalRating']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        category: StoreCategory.getAPIResponseObjectSafeValue(json['category']),
        id: APIHelper.getSafeStringValue(json['_id']),
        sellerReviews: APIHelper.getSafeIntValue(json['seller_reviews'], 0),
        positiveSellerReview:
            APIHelper.getSafeIntValue(json['positiveSellerReview']),
        avgRating: APIHelper.getSafeDoubleValue(json['avg_rating'], 0),
        type: APIHelper.getSafeStringValue(json['type']),
      );

  Map<String, dynamic> toJson() => {
        'totalRating': totalRating,
        'name': name,
        'logo': logo,
        'category': category.toJson(),
        '_id': id,
        'seller_reviews': sellerReviews,
        'positiveSellerReview': positiveSellerReview,
        'avg_rating': avgRating,
        'type': type,
      };

  factory StoreBasedRating.empty() => StoreBasedRating(
        category: StoreCategory(),
      );

  static StoreBasedRating getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreBasedRating.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreBasedRating.empty();
}

//========================================
class StoreCategory {
  String id;
  String name;

  StoreCategory({this.id = '', this.name = ''});

  factory StoreCategory.fromJson(Map<String, dynamic> json) => StoreCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static StoreCategory getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreCategory.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : StoreCategory();
}

//===================================
class StoreIdRating {
  double rating;

  StoreIdRating({this.rating = 0});

  factory StoreIdRating.fromJson(Map<String, dynamic> json) => StoreIdRating(
        rating: APIHelper.getSafeDoubleValue(json['rating']),
      );

  Map<String, dynamic> toJson() => {
        'rating': rating,
      };

  static StoreIdRating getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreIdRating.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : StoreIdRating();
}

//======================

class RatingPercentage {
  StoreIdRating id;
  int count;

  RatingPercentage({required this.id, this.count = 0});

  factory RatingPercentage.fromJson(Map<String, dynamic> json) {
    return RatingPercentage(
      id: StoreIdRating.getAPIResponseObjectSafeValue(json['_id']),
      count: (json['count']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id.toJson(),
        'count': count,
      };

  factory RatingPercentage.empty() => RatingPercentage(
        id: StoreIdRating(),
      );

  static RatingPercentage getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RatingPercentage.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RatingPercentage.empty();
}
