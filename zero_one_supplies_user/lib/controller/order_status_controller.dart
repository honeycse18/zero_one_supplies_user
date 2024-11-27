import 'dart:developer';

import 'package:ecomik/models/api_responses/single_product_order_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class OrderStatusScreenController extends GetxController {
  RxBool isActiveSelected = true.obs;
  String currentOrderStatus = Constants.myOrderStatusTypeConfirm;
  String orderedProduct = '';
  SingleProductOrderItem orderDetails = SingleProductOrderItem.empty();
  List<SingleProductOrder> orders = [];
  List<SingleProductOrderProduct> orderProductItem = [];

  /// Get delivered order stepper widget based on current order status
  ///
  /// // Add Everywhere when we need to toggle add to favorite list  -- End

  Future<void> getSingleOrder(String productId) async {
    SingleProductOrderResponse? response =
        await APIRepo.getSingleOrder(productId);
    if (response == null) {
      onErrorGetSingleOrder(response);
      return;
    } else if (response.error) {
      onFailureGetSingleOrder(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetSingleOrder(response);
  }

  void onErrorGetSingleOrder(SingleProductOrderResponse? response) {}

  void onFailureGetSingleOrder(SingleProductOrderResponse response) {}
  void onSuccessGetSingleOrder(SingleProductOrderResponse response) {
    orderDetails = response.data;
    currentOrderStatus = orderDetails.status;
    orders = orderDetails.orders;
    update();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      orderedProduct = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    getSingleOrder(orderedProduct);
    super.onInit();
  }
}
