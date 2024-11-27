import 'package:ecomik/utils/helpers/api_helper.dart';

class CouponAppliedResponse {
  bool error;
  String msg;
  CouponAppliedData data;

  CouponAppliedResponse(
      {this.error = false, this.msg = '', required this.data});

  factory CouponAppliedResponse.fromJson(Map<String, dynamic> json) {
    return CouponAppliedResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: CouponAppliedData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory CouponAppliedResponse.empty() =>
      CouponAppliedResponse(data: CouponAppliedData.empty());

  static CouponAppliedResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponAppliedResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CouponAppliedResponse.empty();
}

class CouponAppliedData {
  double subtotal;
  CouponAppliedCoupon coupon;
  CouponAppliedCouponInfo couponInfo;
  String vat;
  double vatAmount;
  double deliveryCharge;
  double total;

  CouponAppliedData({
    this.subtotal = 0,
    required this.coupon,
    required this.couponInfo,
    this.vat = '',
    this.vatAmount = 0,
    this.deliveryCharge = 0,
    this.total = 0,
  });

  factory CouponAppliedData.fromJson(Map<String, dynamic> json) =>
      CouponAppliedData(
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        coupon:
            CouponAppliedCoupon.getAPIResponseObjectSafeValue(json['coupon']),
        couponInfo: CouponAppliedCouponInfo.getAPIResponseObjectSafeValue(
            json['coupon_info']),
        vat: APIHelper.getSafeStringValue(json['vat']),
        vatAmount: APIHelper.getSafeDoubleValue(json['vat_amount']),
        deliveryCharge: APIHelper.getSafeDoubleValue(json['delivery_charge']),
        total: APIHelper.getSafeDoubleValue(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'subtotal': subtotal,
        'coupon': coupon.toJson(),
        'coupon_info': couponInfo.toJson(),
        'vat': vat,
        'vat_amount': vatAmount,
        'delivery_charge': deliveryCharge,
        'total': total,
      };

  factory CouponAppliedData.empty() => CouponAppliedData(
      coupon: CouponAppliedCoupon(), couponInfo: CouponAppliedCouponInfo());

  static CouponAppliedData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponAppliedData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CouponAppliedData.empty();
}

class CouponAppliedCoupon {
  String couponValue;
  double savedMoney;
  double currentSubtotal;

  CouponAppliedCoupon(
      {this.couponValue = '', this.savedMoney = 0, this.currentSubtotal = 0});

  factory CouponAppliedCoupon.fromJson(Map<String, dynamic> json) =>
      CouponAppliedCoupon(
        couponValue: APIHelper.getSafeStringValue(json['coupon_value']),
        savedMoney: APIHelper.getSafeDoubleValue(json['saved_money']),
        currentSubtotal: APIHelper.getSafeDoubleValue(json['current_subtotal']),
      );

  Map<String, dynamic> toJson() => {
        'coupon_value': couponValue,
        'saved_money': savedMoney,
        'current_subtotal': currentSubtotal,
      };

  static CouponAppliedCoupon getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponAppliedCoupon.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CouponAppliedCoupon();
}

class CouponAppliedCouponInfo {
  String code;
  double value;
  String discountType;

  CouponAppliedCouponInfo(
      {this.code = '', this.value = 0, this.discountType = ''});

  factory CouponAppliedCouponInfo.fromJson(Map<String, dynamic> json) =>
      CouponAppliedCouponInfo(
        code: APIHelper.getSafeStringValue(json['code']),
        value: APIHelper.getSafeDoubleValue(json['value']),
        discountType: APIHelper.getSafeStringValue(json['discount_type']),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'value': value,
        'discount_type': discountType,
      };

  static CouponAppliedCouponInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponAppliedCouponInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CouponAppliedCouponInfo();
}
