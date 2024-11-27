import 'package:ecomik/models/api_responses/coupon_applied_response.dart';

class ShippingAddress1stScreenParameter {
  final CouponAppliedData couponData;

  ShippingAddress1stScreenParameter({
    required this.couponData,
  });

  factory ShippingAddress1stScreenParameter.empty() =>
      ShippingAddress1stScreenParameter(couponData: CouponAppliedData.empty());
}
