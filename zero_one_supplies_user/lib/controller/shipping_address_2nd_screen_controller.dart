import 'dart:convert';
import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:ecomik/models/api_responses/cash_on_delivery_order_response.dart';
import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/coupon_applied_response.dart';
import 'package:ecomik/models/api_responses/distance_calculation_result_response.dart';
import 'package:ecomik/models/api_responses/order_create_response.dart';
import 'package:ecomik/models/api_responses/order_submit_response.dart';
import 'package:ecomik/models/api_responses/payment_credentials.dart';
import 'package:ecomik/models/api_responses/pickup_stations_with_cost_response.dart';
import 'package:ecomik/models/api_responses/saved_addresses_with_cost_response.dart';
import 'package:ecomik/models/api_responses/site_settings_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/local_models/delivery_pickup_time.dart';
import 'package:ecomik/models/mixins/cart_calculation.dart';
import 'package:ecomik/models/mixins/saved_addresses.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class ShippingAddress2ndScreenController extends GetxController
    with CartCalculations, SavedAddressesGetter {
  int selectedPaymentOptionIndex = -1;
  SavedAddressWithCost? selectedSavedAddress;
  SavedAddressWithCost? orderSelectedSavedAddress;
  List<SavedAddressWithCost> savedAddresses = [];
  bool isPickUpPointTabSelected = false;
  CouponAppliedData couponData = CouponAppliedData.empty();
  SiteSettingsDeliveryArea? selectedArea;
  SiteSettingsPickupArea? selectedPickupArea;
  String orderID = '';
  OrderCreate orderDetails = OrderCreate.empty();
  // double total = 0;
  ShippingAddress2ndScreenParameter screenParameter =
      ShippingAddress2ndScreenParameter.empty();
  DeliveryPickupTime? selectedDeliveryPickupTime;
  bool isSelectedFromPickupPointsScreen = false;
  List<SiteSettingsPickupArea> _pickupAreas = List<SiteSettingsPickupArea>.from(
      AppSingleton.instance.settings.pickupArea);
  PickupStationsWithCost? selectedPickupStation;
  DistanceCalculationResult distanceCalculationResult =
      DistanceCalculationResult.empty();
  PaymentCredentials paymentCredentials = PaymentCredentials.empty();
  List<SiteSettingsDeliveryArea> get areas =>
      AppSingleton.instance.settings.deliveryArea;
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) {
    _isLoading.value = value;
    update();
  }

  List<SiteSettingsPickupArea> get pickupAreas {
    // List<SiteSettingsPickupArea> pickupAreas = List<SiteSettingsPickupArea>.from( AppSingleton.instance.settings.pickupArea);
    if (!isSelectedFromPickupPointsScreen) {
      if (_pickupAreas.length > 5) {
        _pickupAreas = _pickupAreas.getRange(0, 5).toList();
      }
    }
    return _pickupAreas;
  }

  double get totalInUSD {
    final dollarRate = AppSingleton.instance.settings.dollarRate;
    // final totalInUSD = (0.01 + (total / dollarRate));
    final totalInUSD = (totalAmountForView / dollarRate);
    return totalInUSD;
  }

  String get totalInUSDFormatted => totalInUSD.toStringAsFixed(2);

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
    // if (isPickUpPointTabSelected) {
    //   return transactionFeeForView;
    // }
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
    if (isPickUpPointTabSelected) {
      return selectedPickupStation?.totalCost ?? 0;
    } else {
      return selectedSavedAddress?.totalCost ?? 0;
    }
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
  @override
  int get totalAmountForView {
    final double total =
        subTotalAmount + vatAmountForView + shippingChargeForView;
    return total.ceil();
  }

  bool get showPickupPointEstimatedDelivery => selectedPickupStation != null;

  bool get showSelectedSavedAddress => selectedSavedAddress != null;

  bool get showHomeDeliveryEstimatedDelivery => selectedPickupStation != null;

  String get pickupPointEstimatedDeliveryDateTimeForView {
    final String estimatedDeliveryDateFormatted =
        Helper.eeeMMMdFormattedDateTime(pickupPointEstimatedDeliveryDateTime);
    return estimatedDeliveryDateFormatted;
  }

  DateTime get pickupPointEstimatedDeliveryDateTime {
    if (selectedPickupArea != null) {
      DateTime estimatedDateTime = DateTime.now();
      estimatedDateTime = estimatedDateTime
          .add(Duration(days: selectedPickupArea!.estimatedDay));
      return estimatedDateTime;
    }
    return AppComponents.defaultUnsetDateTime;
  }

  String get homeDeliveryEstimatedDeliveryDateTimeForView {
    final String estimatedDeliveryDateFormatted =
        Helper.eeeMMMdFormattedDateTime(homeDeliveryEstimatedDeliveryDateTime);
    return estimatedDeliveryDateFormatted;
  }

  DateTime get homeDeliveryEstimatedDeliveryDateTime {
    if (selectedArea != null) {
      DateTime estimatedDateTime = DateTime.now();
      estimatedDateTime =
          estimatedDateTime.add(Duration(days: selectedArea!.estimatedDay));
      return estimatedDateTime;
    }
    return AppComponents.defaultUnsetDateTime;
  }

  @override
  void onAfterCartsDataSet(StoreWiseCarts cartsData) {
    update();
  }

  Future<void> onFinishAndTapTap() async {
    isLoading = true;
    await APIHelper.getSiteSettings();
    await _getPaymentCredentials();
    if (paymentCredentials.isEmpty) {
      isLoading = false;
      return;
    }
    const int cashOnDeliveryIndex = 0;
    // const int stripeIndex = 1;
    const int paypalIndex = 1;
    const int moovIndex = 2;
    const int togocellIndex = 3;
    switch (selectedPaymentOptionIndex) {
      case cashOnDeliveryIndex:
        createCashOnDeliveryOrder();
        return;
/*       case stripeIndex:
        makeStripePayment();
        return; */
      case paypalIndex:
        makePaypalPayment();
        return;
      case moovIndex:
        makePayGateGlobalPay('MOOV');
        return;
      case togocellIndex:
        makePayGateGlobalPay('TOGOCELL');
        return;
      default:
        return;
    }
  }

  Future<void> makePayGateGlobalPay(String networkName) async {
    const token = 'dedacbe7-7a2c-435a-95f7-145f57e6a848';
    final totalAmount = totalAmountForView;
    final currencySymbol = AppSingleton.instance.settings.currencySymbol;
    final description =
        'For order $orderID complete, you have to pay $totalAmountForView $currencySymbol';
    // final description = 'For%20order%20%23${order?.order_number?.split("-")?.join("") || order?._id || 'complete'},%20You%20have%20to%20pay%20${order?.total}%20${settings?.currency_symbol}';
    final identifier = orderID;
    final network = networkName;
    // final redirectURL = 'https://01supplies.com/user/account?tab=4';
    const redirectURL =
        'zeroonesuppliesuserpaygateglobal://zeroonesupplies.com/payment/paygateglobal?status=success';
    try {
      Uri uri = Uri.parse('https://paygateglobal.com/v1/page');
      uri = uri.replace(queryParameters: {
        'token': token,
        'amount': totalAmountForView.toString(),
        'description': description,
        'identifier': identifier,
        'url': redirectURL,
        'network': network
      });

      bool openBrowserSuccessfully = await Helper.openBrowser(uri.toString());
      isLoading = false;
      if (!openBrowserSuccessfully) {
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .cannotOpenBrowserforPaymentTransKey.toCurrentLanguage);
      }
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .somethingWentWrongTransKey.toCurrentLanguage);
      isLoading = false;
      log(e.toString());
    }
  }

  String getPaypalErrorMessage(dynamic error) {
    String dialogErrorMessage =
        AppLanguageTranslation.failedToPayInPaypalTransKey.toCurrentLanguage;
    if (error == null) {
      return dialogErrorMessage;
    }
    final errorMessage = error['message'];
    if (errorMessage != null &&
        errorMessage is String &&
        errorMessage.isNotEmpty) {
      return '$dialogErrorMessage $errorMessage';
    }
    return dialogErrorMessage;
  }

  double get totalInUSDForPaypal {
    // final str = totalInUSD.toStringAsFixed(3);
    // final properStr = str.substring(0, str.length - 1);
    // return properStr.toDouble();
    return totalInUSD.toStringAsFixed(2).toDouble();
  }

  Future<void> makePaypalPayment() async {
    if (!paymentCredentials.paypal.credentials.active) {
      AppDialogs.showErrorDialog(
          titleText: AppLanguageTranslation.sorryTransKey.toCurrentLanguage,
          messageText: AppLanguageTranslation
              .paypalPaymentisUnavailableRightNowTransKey.toCurrentLanguage);
      isLoading = false;
      return;
    }
    if (totalInUSD < 1) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youCanNotMakePaymentViaPaypalTransKey.toCurrentLanguage);
      isLoading = false;
      return;
    }
    final context = Get.context;
    if (context == null) {
      isLoading = false;
      return;
    }
    final totalAmount = totalInUSDForPaypal;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => UsePaypal(
            sandboxMode: true,
            clientId:
                // AppSingleton.instance.settings.paypal.credentials.clientID,
                paymentCredentials.paypal.credentials.clientID,
            secretKey: paymentCredentials.paypal.credentials.secretKey,
            returnURL: 'https://samplesite.com/return',
            cancelURL: 'https://samplesite.com/cancel',
            transactions: [
              {
                'amount': {
                  'total': totalAmount,
                  'currency': 'USD',
                  'details': {
                    'subtotal': totalAmount,
                    'shipping': '0',
                    'shipping_discount': 0
                  }
                },
                'description': 'The payment transaction description.',
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                'item_list': {
                  'items': [
                    {
                      'name': 'Product',
                      'quantity': 1,
                      'price': totalAmount,
                      'currency': 'USD'
                    }
                  ],

                  // shipping address is not required though
                  /* "shipping_address": {
                    "recipient_name": "Jane Foster",
                    "line1": "Travis County",
                    "line2": "",
                    "city": "Austin",
                    "country_code": "US",
                    "postal_code": "73301",
                    "phone": "+00000000",
                    "state": "Texas"
                  }, */
                }
              }
            ],
            note: 'Contact us for any questions on your order.',
            onSuccess: (Map params) async {
              isLoading = false;
              final RawAPIResponse? response =
                  await finalizePaypalPayment(params['paymentId'] ?? '');
              if (response == null || response.error) {
                APIHelper.onError(response?.msg);
                isLoading = false;
                return;
              }
              log(jsonEncode(params));
              _finishPayment(AppLanguageTranslation
                  .paymentSuccessfullyCompletedTransKey.toCurrentLanguage);
            },
            onError: (error) {
              isLoading = false;
              log('onError: $error');
              AppDialogs.showErrorDialog(
                  messageText: getPaypalErrorMessage(error));
            },
            onCancel: (params) {
              isLoading = false;
              log('cancelled: $params');
              Helper.showSnackBar(AppLanguageTranslation
                  .paypalPaymentCancelledTransKey.toCurrentLanguage);
            }),
      ),
    );
    isLoading = false;
  }

  void makeStripePayment() async {
    if (!paymentCredentials.stripe.credentials.active) {
      AppDialogs.showErrorDialog(
          titleText: AppLanguageTranslation.sorryTransKey.toCurrentLanguage,
          messageText: AppLanguageTranslation
              .stripePaymentisUnavailableRightNowTransKey.toCurrentLanguage);
      isLoading = false;
      return;
    }
    if (totalInUSD < 0.5) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youCanNotMakePaymentViaStripeTransKey.toCurrentLanguage);
      isLoading = false;
      return;
    }
    try {
      final paymentData = await _initPaymentSheet();
      await _confirmPayment(paymentData);
    } catch (e) {
      isLoading = false;
    }
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    GetHttpClient getHttpClient =
        GetHttpClient(baseUrl: 'https://api.stripe.com/v1');
    final Map<String, dynamic> body = {
      // 'amount': (totalInUSD * 100).toInt(),
      // 'currency': 'USD',
      'amount': totalAmountForView.ceil(),
      'currency': AppSingleton.instance.settings.currencyCode,
    };
    final response = await getHttpClient.post(
      '/payment_intents',
      headers: {
        // Bearer token is the secret token from Stripe sample secret token
        'Authorization':
            'Bearer ${paymentCredentials.stripe.credentials.secretKey}',
      },
      contentType: 'application/x-www-form-urlencoded',
      body: body,
    );
    final responseBody = response.body;
    if (responseBody['error'] != null) {
      throw Exception(responseBody['error']);
    }
    return responseBody;
  }

  Future<Map<String, dynamic>> _initPaymentSheet() async {
    try {
      // Step 1. create payment intent on the server
      final data = await _createTestPaymentSheet();

      // create some billingdetails
/*       const billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests */

      log(data.toString());
      // Step 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: data['client_secret'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          // Customer params
          // customerId: data['customer'],
          // customerEphemeralKeySecret: data['ephemeralKey'],
          // Extra params
          primaryButtonLabel: 'Pay now',
          /* applePay: PaymentSheetApplePay(
            merchantCountryCode: 'DE',
          ),
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'DE',
            testEnv: true,
          ), */
          style: ThemeMode.light,
/*           appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.lightBlue,
              primary: Colors.blue,
              componentBorder: Colors.red,
            ),
            shapes: PaymentSheetShape(
              borderWidth: 4,
              shadow: PaymentSheetShadowParams(color: Colors.red),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Color.fromARGB(255, 231, 235, 30),
                  text: Color.fromARGB(255, 235, 92, 30),
                  border: Color.fromARGB(255, 235, 92, 30),
                ),
              ),
            ),
          ), */
          // billingDetails: billingDetails,
        ),
      );
      return data;
    } catch (e) {
      isLoading = false;
      Helper.showSnackBar('Error: $e');
      rethrow;
    }
  }

  Future<void> _confirmPayment(Map<String, dynamic> paymentData) async {
    try {
      // Step 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();
      Helper.showSnackBar(AppLanguageTranslation
          .paymentSuccessfullyCompletedTransKey.toCurrentLanguage);
      final RawAPIResponse? response = await finalizeStripePayment(paymentData);
      if (response == null || response.error) {
        APIHelper.onError(response?.msg);
        isLoading = false;
        return;
      }
      _finishPayment(AppLanguageTranslation
          .paymentSuccessfullyCompletedTransKey.toCurrentLanguage);
    } catch (e) {
      isLoading = false;
      if (e is StripeException) {
        Helper.showSnackBar(
            '${AppLanguageTranslation.errorFromStripeTransKey.toCurrentLanguage} ${e.error.localizedMessage}');
      } else {
        Helper.showSnackBar(AppLanguageTranslation
            .paymentFailedSomethingWentWrongTransKey.toCurrentLanguage);
      }
      rethrow;
    }
  }

  void onHomeDeliveryTabTap() {
    isPickUpPointTabSelected = false;
  }

  void onPickupPointTabTap() {
    isPickUpPointTabSelected = true;
  }

  void onDeliveryPickUpItemTap(DeliveryPickupTime deliveryPickupTime) {
    selectedDeliveryPickupTime = deliveryPickupTime;
    update();
  }

  void onAreaChanged(SiteSettingsDeliveryArea? area) {
    selectedArea = area;
    update();
  }

  void onPickupAreaChanged(SiteSettingsPickupArea? pickupArea) {
    selectedPickupArea = pickupArea;
    update();
  }

  void onSavedAddressChanged(SavedAddressWithCost? savedAddress) {
    selectedSavedAddress = savedAddress;
    update();
  }

  void onSeeAllPickupPointButtonTap() async {
    final result = await Get.toNamed(AppPageNames.allPickupScreen);
    if (result is SiteSettingsPickupArea) {
      isSelectedFromPickupPointsScreen = true;
      selectedPickupArea = result;
      final isDuplicateFound = _pickupAreas
          .any((element) => element.id == (selectedPickupArea?.id ?? ''));
      if (!isDuplicateFound) {
        _pickupAreas.add(selectedPickupArea!);
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

  void onProceedToPaymentButtonTap() {
    Get.toNamed(AppPageNames.checkoutScreen);
    // createOrder();
  }

  String getReceivedTime() {
    if (selectedDeliveryPickupTime == null) {
      return '';
    }
    switch (selectedDeliveryPickupTime!.id) {
      case '1':
        return PreferredDeliveryTimeSlot.fullDay.stringValue;
      case '2':
        return PreferredDeliveryTimeSlot.morning.stringValue;
      case '3':
        return PreferredDeliveryTimeSlot.afternoon.stringValue;
      default:
        return '';
    }
  }

/*   Map<String, dynamic> _createOrderRequestBodyMap() {
    Map<String, dynamic> requestBody = {
      'products': cartsData.cart.products
          .map((cartProduct) => <String, dynamic>{
                'product': cartProduct.product,
                'store': cartProduct.store,
                'name': cartProduct.name,
                'image': cartProduct.image,
                'unit': cartProduct.unit,
                'price': cartProduct.price,
                'quantity': cartProduct.quantity,
                'subtotal': cartProduct.subtotal,
              })
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
        // 'position': selectedSavedAddress?.position.toJson(),
      };
    }
    if (showPickupPointEstimatedDelivery) {
      requestBody['address']['estimated_delivery_day'] =
          APIHelper.toServerDateTimeFormattedStringFromDateTime(
              pickupPointEstimatedDeliveryDateTime);
    }
    if (showHomeDeliveryEstimatedDelivery) {
      requestBody['address']['estimated_delivery_day'] =
          APIHelper.toServerDateTimeFormattedStringFromDateTime(
              homeDeliveryEstimatedDeliveryDateTime);
    }
    return requestBody;
  } */

  Future<void> createCashOnDeliveryOrder() async {
    final Map<String, dynamic> requestBody = {
      'orderInfo': <String, dynamic>{
        '_id': orderID,
        'total': totalAmountForView
      }
    };
    final requestBodyJson = jsonEncode(requestBody);
    CashOnDeliveryOrderResponse? response =
        await APIRepo.submitCashOnDeliveryOrder(requestBodyJson);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    } else if (response.status) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessCreateCashOnDeliveryOrder(response);
  }

  void _onSuccessCreateCashOnDeliveryOrder(
      CashOnDeliveryOrderResponse response) async {
    await _finishPayment(response.msg);
  }

  Future<void> _finishPayment(String messageText) async {
    await Helper.setUserCartProducts([]);
    isLoading = false;
    await AppDialogs.showSuccessDialog(messageText: messageText);
    Get.offAllNamed(AppPageNames.homeNavigatorScreen);
  }

  Future<RawAPIResponse?> finalizeStripePayment(
      Map<String, dynamic> paymentData) async {
    final Map<String, dynamic> requestBody = {
      'paymentIntentId': paymentData['id'],
      'orderInfo': {
        '_id': orderID,
        'description': 'Product payment',
        // 'countryCurrency': 'USD',
        'countryCurrency': AppSingleton.instance.settings.currencyCode,
        'total': totalAmountForView,
      },
      'others': paymentData,
    };
    final requestBodyJson = jsonEncode(requestBody);
    final RawAPIResponse? response =
        await APIRepo.verifyStripePayment(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    log((response.toJson().toString()));
    return response;
  }

  Future<RawAPIResponse?> finalizePaypalPayment(String paypalOrderID) async {
    final Map<String, dynamic> requestBody = {
      'paymentIntentId': paypalOrderID,
      'orderInfo': {
        '_id': orderID,
        'description': 'Product payment',
        'countryCurrency': 'USD',
        'total': totalInUSDForPaypal,
      },
    };
    final requestBodyJson = jsonEncode(requestBody);
    final RawAPIResponse? response =
        await APIRepo.verifyPaypalPayment(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    log((response.toJson().toString()));
    return response;
  }

/*   Future<void> createOrder() async {
    final Map<String, dynamic> requestBody = _createOrderRequestBodyMap();
    final requestBodyJson = jsonEncode(requestBody);
    OrderSubmitResponse? response = await APIRepo.createOrder(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessCreateOrder(response);
  } */

  void _onSuccessCreateOrder(OrderSubmitResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
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
    if (argument is ShippingAddress2ndScreenParameter) {
      screenParameter = argument;
      couponData = screenParameter.couponData;
      cartsData = argument.cartsData;
      orderID = screenParameter.orderID;
      orderDetails = screenParameter.orderDetails;
      isPickUpPointTabSelected = screenParameter.isPickUpPointTabSelected;
      selectedPickupStation = screenParameter.selectedPickupStation;
      selectedSavedAddress = screenParameter.selectedSavedAddress;
      orderSelectedSavedAddress = screenParameter.selectedSavedAddress;
      distanceCalculationResult = screenParameter.distanceCalculationResult;
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

  void _getDollarRate() async {
    await APIHelper.getSiteSettings();
  }

  Future<void> _getPaymentCredentials() async {
    final PaymentCredentials? paymentCredentialsResponse =
        await APIHelper.getPaymentCredentials();
    if (paymentCredentialsResponse != null) {
      paymentCredentials = paymentCredentialsResponse;
      try {
        if (Stripe.publishableKey.isEmpty) {
          Stripe.publishableKey =
              paymentCredentials.stripe.credentials.publishableKey;
        }
      } catch (e) {
        Stripe.publishableKey =
            paymentCredentials.stripe.credentials.publishableKey;
      }
    }
    update();
  }

  @override
  void onInit() {
    _getScreenArgument();
    _checkCompanyVat();
    _getDollarRate();
    getSavedAddresses();
    super.onInit();
  }
}
