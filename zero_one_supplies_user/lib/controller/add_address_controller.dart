import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/saved_address_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/screen_parameters/add_address_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreenController extends GetxController {
  Placemark? selectedAddress;
  SavedAddress? savedAddress;
  LatLng locationLatLng = const LatLng(0, 0);
  SavedAddressDeliveryType addressType = SavedAddressDeliveryType.unknown;
  RxBool isDefaultShippingAddress = false.obs;
  RxBool isDefaultBillingAddress = false.obs;
  RxBool isAddressPrimary = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  // TextEditingController shippingAddressController = TextEditingController();
  // TextEditingController billingAddressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  String get screenTitle {
    if (savedAddress == null) {
      return AppLanguageTranslation.addNewAddressTransKey.toCurrentLanguage;
    }
    return AppLanguageTranslation.editAddressTransKey.toCurrentLanguage;
  }

  String get bottomButtonText {
    if (savedAddress == null) {
      return AppLanguageTranslation.saveAddressTransKey.toCurrentLanguage;
    }
    return AppLanguageTranslation.updateAddressTransKey.toCurrentLanguage;
  }

  void onSaveAddressTap() {
    if (savedAddress == null) {
      submitAddress(isUpdating: false);
      return;
    }
    submitAddress(isUpdating: true);
  }

  void onCancelTap() {
    Get.back();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is AddAddressScreenParameter) {
      selectedAddress = argument.address;
      locationLatLng = argument.latLng;
      savedAddress = argument.savedAddress;
    }
  }

  void _fillUsingSelectedAddress(Placemark? address) {
    if (address == null) {
      return;
    }
    provinceController.text = address.administrativeArea ?? '';
    addressController.text = address.thoroughfare ?? '';
    cityController.text = address.locality ?? '';
    areaController.text = address.subLocality ?? '';
    countryController.text = address.country ?? '';
  }

  void _fillUsingSavedAddress(SavedAddress? savedAddress) {
    if (savedAddress == null) {
      return;
    }

    nameController.text = savedAddress.name;
    phoneController.text = savedAddress.phone;
    provinceController.text = savedAddress.province;
    cityController.text = savedAddress.city;
    areaController.text = savedAddress.area;
    addressController.text = savedAddress.address;
    addressType = SavedAddressDeliveryType.toEnumValue(savedAddress.delivery);
    isDefaultShippingAddress.value = savedAddress.defaultShippingAddress;
    isDefaultBillingAddress.value = savedAddress.defaultBillingAddress;
    landmarkController.text = savedAddress.landmark;
    countryController.text = savedAddress.country;
    isAddressPrimary.value = savedAddress.isPrimary;
  }

  void resetForm() {
    nameController.clear();
    phoneController.clear();
    provinceController.clear();
    cityController.clear();
    areaController.clear();
    addressController.clear();
    addressType = SavedAddressDeliveryType.unknown;
    isDefaultShippingAddress.value = false;
    isDefaultBillingAddress.value = false;
    landmarkController.clear();
    countryController.clear();
    isAddressPrimary.value = false;
  }

  Future<void> submitAddress({bool isUpdating = false}) async {
    final Map<String, dynamic> requestBody = {
      'name': nameController.text,
      'phone': phoneController.text,
      'province': provinceController.text,
      'city': cityController.text,
      'area': areaController.text,
      'address': addressController.text,
      'landmark': landmarkController.text,
      'delivery': addressType.stringValue,
      'shipping_address': addressController.text,
      'default_shipping_address': isDefaultShippingAddress.value,
      'billing_address': addressController.text,
      'default_billing_address': isDefaultBillingAddress.value,
      'country': countryController.text,
      'is_primary': isAddressPrimary.value,
      'position': <String, dynamic>{
        'latitude': locationLatLng.latitude,
        'longitude': locationLatLng.longitude,
      },
    };
    if (isUpdating) {
      requestBody['_id'] = savedAddress?.id;
    }
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    RawAPIResponse? response = await APIRepo.submitAddress(requestBodyJson);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingResponse(response);
  }

  onSuccessGettingResponse(RawAPIResponse response) async {
    resetForm();
    final result =
        await AppDialogs.showSuccessDialog(messageText: response.msg);
    if (result is bool && result) {
      Get.back(result: true);
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    _fillUsingSelectedAddress(selectedAddress);
    _fillUsingSavedAddress(savedAddress);
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    provinceController.dispose();
    cityController.dispose();
    areaController.dispose();
    addressController.dispose();
    landmarkController.dispose();
    countryController.dispose();
    super.onClose();
  }
}
