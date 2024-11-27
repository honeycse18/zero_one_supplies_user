import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class CouponListsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<Coupon> data;

  CouponListsResponse({this.error = false, this.msg = '', required this.data});

  factory CouponListsResponse.fromJson(Map<String, dynamic> json) {
    return CouponListsResponse(
        error: json['error'] as bool,
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: PaginatedDataResponse.getAPIResponseObjectSafeValue(json['data'],
            docFromJson: (data) => Coupon.getAPIResponseObjectSafeValue(data)));
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((data) => data.toJson()),
      };

  factory CouponListsResponse.empty() => CouponListsResponse(
        data: PaginatedDataResponse.empty(),
      );
  static CouponListsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponListsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CouponListsResponse.empty();
}

class Coupon {
  String id;
  String store;
  String name;
  String code;
  double value;
  String discountType;
  bool freeShipping;
  bool active;
  bool isNavbar;
  bool isNewsletter;
  int usageLimitPerCoupon;
  int usageLimitPerCustomer;
  double minSpend;
  DateTime startDate;
  DateTime endDate;
  String description;
  bool isApp;
  DateTime createdAt;
  DateTime updatedAt;

  Coupon({
    this.id = '',
    this.store = '',
    this.name = '',
    this.code = '',
    this.value = 0,
    this.discountType = '',
    this.freeShipping = false,
    this.active = false,
    this.isNavbar = false,
    this.isNewsletter = false,
    this.usageLimitPerCoupon = 0,
    this.minSpend = 0,
    required this.startDate,
    required this.endDate,
    this.description = '',
    this.isApp = false,
    required this.createdAt,
    required this.updatedAt,
    this.usageLimitPerCustomer = 0,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: APIHelper.getSafeStringValue(json['_id']),
        store: APIHelper.getSafeStringValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        value: APIHelper.getSafeDoubleValue(json['value']),
        discountType: APIHelper.getSafeStringValue(json['discount_type']),
        freeShipping: APIHelper.getSafeBoolValue(json['free_shipping']),
        active: APIHelper.getSafeBoolValue(json['active']),
        isNavbar: APIHelper.getSafeBoolValue(json['is_navbar']),
        isNewsletter: APIHelper.getSafeBoolValue(json['is_newsletter']),
        usageLimitPerCoupon:
            APIHelper.getSafeIntValue(json['usage_limit_per_coupon']),
        usageLimitPerCustomer:
            APIHelper.getSafeIntValue(json['usage_limit_per_customer']),
        minSpend: APIHelper.getSafeDoubleValue(json['min_spend']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        description: APIHelper.getSafeStringValue(json['description']),
        isApp: APIHelper.getSafeBoolValue(json['isApp']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'store': store,
        'name': name,
        'code': code,
        'value': value,
        'discount_type': discountType,
        'free_shipping': freeShipping,
        'active': active,
        'is_navbar': isNavbar,
        'is_newsletter': isNewsletter,
        'usage_limit_per_coupon': usageLimitPerCoupon,
        'usage_limit_per_customer': usageLimitPerCustomer,
        'min_spend': minSpend,
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'description': description,
        'isApp': isApp,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory Coupon.empty() => Coupon(
      createdAt: AppComponents.defaultUnsetDateTime,
      endDate: AppComponents.defaultUnsetDateTime,
      startDate: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static Coupon getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Coupon.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Coupon.empty();

  DiscountType get discountTypeEnum => DiscountType.toEnumValue(discountType);
}
