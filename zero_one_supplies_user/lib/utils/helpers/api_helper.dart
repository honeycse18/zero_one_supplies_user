import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/mixed_product_auction_response.dart';
import 'package:ecomik/models/api_responses/payment_credentials.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
// import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/api_responses/saved_address_response.dart';
import 'package:ecomik/models/api_responses/single_image_upload_response.dart';
import 'package:ecomik/models/api_responses/site_settings_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/exceptions/internet_connection.dart';
import 'package:ecomik/models/exceptions/response_status_code.dart';
import 'package:ecomik/models/local_models/selected_product_attribute.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

class APIHelper {
  static Future<void> preAPICallCheck() async {
    // Check internet connection
    final bool isConnectedToInternet = await isConnectedInternet();
    if (!isConnectedToInternet) {
      throw InternetConnectionException(message: 'Not connected to internet');
    }
  }

  static bool isResponseStatusCodeIn400(int? statusCode) {
    try {
      return (statusCode! >= 400 && statusCode < 500);
    } catch (e) {
      return false;
    }
  }

  static void postAPICallCheck(Response<dynamic> response) {
    /// Handling wrong response handling
    if (response.statusCode == null) {
      // return null;
      throw ResponseStatusCodeException(
          statusCode: response.statusCode,
          message: 'Response code is not valid');
    }
    if (response.statusCode != 200 &&
        !isResponseStatusCodeIn400(response.statusCode)) {
      // return null;
      throw ResponseStatusCodeException(
          statusCode: response.statusCode,
          message: 'Response code is not valid');
    }
    // Try setting response as Map
    final dynamic responseBody = response.body;
    if (responseBody == null) {
      throw Exception('responseBody is null');
    }
    if (responseBody is! Map<String, dynamic>) {
      throw const FormatException('Response type is not Map<String, dynamic>');
    }
  }

  static Map<String, String> getAuthHeaderMap() {
    String loggedInUserBearerToken = Helper.getUserBearerToken();
    return {'Authorization': loggedInUserBearerToken};
  }

  static void handleExceptions(Object? exception) {
    /// API error exception of "connection timed out" handling
    if (exception is InternetConnectionException) {
      AppDialogs.showErrorDialog(
          titleText: 'No internet!',
          messageText: 'Please turn on your wifi or mobile data');
    } else if (exception is SocketException) {
      AppDialogs.showErrorDialog(
          titleText: 'Connection failure!',
          messageText:
              'Connection failure! Please Check your internet connection');
    } else if (exception is FormatException) {
      AppDialogs.showErrorDialog(
          messageText:
              'Connection failure! Please Check your internet connection');
    } else {
      AppDialogs.showErrorDialog(
          messageText:
              'Connection failure! Please Check your internet connection');
    }
  }

  static String getSafeStringValue(Object? unsafeResponseStringValue) {
    const String defaultStringValue = '';
    if (unsafeResponseStringValue == null) {
      return defaultStringValue;
    } else if (unsafeResponseStringValue is String) {
      // Now it is safe
      return unsafeResponseStringValue;
    }
    return defaultStringValue;
  }

  static List<T> getSafeListValue<T>(Object? unsafeResponseListValue) {
    const List<T> defaultListValue = [];
    if (unsafeResponseListValue == null) {
      return defaultListValue;
    } else if (unsafeResponseListValue is List<T>) {
      // Now it is safe
      return unsafeResponseListValue;
    }
    return defaultListValue;
  }

  static DateTime getSafeDateTimeValue(
      Object? unsafeResponseDateTimeStringValue) {
    final DateTime defaultDateTime = AppComponents.defaultUnsetDateTime;
    final String safeDateTimeStringValue =
        getSafeStringValue(unsafeResponseDateTimeStringValue);
    return getDateTimeFromServerDateTimeString(safeDateTimeStringValue) ??
        defaultDateTime;
  }

  static int getSafeIntValue(Object? unsafeResponseIntValue,
      [int defaultIntValue = 0]) {
    if (unsafeResponseIntValue == null) {
      return defaultIntValue;
    } else if (unsafeResponseIntValue is String) {
      return (num.tryParse(unsafeResponseIntValue) ?? defaultIntValue).toInt();
    } else if (unsafeResponseIntValue is num) {
      // Now it is safe
      return unsafeResponseIntValue.toInt();
    }
    return defaultIntValue;
  }

  static double getSafeDoubleValue(Object? unsafeResponseDoubleValue,
      [double defaultDoubleValue = 0]) {
    if (unsafeResponseDoubleValue == null) {
      return defaultDoubleValue;
    } else if (unsafeResponseDoubleValue is String) {
      return (num.tryParse(unsafeResponseDoubleValue) ?? defaultDoubleValue)
          .toDouble();
    } else if (unsafeResponseDoubleValue is num) {
      // Now it is safe
      return unsafeResponseDoubleValue.toDouble();
    }
    return defaultDoubleValue;
  }

  static bool? getBoolFromString(String boolAsString) {
    if (boolAsString == 'true') {
      return true;
    } else if (boolAsString == 'false') {
      return false;
    }
    return null;
  }

  static bool getSafeBoolValue(Object? unsafeResponseBoolValue,
      [bool defaultBoolValue = false]) {
    if (unsafeResponseBoolValue == null) {
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is String) {
      if (GetUtils.isBool(unsafeResponseBoolValue)) {
        return getBoolFromString(unsafeResponseBoolValue) ?? defaultBoolValue;
      }
      return defaultBoolValue;
    } else if (unsafeResponseBoolValue is bool) {
      // Now it is safe
      return unsafeResponseBoolValue;
    }
    return defaultBoolValue;
  }

  static DateTime? getDateTimeFromServerDateTimeString(String dateTimeString) {
    try {
      return AppComponents.apiDateTimeFormat
          .parse(dateTimeString, true)
          .toLocal();
    } catch (e) {
      return null;
    }
  }

  static String toServerDateTimeFormattedStringFromDateTime(DateTime dateTime) {
    return AppComponents.apiDateTimeFormat.format(dateTime.toUtc());
  }

/* 
  static APIResponseObject getSafeResponseObject(Object? unsafeResponseValue) {
    final APIResponseObject defaultValue = APIResponseObject();
    if (unsafeResponseValue == null) {
      return defaultValue;
    } else if (unsafeResponseValue is Map<String, dynamic>) {
      // Now it is safe
      return APIResponseObject.fromJson(unsafeResponseValue);
    }
    return defaultValue;
  }
 */
  static bool isAPIResponseObjectSafe<T>(Object? unsafeValue) {
    if (unsafeValue is Map<String, dynamic>) {
      // Now it is safe
      return true;
    }
    return false;
  }

  static Future<bool> isConnectedInternet() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    return (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.vpn);
  }

  static void onError(String? message, [String? title]) {
    if (message == null) {
      return;
    }
    onFailure(message, title);
  }

  static void onFailure(String message, [String? title]) {
    AppDialogs.showErrorDialog(
        messageText: message.isEmpty ? 'No Response Found!' : message,
        titleText: title);
  }

  static Future<PaymentCredentials?> getPaymentCredentials() async {
    final PaymentCredentialsResponse? response =
        await APIRepo.getPaymentCredentials();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    return response.data;
  }

  static Future<SiteSettings?> getSiteSettings() async {
    SiteSettingsResponse? response = await APIRepo.getSiteSettings();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    AppSingleton.instance.settings = response.data;
    return response.data;
  }

  static void uploadSingleImage(
      Uint8List imageByte,
      void Function(SingleImageUploadResponse, Map<String, dynamic>)
          onSuccessUploadSingleImage,
      {String imageFileName = '',
      String id = '',
      Map<String, dynamic> extras = const {}}) async {
    final File imageFile = await Helper.getTempFileFromImageBytes(imageByte);
    SingleImageUploadResponse? response = await APIRepo.uploadImage(imageFile,
        imageFileName: imageFileName, id: id);
    try {
      await imageFile.delete();
    } catch (e) {}
    if (response == null) {
      AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson()).toString());
    onSuccessUploadSingleImage(response, extras);
  }

  static Future<CartsResponse?> getCarts() async {
    if (!Helper.isUserLoggedIn()) {
      return null;
    }
    final CartsResponse? response = await APIRepo.getCartList();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    return response;
  }

  static Future<StoreWiseCartsResponse?> getStoreWiseCarts() async {
    final StoreWiseCartsResponse? response = await APIRepo.getStoreWiseCarts();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    return response;
  }

  static Future<void> addAProductToCart(String productID,
      {String auction = '',
      bool isAuction = false,
      int quantity = 1,
      bool makeAnOffer = false,
      bool snackbar = true,
      List<SelectedProductAttribute> attributes = const [],
      required String storeID,
      ProductDetailsLocation? productLocation}) async {
    final extraPrice = attributes.fold(
        0.0, (previousValue, element) => previousValue + element.option.price);
    final requestBodyMap = <String, dynamic>{
      'product': productID,
      'extra_price': extraPrice,
      'quantity': quantity,
      'make_an_offer': makeAnOffer,
      'isAuction': isAuction,
    };
    if (attributes.isNotEmpty) {
      requestBodyMap['attributes'] = attributes.map((attribute) {
        final attributeOptionMap = <String, dynamic>{
          '_id': attribute.option.id,
          'label': attribute.option.label,
          'price': attribute.option.price,
        };
        if (attribute.option.value.isNotEmpty) {
          attributeOptionMap['value'] = attribute.option.value;
        }
        return <String, dynamic>{
          'key': attribute.key,
          'option': attributeOptionMap
        };
      }).toList();
    } /* else {
      requestBodyMap.remove('extra_price');
    } */
    if (auction.isNotEmpty) {
      requestBodyMap['auction'] = auction;
    }
    if (storeID.isNotEmpty) if (storeID.isNotEmpty) {
      requestBodyMap['store'] = storeID;
    }
    if (productLocation != null && productLocation.isNotEmpty) {
      requestBodyMap['product_location'] = productLocation.toJson();
    }
    final String requestBodyJson = jsonEncode(requestBodyMap);
    final RawAPIResponse? response =
        await APIRepo.addAProductToCart(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    // On success
    if (snackbar) {
      Helper.showSnackBar('Successfully added to cart!');
    }
  }

  static Future<void> updateAProductFromCart(String cartID, String productID,
      {bool isIncrement = false}) async {
    final requestBodyMap = <String, dynamic>{
      'cart_id': cartID,
      'product': productID,
    };
    if (isIncrement) {
      requestBodyMap['increase'] = true;
    } else {
      requestBodyMap['decrease'] = true;
    }
    final String requestBodyJson = jsonEncode(requestBodyMap);
    final RawAPIResponse? response =
        await APIRepo.updateAProductFromCart(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    // On success
    Helper.showSnackBar('Successfully updated to cart!');
  }

  static Future<void> updateAProductFromStoreWiseCart(
      String cartID, String productID,
      {bool isIncrement = false}) async {
    final requestBodyMap = <String, dynamic>{
      'cart_id': cartID,
      'product': productID,
    };
    if (isIncrement) {
      requestBodyMap['increase'] = true;
    } else {
      requestBodyMap['decrease'] = true;
    }
    final String requestBodyJson = jsonEncode(requestBodyMap);
    final RawAPIResponse? response =
        await APIRepo.updateAProductFromCart(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    // On success
    Helper.showSnackBar('Successfully updated to cart!');
  }

  static Future<void> removeAProductFromCart(String cartID) async {
    final RawAPIResponse? response =
        await APIRepo.removeAProductFromCart(cartID);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    // On success
    Helper.showSnackBar('Successfully removed from cart!');
  }

  static Future<void> removeAProductFromStoreWiseCart(
      String cartID, String productID) async {
    final RawAPIResponse? response =
        await APIRepo.removeAProductFromStoreWiseCart(cartID, productID);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    // On success
    Helper.showSnackBar('Successfully removed from cart!');
  }

  static Future<List<SavedAddress>?> getSavedAddresses() async {
    SavedAddressResponse? response = await APIRepo.getSavedAddress();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return null;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return null;
    }
    log((response.toJson().toString()));
    return response.data;
  }

  static getsafe(String json) {}
}
