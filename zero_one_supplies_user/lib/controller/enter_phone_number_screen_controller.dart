import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomik/models/api_responses/send_otp_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterPhoneNumberScreenController extends GetxController {
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('TG');
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  void onSendCodeButtonTap() {
    sendCode();
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  String get phoneNumberFormatted =>
      '${currentCountryCode.dialCode}${phoneTextEditingController.text}';

  Future<void> sendCode() async {
    final String token = Get.find<String>(tag: 'token');
    final Map<String, Object> requestBody = {
      'phone': phoneNumberFormatted,
      'token': token,
      'role': Constants.userRoleUser,
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    SendOtpResponse? response =
        await APIRepo.sendVerifyUserOTP(requestBodyJson);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessSendCode(response);
  }

  void _onSuccessSendCode(SendOtpResponse response) {
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offNamed(AppPageNames.passwordRecoveryVerificationScreen,
          arguments: OTPScreenParameter(
              phone: phoneNumberFormatted,
              type: 'phone',
              fromScreenName: FromScreenName.googleSignupScreen));
    }
  }
}
