import 'package:ecomik/models/api_responses/coupon_list_response.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class ProductCouponBottomSheetController extends GetxController {
  // Variables
  List<Coupon> coupons = const [];

  // Getters

  // Functions
  Future<void> onCouponTap(Coupon coupon) async {
    await Helper.copyToClipBoard(coupon.code);
    Get.back(result: true);
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is List<Coupon>) {
      coupons = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}
