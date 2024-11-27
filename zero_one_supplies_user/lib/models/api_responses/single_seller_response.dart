import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';

class SingleSellerResponse {
  bool error;
  String msg;
  SingleSellerDataResponse data;

  SingleSellerResponse({this.error = false, this.msg = '', required this.data});

  factory SingleSellerResponse.fromJson(Map<String, dynamic> json) {
    return SingleSellerResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data:
          SingleSellerDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SingleSellerResponse.empty() =>
      SingleSellerResponse(data: SingleSellerDataResponse.empty());

  static SingleSellerResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleSellerResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleSellerResponse.empty();
}

class SingleSellerDataResponse {
  String id;
  String name;
  SingleSellerCategoryResponse category;
  String location;
  String description;
  String logo;
  String nidNumber;
  String nidImage;
  String addressProof;
  String taxName;
  String taxNumber;
  String status;
  String vendor;
  DateTime createdAt;
  DateTime updatedAt;
  SingleStoreProducts itemCounts;
  int v;
  String currencyCode;
  String currencySymbol;
  String accountName;
  String accountNumber;
  String bankName;
  String branch;
  String companyCity;
  String companyEmail;
  String companyPhone;
  String companyState;
  String companyZipCode;
  String tradeLicense;
  String vatRegistrationNo;
  String companyCountry;
  DateTime tradeLicenseValidity;
  String vatCertificateImage;
  SingleSellerRatingResponse rating;
  List<SingleSellerRatingPercentageResponse> ratingPercentage;
  bool isVerified;

  SingleSellerDataResponse({
    this.id = '',
    this.name = '',
    required this.category,
    this.location = '',
    this.description = '',
    this.logo = '',
    this.nidNumber = '',
    this.nidImage = '',
    this.addressProof = '',
    this.taxName = '',
    this.taxNumber = '',
    this.status = '',
    this.vendor = '',
    required this.createdAt,
    required this.updatedAt,
    required this.itemCounts,
    this.v = 0,
    this.currencyCode = '',
    this.currencySymbol = '',
    this.accountName = '',
    this.accountNumber = '',
    this.bankName = '',
    this.branch = '',
    this.companyCity = '',
    this.companyEmail = '',
    this.companyPhone = '',
    this.companyState = '',
    this.companyZipCode = '',
    this.tradeLicense = '',
    this.vatRegistrationNo = '',
    this.companyCountry = '',
    required this.tradeLicenseValidity,
    this.vatCertificateImage = '',
    required this.rating,
    this.ratingPercentage = const [],
    this.isVerified = false,
  });

  factory SingleSellerDataResponse.fromJson(Map<String, dynamic> json) =>
      SingleSellerDataResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: SingleSellerCategoryResponse.getAPIResponseObjectSafeValue(
            json['category']),
        location: APIHelper.getSafeStringValue(json['location']),
        description: APIHelper.getSafeStringValue(json['description']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        nidNumber: APIHelper.getSafeStringValue(json['nid_number']),
        nidImage: APIHelper.getSafeStringValue(json['nid_image']),
        addressProof: APIHelper.getSafeStringValue(json['address_proof']),
        taxName: APIHelper.getSafeStringValue(json['tax_name']),
        taxNumber: APIHelper.getSafeStringValue(json['tax_number']),
        status: APIHelper.getSafeStringValue(json['status']),
        vendor: APIHelper.getSafeStringValue(json['vendor']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        itemCounts:
            SingleStoreProducts.getAPIResponseObjectSafeValue(json['products']),
        v: APIHelper.getSafeIntValue(json['__v']),
        currencyCode: APIHelper.getSafeStringValue(json['currency_code']),
        currencySymbol: APIHelper.getSafeStringValue(json['currency_symbol']),
        accountName: APIHelper.getSafeStringValue(json['account_name']),
        accountNumber: APIHelper.getSafeStringValue(json['account_number']),
        bankName: APIHelper.getSafeStringValue(json['bank_name']),
        branch: APIHelper.getSafeStringValue(json['branch']),
        companyCity: APIHelper.getSafeStringValue(json['company_city']),
        companyEmail: APIHelper.getSafeStringValue(json['company_email']),
        companyPhone: APIHelper.getSafeStringValue(json['company_phone']),
        companyState: APIHelper.getSafeStringValue(json['company_state']),
        companyZipCode: APIHelper.getSafeStringValue(json['company_zipcode']),
        tradeLicense: APIHelper.getSafeStringValue(json['trade_license']),
        vatRegistrationNo:
            APIHelper.getSafeStringValue(json['vat_registration_no']),
        companyCountry: APIHelper.getSafeStringValue(json['company_country']),
        tradeLicenseValidity:
            APIHelper.getSafeDateTimeValue(json['trade_license_validity']),
        vatCertificateImage:
            APIHelper.getSafeStringValue(json['vat_certificate_image']),
        rating: SingleSellerRatingResponse.getAPIResponseObjectSafeValue(
            json['rating']),
        ratingPercentage: APIHelper.getSafeListValue(json['ratingPercentage'])
            .map((e) => SingleSellerRatingPercentageResponse
                .getAPIResponseObjectSafeValue(e))
            .toList(),
        isVerified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'category': category.toJson(),
        'location': location,
        'description': description,
        'logo': logo,
        'nid_number': nidNumber,
        'nid_image': nidImage,
        'address_proof': addressProof,
        'tax_name': taxName,
        'tax_number': taxNumber,
        'status': status,
        'vendor': vendor,
        'products': itemCounts.toJson(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
        'currency_code': currencyCode,
        'currency_symbol': currencySymbol,
        'account_name': accountName,
        'account_number': accountNumber,
        'bank_name': bankName,
        'branch': branch,
        'company_city': companyCity,
        'company_email': companyEmail,
        'company_phone': companyPhone,
        'company_state': companyState,
        'company_zipcode': companyZipCode,
        'trade_license': tradeLicense,
        'vat_registration_no': vatRegistrationNo,
        'company_country': companyCountry,
        'trade_license_validity':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(
                tradeLicenseValidity),
        'vat_certificate_image': vatCertificateImage,
        'rating': rating.toJson(),
        'ratingPercentage': ratingPercentage.map((e) => e.toJson()).toList(),
        'verified': isVerified,
      };

  factory SingleSellerDataResponse.empty() => SingleSellerDataResponse(
      itemCounts: SingleStoreProducts(),
      category: SingleSellerCategoryResponse(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime,
      tradeLicenseValidity: AppComponents.defaultUnsetDateTime,
      rating: SingleSellerRatingResponse.empty());

  static SingleSellerDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleSellerDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleSellerDataResponse.empty();
}

class SingleSellerRatingResponse {
  int totalRating;
  String name;
  String logo;
  SingleSellerCategoryResponse category;
  String id;
  int sellerReviews;
  int positiveSellerReview;
  double avgRating;
  String type;

  SingleSellerRatingResponse({
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

  factory SingleSellerRatingResponse.fromJson(Map<String, dynamic> json) =>
      SingleSellerRatingResponse(
        totalRating: APIHelper.getSafeIntValue(json['totalRating']),
        name: APIHelper.getSafeStringValue(json['name']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        category: SingleSellerCategoryResponse.getAPIResponseObjectSafeValue(
            json['category']),
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

  factory SingleSellerRatingResponse.empty() =>
      SingleSellerRatingResponse(category: SingleSellerCategoryResponse());

  static SingleSellerRatingResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleSellerRatingResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleSellerRatingResponse.empty();

  SellerStatus get status {
    return Helper.getSellerStatus(positiveSellerReview);
  }
}

class SingleSellerCategoryResponse {
  String id;
  String name;

  SingleSellerCategoryResponse({this.id = '', this.name = ''});

  factory SingleSellerCategoryResponse.fromJson(Map<String, dynamic> json) =>
      SingleSellerCategoryResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static SingleSellerCategoryResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleSellerCategoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleSellerCategoryResponse();
}

class SingleSellerRatingPercentageResponse {
  SingleSellerIdResponse id;
  int count;

  SingleSellerRatingPercentageResponse({required this.id, this.count = 0});

  factory SingleSellerRatingPercentageResponse.fromJson(
      Map<String, dynamic> json) {
    return SingleSellerRatingPercentageResponse(
      id: SingleSellerIdResponse.getAPIResponseObjectSafeValue(json['_id']),
      count: APIHelper.getSafeIntValue(json['count']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id.toJson(),
        'count': count,
      };

  factory SingleSellerRatingPercentageResponse.empty() =>
      SingleSellerRatingPercentageResponse(id: SingleSellerIdResponse());

  static SingleSellerRatingPercentageResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleSellerRatingPercentageResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleSellerRatingPercentageResponse.empty();
}

class SingleSellerIdResponse {
  int rating;

  SingleSellerIdResponse({this.rating = 0});

  factory SingleSellerIdResponse.fromJson(Map<String, dynamic> json) =>
      SingleSellerIdResponse(
        rating: APIHelper.getSafeIntValue(json['rating']),
      );

  Map<String, dynamic> toJson() => {
        'rating': rating,
      };

  static SingleSellerIdResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleSellerIdResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleSellerIdResponse();
}

class SingleStoreProducts {
  String id;
  int count;

  SingleStoreProducts({this.id = '', this.count = 0});

  factory SingleStoreProducts.fromJson(Map<String, dynamic> json) =>
      SingleStoreProducts(
        id: APIHelper.getSafeStringValue(json['_id']),
        count: APIHelper.getSafeIntValue(json['count'], 0),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'count': count,
      };

  static SingleStoreProducts getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleStoreProducts.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleStoreProducts();
}
