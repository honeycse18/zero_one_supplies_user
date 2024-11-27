import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/coupon_applied_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/local_models/sucessfull_coupon.dart';
import 'package:ecomik/models/screen_parameters/shipping_address_1st_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  // Variables
  // double discount = 0;
  CouponAppliedData couponData = CouponAppliedData.empty();
  TextEditingController couponController = TextEditingController();
  List<TextEditingController> couponControllers = [];
  StoreWiseCarts _cartsData = StoreWiseCarts.empty();
  StoreWiseCarts get cartsData => _cartsData;
  set cartsData(StoreWiseCarts value) {
    _cartsData = value;
    couponControllers =
        value.carts.map((e) => TextEditingController()).toList();
    update();
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  List<SuccessfulCoupon> tempCoupons = [];
  List<SuccessfulCoupon> successfullySetCoupons = [];

  int _loadingCouponIndex = -1;
  int get loadingCouponIndex => _loadingCouponIndex;
  set loadingCouponIndex(int value) {
    _loadingCouponIndex = value;
    update();
  }

  // Getters
  bool get isCartEmpty {
    return cartsData.cartProducts.isEmpty;
  }

  double get netPriceAmount {
    // var userCartProducts = Helper.getUserCartProducts();
/*     var userCartProducts = cartsData.cart.products;
    double netPrice = userCartProducts.fold<double>(
        0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
    return netPrice; */
    return cartsData.netAmount;
  }

  double get _subTotalAmount {
    final subTotal = netPriceAmount - discountAmount;
    return subTotal;
  }

  // double get discountAmount => couponData.coupon.savedMoney;
  double get discountAmount => cartsData.totalSaveMoney;
  // double get deliveryChargeAmount => 0;

  double get vatAmount {
    final vatAmountValue = AppSingleton.instance.settings.companyVat.value;
    final CompanyVatType vatType = CompanyVatType.toEnumValue(
        AppSingleton.instance.settings.companyVat.type);
    if (vatType == CompanyVatType.percent) {
      final vatPercentageValue = vatAmountValue / 100;
      return netPriceAmount * vatPercentageValue;
    }
    return vatAmountValue;
  }

  double get totalAmount {
    // final double total = subTotalAmount + vatAmount + deliveryChargeAmount;
    // return _subTotalAmount + vatAmount;
    return cartsData.total;
  }

  // Functions
  Future<void> onCartItemTap(StoreWiseCartProduct cartProduct) async {
    await Get.toNamed(AppPageNames.productDetailsScreen,
        arguments: cartProduct.product);
    await getCarts();
  }

  void onCartItemDeleteTap(StoreWiseCartProduct cartProduct) async {
    await APIHelper.removeAProductFromCart(cartProduct.cartId);
    getCarts();
    update();
  }

  void onCartItemPlusTap(StoreWiseCartProduct cartProduct) async {
    // await Helper.updateCart(cartProduct);
    cartProduct.quantity++;
    await APIHelper.updateAProductFromCart(
        cartProduct.cartId, cartProduct.product,
        isIncrement: true);
    getCarts();
    update();
  }

  void onCartItemMinusTap(StoreWiseCartProduct cartProduct) async {
    if (cartProduct.quantity > 1) {
      // await Helper.updateCart(cartProduct);
      cartProduct.quantity--;
      await APIHelper.updateAProductFromCart(
          cartProduct.cartId, cartProduct.product,
          isIncrement: false);
      getCarts();
      // update();
    } else if (cartProduct.quantity == 1) {
      AppDialogs.showConfirmDialog(
          messageText:
              AppLanguageTranslation.removeCartSmsTransKey.toCurrentLanguage,
          onYesTap: () async {
            // await Helper.removeFromCart(cartProduct.product);
            await APIHelper.updateAProductFromCart(
                cartProduct.cartId, cartProduct.product,
                isIncrement: false);
            getCarts();
            // update();
          });
    }
  }

  void onStoreApplyCouponIconButtonTap(
      String? couponCode, String storeID, int index) {
    if (couponCode == null || couponCode.isEmpty) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .couponCodeCannotbeEmptyTransKey.toCurrentLanguage);
      return;
    }
    applyStoreWiseCartCoupon(
        couponDetails:
            SuccessfulCoupon(couponCode: couponCode, storeID: storeID),
        index: index);
  }

  void onApplyButtonTap() {
    // applyCoupon(couponController.text);
  }

  Future<void> onCheckoutButtonTap() async {
    checkout();
  }

  Future<void> _gotoCheckoutScreen() async {
    await Get.toNamed(AppPageNames.shipping1stScreen,
        arguments: ShippingAddress1stScreenParameter(couponData: couponData));
    getCarts();
  }

/*   Future<void> applyCoupon(String couponCode) async {
    final Map<String, Object> requestBody = {
      'coupon_code': couponCode,
      'products': cartsData.cart.products
          .map((cartProduct) => <String, Object>{
                'product': cartProduct.product,
                'store': cartProduct.store,
                'name': cartProduct.name,
                'image': cartProduct.image,
                'price': cartProduct.price,
                'quantity': cartProduct.quantity,
                'subtotal': cartProduct.price * cartProduct.quantity,
              })
          .toList(),
      'net_price': _subTotalAmount,
    };
    final requestBodyJson = jsonEncode(requestBody);
    CouponAppliedResponse? response =
        await APIRepo.applyCoupon(requestBodyJson);
    if (response == null) {
      _onErrorApplyCoupon(response);
      return;
    } else if (response.error) {
      _onFailureApplyCoupon(response);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessApplyCoupon(response);
  } 

  void _onErrorApplyCoupon(CouponAppliedResponse? response) {
    APIHelper.onError(response?.msg);
  }

  void _onFailureApplyCoupon(CouponAppliedResponse response) {
    APIHelper.onFailure(response.msg);
  }

  void _onSuccessApplyCoupon(CouponAppliedResponse response) {
    couponData = response.data;
    // discount = response.data.coupon.savedMoney;
    update();
  } */
  Future<void> applyStoreWiseCartCoupon(
      {required SuccessfulCoupon couponDetails, int index = -1}) async {
    tempCoupons.clear();
    tempCoupons.addAll(successfullySetCoupons);
    final filteredDuplicateStoreID = tempCoupons
        .where((element) => element.storeID != couponDetails.storeID)
        .toList();
    tempCoupons.clear();
    tempCoupons.addAll(filteredDuplicateStoreID);
    tempCoupons.add(couponDetails);
    final requestBody = tempCoupons.map((e) => e.toJson()).toList();
    final requestBodyJson = jsonEncode(requestBody);
    loadingCouponIndex = index;
    final StoreWiseCartsResponse? response =
        await APIRepo.applyStoreWiseCartCoupon(requestBodyJson);
    loadingCouponIndex = -1;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessApplyStoreWiseCartCoupon(response, couponDetails);
  }

  void _onSuccessApplyStoreWiseCartCoupon(
      StoreWiseCartsResponse response, SuccessfulCoupon appliedCouponDetails) {
    final StoreWiseCart? foundCouponAppliedCart = response.data.carts
        .firstWhereOrNull(
            (element) => element.store.id == appliedCouponDetails.storeID);
    if (foundCouponAppliedCart != null) {
      if (foundCouponAppliedCart.couponInfo.saveMoney == 0) {
        AppDialogs.showErrorDialog(
            messageText: foundCouponAppliedCart.couponInfo.msg);
      } else {
        AppDialogs.showSuccessDialog(
            messageText: foundCouponAppliedCart.couponInfo.msg);
      }
    }
    if (response.data.total != cartsData.total) {
      successfullySetCoupons.clear();
      successfullySetCoupons.addAll(tempCoupons);
    }
    cartsData = response.data;
    update();
  }

  Future<void> checkout() async {
    isLoading = true;
    final response = await APIRepo.checkout(cartsData.toJson());
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessCheckout(response);
  }

  void _onSuccessCheckout(RawAPIResponse response) async {
    _gotoCheckoutScreen();
  }

  void _checkCompanyVat() async {
    if (AppSingleton.instance.settings.companyVat.value == 0) {
      await APIHelper.getSiteSettings();
      update();
    }
  }

  Future<void> getCarts() async {
    final cartsResponse = await APIHelper.getStoreWiseCarts();
    if (cartsResponse == null) {
      return;
    }
    cartsData = cartsResponse.data;
  }

  @override
  void onInit() {
    _checkCompanyVat();
    getCarts();
    super.onInit();
  }

  @override
  void onClose() {
    couponController.dispose();
    couponControllers.forEach((element) {
      element.dispose();
    });
    super.onClose();
  }
}
