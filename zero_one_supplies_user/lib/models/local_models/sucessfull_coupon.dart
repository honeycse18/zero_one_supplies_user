class SuccessfulCoupon {
  String couponCode;
  String storeID;

  SuccessfulCoupon({required this.couponCode, required this.storeID});

  Map<String, dynamic> toJson() => {
        'coupon': couponCode,
        'store_id': storeID,
      };
}
