import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/checkout_details_response.dart';
import 'package:ecomik/models/api_responses/coupon_applied_response.dart';
import 'package:ecomik/models/api_responses/distance_calculation_result_response.dart';
import 'package:ecomik/models/api_responses/order_create_response.dart';
import 'package:ecomik/models/api_responses/pickup_stations_with_cost_response.dart';
import 'package:ecomik/models/api_responses/saved_addresses_with_cost_response.dart';
import 'package:ecomik/models/api_responses/site_settings_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/local_models/delivery_pickup_time.dart';
import 'package:ecomik/models/mixins/cart_calculation.dart';
import 'package:ecomik/models/mixins/saved_addresses.dart';
import 'package:ecomik/models/screen_parameters/shipping_address_1st_screen_parameter.dart';
import 'package:ecomik/models/screen_parameters/shipping_address_2nd_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';

class ShippingAddress1stScreenController extends GetxController
    with CartCalculations, SavedAddressesGetter {
  SavedAddressWithCost? selectedSavedAddress;
  List<SavedAddressWithCost> savedAddresses = [];
  bool _isPickUpPointTabSelected = false;
  bool get isPickUpPointTabSelected => _isPickUpPointTabSelected;
  set isPickUpPointTabSelected(bool value) {
    _isPickUpPointTabSelected = value;
    update();
  }

  CouponAppliedData couponData = CouponAppliedData.empty();
  SiteSettingsDeliveryArea? selectedArea;
  // SiteSettingsPickupArea? selectedPickupArea;
  ShippingAddress1stScreenParameter screenParameter =
      ShippingAddress1stScreenParameter.empty();
  DeliveryPickupTime? selectedDeliveryPickupTime;
  bool isSelectedFromPickupPointsScreen = false;
  // List<SiteSettingsPickupArea> _pickupAreas = List<SiteSettingsPickupArea>.from( AppSingleton.instance.settings.pickupArea);
  final List<PickupStationsWithCost> pickupStations = [];
  PickupStationsWithCost? selectedPickupStation;
  DistanceCalculationResult distanceCalculationResult =
      DistanceCalculationResult.empty();

  List<SiteSettingsDeliveryArea> get areas =>
      AppSingleton.instance.settings.deliveryArea;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

/*   List<SiteSettingsPickupArea> get pickupAreas {
    // List<SiteSettingsPickupArea> pickupAreas = List<SiteSettingsPickupArea>.from( AppSingleton.instance.settings.pickupArea);
    if (!isSelectedFromPickupPointsScreen) {
      if (_pickupAreas.length > 5) {
        _pickupAreas = _pickupAreas.getRange(0, 5).toList();
      }
    }
    return _pickupAreas;
  } */

  @override
  int get totalAmountForView {
    final double total =
        subTotalAmount + vatAmountForView + shippingChargeForView;
    return total.ceil();
  }

  double get distanceFareForView {
    if (isPickUpPointTabSelected) {
      return 0;
    }
    return distanceCalculationResult.myFare.fare;
  }

  String get deliveryDistanceForView {
    return distanceCalculationResult.distance.text.isEmpty
        ? '0.0 km'
        : distanceCalculationResult.distance.text;
  }

  double get _deliveryDistance {
    if (isPickUpPointTabSelected) {
      return 0;
    }
    return distanceCalculationResult.kmDistance;
  }

  double get transactionFeeForView {
    if (isPickUpPointTabSelected) {
      return selectedPickupStation?.totalCost ?? 0;
    } else {
      return selectedSavedAddress?.totalCost ?? 0;
    }
  }

  double get shippingChargeForView {
    if (isPickUpPointTabSelected) {
      return transactionFeeForView;
    }
    return distanceFareForView * _deliveryDistance + transactionFeeForView;
  }

/*   double get netPriceAmount {
    var userCartProducts = Helper.getUserCartProducts();
    double netPrice = userCartProducts.fold<double>(
        0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
    return netPrice;
  }

  double get _subTotalAmount {
    final subTotal = netPriceAmount - discountAmount;
    return subTotal;
  }
 */
  // double get discountAmount => couponData.coupon.savedMoney;

/*   double get vatAmount {
    final vatAmount = AppSingleton.instance.settings.companyVat.value;
    final CompanyVatType vatType = CompanyVatType.toEnumValue(
        AppSingleton.instance.settings.companyVat.type);
    if (vatType == CompanyVatType.percent) {
      final vatPercentageValue = vatAmount / 100;
      return _subTotalAmount * vatPercentageValue;
    }
    return vatAmount;
  }

  double get deliveryChargeAmount {
    return 0;
  }
 */

  @override
  double get deliveryChargeAmountForView {
    if (!isPickUpPointTabSelected) {
      return selectedArea?.amount ?? 0;
    }
    return 0;
  }

  // bool get showDeliveryChargeSection => deliveryChargeAmountForView > 0;

  @override
  // double get discountAmountForView => couponData.coupon.savedMoney;
  double get discountAmountForView => cartsData.carts.fold(0,
      (previousValue, element) => previousValue + element.couponInfo.saveMoney);

/*   double get totalAmount {
    final double total = _subTotalAmount + vatAmount + deliveryChargeAmount;
    return total;
  } */

  bool get showPickupPointEstimatedDelivery => selectedPickupStation != null;

  bool get showSelectedSavedAddress => selectedSavedAddress != null;

  bool get showHomeDeliveryEstimatedDelivery => selectedPickupStation != null;

  String get pickupPointEstimatedDeliveryDateTimeForView {
    String estimatedDeliveryDateFormatted = '';
    if (selectedPickupStation != null) {
      estimatedDeliveryDateFormatted =
          '${selectedPickupStation!.estimatedDeliveryHours} hours';
    }
    return estimatedDeliveryDateFormatted;
  }

/*   DateTime get pickupPointEstimatedDeliveryDateTime {
    if (selectedPickupStation != null) {
      DateTime estimatedDateTime = DateTime.now();
      estimatedDateTime = estimatedDateTime
          .add(Duration(hours: selectedPickupStation!.estimatedDeliveryHours));
      return estimatedDateTime;
    }
    return AppComponents.defaultUnsetDateTime;
  } */

  String get homeDeliveryEstimatedDeliveryDateTimeForView {
    String estimatedDeliveryDateFormatted = '';
    if (selectedSavedAddress != null) {
      estimatedDeliveryDateFormatted =
          '${selectedSavedAddress!.estimatedDeliveryHours} hours';
    }
    return estimatedDeliveryDateFormatted;
  }

  DateTime get homeDeliveryEstimatedDeliveryDateTime {
    if (selectedPickupStation != null) {
      DateTime estimatedDateTime = DateTime.now();
      estimatedDateTime = estimatedDateTime
          .add(Duration(hours: selectedPickupStation!.estimatedDeliveryHours));
      return estimatedDateTime;
    }
    return AppComponents.defaultUnsetDateTime;
  }

  // Functions

  @override
  void onAfterCartsDataSet(StoreWiseCarts cartsData) {
    update();
  }

  void onPickupStationChanged(PickupStationsWithCost? pickupStation) {
    selectedPickupStation = pickupStation;
    if (selectedPickupStation != null) {
      getDistanceCalculationResult();
    }
    update();
  }

  void onHomeDeliveryTabTap() {
    isPickUpPointTabSelected = false;
  }

  void onPickupPointTabTap() {
    isPickUpPointTabSelected = true;
    selectedSavedAddress = null;
    if (selectedPickupStation != null) {
      getDistanceCalculationResult();
    }
    update();
  }

  void onDeliveryPickUpItemTap(DeliveryPickupTime deliveryPickupTime) {
    selectedDeliveryPickupTime = deliveryPickupTime;
    update();
  }

  void onAreaChanged(SiteSettingsDeliveryArea? area) {
    selectedArea = area;
    update();
  }

  void onPickupAreaChanged(PickupStationsWithCost? pickupArea) {
    selectedPickupStation = pickupArea;
    update();
  }

  void onSavedAddressChanged(SavedAddressWithCost? savedAddress) {
    selectedSavedAddress = savedAddress;
    if (selectedPickupStation != null) {
      getDistanceCalculationResult();
    }
    update();
  }

  void onSeeAllPickupPointButtonTap() async {
    final result = await Get.toNamed(AppPageNames.allPickupScreen);
    if (result is PickupStationsWithCost) {
      isSelectedFromPickupPointsScreen = true;
      selectedPickupStation = result;
      final isDuplicateFound = pickupStations
          .any((element) => element.id == (selectedPickupStation?.id ?? ''));
      if (!isDuplicateFound) {
        pickupStations.add(selectedPickupStation!);
      }
      update();
    }
  }

  void onSeeAllSavedAddressesButtonTap() async {
    final result =
        await Get.toNamed(AppPageNames.savedAddressScreen, arguments: true);
    if (result is SavedAddressWithCost) {
      selectedSavedAddress = result;
      final isDuplicateFound = savedAddresses
          .any((element) => element.id == (selectedSavedAddress?.id ?? ''));
      if (!isDuplicateFound) {
        savedAddresses.add(selectedSavedAddress!);
      } else {
        selectedSavedAddress = savedAddresses.firstWhereOrNull(
            (element) => element.id == (selectedSavedAddress?.id ?? ''));
      }
      update();
    }
  }

  bool isValidToCreateOrder() {
    if (!isPickUpPointTabSelected) {
      if (selectedSavedAddress == null) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .youMustSelectSavedAddressTransKey.toCurrentLanguage);
        return false;
      }
    } else {
      if (selectedPickupStation == null) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .youMustSelectPickupStationTransKey.toCurrentLanguage);
        return false;
      }
    }
    if (selectedDeliveryPickupTime == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youMustSelectDeliveryTimeTransKey.toCurrentLanguage);
      return false;
    }
    return true;
  }

  void onProceedToPaymentButtonTap() {
    if (isValidToCreateOrder()) {
      createOrder();
    }
  }

  String getReceivedTime() {
    if (selectedDeliveryPickupTime == null) {
      return '';
    }
    return switch (selectedDeliveryPickupTime!.id) {
      '1' => PreferredDeliveryTimeSlot.fullDay.stringValue,
      '2' => PreferredDeliveryTimeSlot.morning.stringValue,
      '3' => PreferredDeliveryTimeSlot.afternoon.stringValue,
      _ => '',
    };
  }

  Map<String, dynamic> _createOrderRequestBodyMap() {
    int deliveryHours = 0;
    Map<String, dynamic> delivery = {};
    if (isPickUpPointTabSelected) {
      deliveryHours = selectedPickupStation!.estimatedDeliveryHours;
      delivery = {
        'type': 'pickup_point',
        'address': selectedPickupStation!.toJson()
      };
    } else {
      deliveryHours = selectedSavedAddress!.estimatedDeliveryHours;
      delivery = {
        'type': 'home_delivery',
        'address': selectedSavedAddress!.toJson()
      };
    }
/*     Map<String, dynamic> requestBody = {
      'totalProducts': cartsData.totalCarts.carts,
      'netAmount': cartsData.netAmount,
      'company_commission': cartsData.companyCommission,
      'charged_amount': cartsData.chargedAmount,
      'total_save_money': cartsData.totalSaveMoney,
      'total': cartsData.total,
      'product_receive_time': getReceivedTime(),
      'estimated_delivery_hours': deliveryHours,
      'delivery': delivery,
      'orders': cartsData.carts.map((cart) {
        final cartMap = cart.toJson();
        cartMap['store'] = {'name': cart.store.name, '_id': cart.store.id};
        cartMap['products'] = cart.products.map((product) {
          final productMap = product.toJson();
          productMap.remove('product_location');
          return productMap;
        }).toList();
        return cartMap;
      }).toList(),
    }; */
    Map<String, dynamic> requestBody = {
      'totalProducts': cartsData.totalCarts.carts,
      'orders': cartsData.carts.map((order) {
        final orderMap = {
          'total': order.total,
          'products': order.products.map((product) {
            final productMap = {
              'cart_id': product.cartId,
              'product': product.product,
              'attributes': product.attributes.map((e) => e.toJson()).toList(),
              'extra_price': product.extraPrice,
              'quantity': product.quantity,
              'price': product.price,
              'subtotal': product.subtotal,
              'store': product.store,
              'name': product.name,
              'image': product.image,
              'unit': product.unit,
              'categories': {
                '_id': product.categories.id,
                'name': product.categories.name,
              },
              'isAuction': product.isAuction,
/*               'product_location': {
                'type': product.productLocation.type,
                'store': {
                  '_id': product.productLocation.store.id,
                  'name': product.productLocation.store.name,
                  'address': product.productLocation.store.address,
                  'location': {
                    'latitude': product.productLocation.store.location.latitude,
                    'longitude':
                        product.productLocation.store.location.longitude
                  }
                }
              } */
              'product_location': product.productLocation.toJson(),
            };
            if (product.productLocation.productLocationType ==
                ProductLocation.none) {
              productMap.remove('product_location');
            }

            return productMap;
          }).toList(),
          'store': {'_id': order.store.id, 'name': order.store.name},
          'couponInfo': {
            'current_subtotal': order.couponInfo.currentSubtotal,
            'save_money': order.couponInfo.saveMoney,
            'coupon_value': order.couponInfo.couponValue,
            'coupon_code': order.couponInfo.couponCode,
            'msg': order.couponInfo.msg
          }
        };
        if (order.couponInfo.saveMoney == 0) {
          orderMap.remove('couponInfo');
        }
        return orderMap;
      }).toList(),
      'netAmount': cartsData.netAmount,
      'company_commission': cartsData.companyCommission,
      'charged_amount': cartsData.chargedAmount,
      'total_save_money': cartsData.totalSaveMoney,
      'total': totalAmountForView,
      'product_receive_time': getReceivedTime(),
      'estimated_delivery_hours': deliveryHours,
      'delivery': delivery,
    };

/*       // Old
      'products': cartsData.cart.products
          .map(
              (cartProduct) => /* <String, dynamic>{
                'product': cartProduct.product,
                'name': cartProduct.name,
                'image': cartProduct.image,
                'unit': cartProduct.unit,
                'category': cartProduct.categories.name,
                'price': cartProduct.price,
                'quantity': cartProduct.quantity,
                'subtotal': cartProduct.subtotal,
                // 'store': cartProduct.store,
              } */
                  cartProduct.toJson())
          .toList(),
      'net_price': netPriceAmountForView,
      'subtotal': subTotalAmount,
      'vat': vatAmountForView,
      'vat_applied': <String, dynamic>{
        'type': AppSingleton.instance.settings.companyVat.type,
        'value': AppSingleton.instance.settings.companyVat.value
      },
      'total': totalAmountForView,
      'status': 'pending',
      'pickup_station': <String, dynamic>{
        '_id': selectedPickupStation?.destinationRelayPoint.id,
        'name': selectedPickupStation?.destinationRelayPoint.name,
        'address': selectedPickupStation?.destinationRelayPoint.address,
        'charged': selectedPickupStation?.destinationRelayPoint.charge,
        'pickup_location': <String, dynamic>{
          'latitude':
              selectedPickupStation?.destinationRelayPoint.location.latitude,
          'longitude':
              selectedPickupStation?.destinationRelayPoint.location.longitude,
        },
      },
      'received_time': getReceivedTime(),
    };
    if (screenParameter.couponData.couponInfo.value > 0) {
      requestBody['discount'] = discountAmountForView;
      requestBody['discount_coupon'] = <String, dynamic>{
        'code': screenParameter.couponData.couponInfo.code,
        'value': screenParameter.couponData.couponInfo.value,
        'discount_type': screenParameter.couponData.couponInfo.discountType,
      };
    }
    if (selectedArea != null) {
      requestBody['delivery'] = <String, dynamic>{
        'location': selectedArea!.name,
        'amount': selectedArea!.amount,
      };
    }
    if (!isPickUpPointTabSelected.value) {
      requestBody['address'] = <String, dynamic>{
        'location': <String, dynamic>{
          'type': 'office',
          'address': 'Sonadanga, Khulna'
        },
        'received_time': getReceivedTime(),
      };
    }
    if (showSelectedSavedAddress) {
      requestBody['cus_address'] = <String, dynamic>{
        'delivery_type': selectedSavedAddress?.delivery,
        'address_book': selectedSavedAddress?.toJson(),
        'position': selectedSavedAddress?.position.toJson(),
      };
    }
    if (showPickupPointEstimatedDelivery) {
      // requestBody['address']['estimated_delivery_day'] =
      requestBody['estimated_delivery_day'] =
          APIHelper.toServerDateTimeFormattedStringFromDateTime(
              pickupPointEstimatedDeliveryDateTime);
    }
    if (showHomeDeliveryEstimatedDelivery) {
      // requestBody['address']['estimated_delivery_day'] =
      requestBody['estimated_delivery_day'] =
          APIHelper.toServerDateTimeFormattedStringFromDateTime(
              homeDeliveryEstimatedDeliveryDateTime);
    }
    if (!isPickUpPointTabSelected.value) {
      // For home tab selected
      requestBody['delivery'] = <String, dynamic>{
        'distance': distanceCalculationResult.kmDistance,
        'per_km_fare': distanceCalculationResult.myFare.fare,
        'fare': distanceFareForView * _deliveryDistance,
      };
      requestBody['cus_address'] = <String, dynamic>{
        'delivery_type': selectedSavedAddress?.delivery,
        // 'position': selectedSavedAddress?.position.toJson(),
        'address_book': selectedSavedAddress?.toJson(),
      };
    } else {
      // For pickup point tab selected
      requestBody['delivery'] = <String, dynamic>{'fare': null};
      requestBody['cus_address'] = <String, dynamic>{};
    } */
    return requestBody;
  }

  Future<void> createOrder() async {
    Map<String, dynamic> requestBody = {};
    try {
      requestBody = _createOrderRequestBodyMap();
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .somethingWentWrongTransKey.toCurrentLanguage);
      return;
    }
    final requestBodyJson = jsonEncode(requestBody);
    log(requestBodyJson);
    isLoading = true;
    final OrderCreateResponse? response =
        await APIRepo.createOrder(requestBodyJson);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessCreateOrder(response);
  }

  void _onSuccessCreateOrder(OrderCreateResponse response) {
    // AppDialogs.showSuccessDialog(messageText: response.msg);
    Helper.showSnackBar(response.msg);
    Get.toNamed(AppPageNames.shipping2ndScreen,
        arguments: ShippingAddress2ndScreenParameter(
            couponData: screenParameter.couponData,
            cartsData: cartsData,
            orderID: response.data.firstOrNull?.id ?? '',
            orderDetails: response.data.firstOrNull ?? OrderCreate.empty(),
            distanceCalculationResult: distanceCalculationResult,
            isPickUpPointTabSelected: isPickUpPointTabSelected,
            selectedPickupStation: selectedPickupStation,
            selectedSavedAddress: selectedSavedAddress,
            total: response.data.firstOrNull?.total ?? 0));
  }

  @override
  void onSuccessGetSavedAddresses(SavedAddressesWithCostResponse response) {
    savedAddresses = response.data;
    if (savedAddresses.length > 5) {
      savedAddresses = savedAddresses.getRange(0, 5).toList();
    }
    update();
  }

  void _getScreenArgument() {
    dynamic argument = Get.arguments;
    if (argument is ShippingAddress1stScreenParameter) {
      screenParameter = argument;
    }
  }

  void _checkCompanyVat() async {
    if (AppSingleton.instance.settings.companyVat.value == 0) {
      await APIHelper.getSiteSettings();
      update();
    }
    _checkCompanyPickupAreas();
  }

  void _checkCompanyPickupAreas() async {
    if (AppSingleton.instance.settings.pickupArea.isEmpty) {
      await APIHelper.getSiteSettings();
      update();
    }
  }

  Future<void> getPickupStations(int pageNumber) async {
    PickupStationsWithCostResponse? response =
        await APIRepo.getPickupStationsWithCost();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetPickupStations(response);
  }

  void onSuccessGetPickupStations(PickupStationsWithCostResponse response) {
    // final isFirstPage = response.data.page == 1;
    // if (isFirstPage) {
    //   pickupStations.clear();
    // }
    // final isLastPage = !response.data.hasNextPage;
    // if (isLastPage) {
    //   pickupStations.addAll(response.data.docs);
    //   update();
    //   return;
    // }
    // final int nextPage = response.data.page + 1;
    // pickupStations.addAll(response.data.docs);
    pickupStations.addAll(response.data);
    update();
    // getPickupStations(nextPage);
  }

  Future<void> getDistanceCalculationResult() async {
    final Map<String, dynamic> requestBodyMap = <String, dynamic>{
      'source': <String, dynamic>{
        'latitude': selectedPickupStation?.position.latitude ?? 0,
        'longitude': selectedPickupStation?.position.longitude ?? 0,
      },
      'destination': <String, dynamic>{
        // 'latitude': selectedSavedAddress?.position.latitude ?? 0,
        // 'longitude': selectedSavedAddress?.position.longitude ?? 0,
        'latitude': 0,
        'longitude': 0,
      }
    };
    final String requestBodyMapJson = jsonEncode(requestBodyMap);
    DistanceCalculationResultResponse? response =
        await APIRepo.getDistanceCalculationResult(requestBodyMapJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetDistanceCalculationResult(response);
  }

  void onSuccessGetDistanceCalculationResult(
      DistanceCalculationResultResponse response) {
    distanceCalculationResult = response.data;
    update();
  }

  void _getCarts() async {
    final CheckoutDetailsResponse? response =
        await APIRepo.getCheckoutDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    cartsData = response.data.cartData;
    update();
  }

  @override
  void onInit() {
    _getScreenArgument();
    _getCarts();
    couponData = screenParameter.couponData;
    _checkCompanyVat();
    getSavedAddresses();
    getPickupStations(1);
    super.onInit();
  }
}
