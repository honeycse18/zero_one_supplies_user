import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomik/models/api_responses/edit_accound_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterPhoneNumberForGoogleLoginScreenController extends GetxController {
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('TG');
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  void onSendCodeButtonTap() async {
    // sendCode();
    final isSuccess = await _setUserPhoneNumber(phoneNumberFormatted);
    if (isSuccess) {
      Get.back(result: true);
    }
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  String get phoneNumberFormatted =>
      '${currentCountryCode.dialCode}${phoneTextEditingController.text}';

  Future<bool> _setUserPhoneNumber(String phoneNumber) async {
    final Map<String, Object> requestBody = {
      'phone': phoneNumberFormatted,
    };
    String requestBodyJson = jsonEncode(requestBody);
    final token = Get.find<String>(tag: 'token');
    isLoading = true;
    EditAccountResponse? response =
        await APIRepo.editAccount(requestBodyJson, token: token);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return false;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return false;
    }
    // Profile updated
    return true;
  }
}
