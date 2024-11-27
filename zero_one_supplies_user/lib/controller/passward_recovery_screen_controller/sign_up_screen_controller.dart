import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecomik/models/api_responses/user_sign_up_response.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegScreenController extends GetxController {
  /// Toggle value of hide password
  RxBool toggleHidePassword = true.obs;

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  bool _toggleAgreeTermsConditions = false;
  bool get toggleAgreeTermsConditions => _toggleAgreeTermsConditions;
  set toggleAgreeTermsConditions(bool value) {
    _toggleAgreeTermsConditions = value;
    update();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  CountryCode currentCountryCode = CountryCode.fromCountryCode('TG');

  final GlobalKey<FormState> userRegFormKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
    log('New Country selected: $countryCode');
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneController.text}';
  }

  String? nameFormValidator(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
      if (text.length < 3) {
        return AppLanguageTranslation.minLength3TransKey.toCurrentLanguage;
      }
    }
    return null;
  }

  String? passwordFormValidator(String? text) {
    if (text != null) {
      final String? passwordErrorText = Helper.passwordFormValidator(text);
      if (passwordErrorText != null) {
        return passwordErrorText;
      }
      if (text != confirmPasswordController.text) {
        return AppLanguageTranslation
            .mustMatchWithConfirmPassTransKey.toCurrentLanguage;
      }
      return null;
    }
    return null;
  }

  String? confirmPasswordFormValidator(String? text) {
    if (text != null) {
      final String? passwordErrorText = Helper.passwordFormValidator(text);
      if (passwordErrorText != null) {
        return passwordErrorText;
      }
      if (text != passwordController.text) {
        return AppLanguageTranslation
            .mustMatchWithPassTransKey.toCurrentLanguage;
      }
      return null;
    }
    return null;
  }

  String? emailFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isEmail(text)) {
        return AppLanguageTranslation
            .invalidEmailFormatTransKey.toCurrentLanguage;
      }
      return null;
    }
    return null;
  }

  String? phoneFormValidator(String? text) {
    if (text != null) {
      if (!GetUtils.isPhoneNumber(text)) {
        return AppLanguageTranslation
            .invalidPhoneFormatTransKey.toCurrentLanguage;
      }
      return null;
    }
    return null;
  }

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  void onToggleAgreeTermsConditions(bool? value) {
    toggleAgreeTermsConditions = value ?? false;
  }

  void onSignUpButtonTap() {
    if (userRegFormKey.currentState?.validate() ?? false) {
      signUp();
    }
  }

  Future<void> signUp() async {
    final Map<String, Object> requestBody = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'phone': getPhoneFormatted(),
      'password': passwordController.text
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    UserSignUpResponse? response = await APIRepo.signUp(requestBodyJson);
    isLoading = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessSignUp(response);
  }

  void _onSuccessSignUp(UserSignUpResponse response) async {
    /* await GetStorage()
        .write(LocalStoredKeyName.loggedInVendorToken, response.token);
    getLoggedInVendorDetails(); */
    switch (AppSingleton.instance.settings.otpOptionAsEnum) {
      case SettingsOTPOption.email:
        Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                email: emailController.text,
                phone: getPhoneFormatted(),
                type: 'email',
                fromScreenName: FromScreenName.signupScreen));
        break;
      case SettingsOTPOption.sms:
        Get.toNamed(AppPageNames.passwordRecoveryVerificationScreen,
            arguments: OTPScreenParameter(
                email: emailController.text,
                phone: getPhoneFormatted(),
                type: 'phone',
                fromScreenName: FromScreenName.signupScreen));
      default:
    }
  }

  Future<void> getLoggedInVendorDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      onErrorGetLoggedInVendorDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInVendorDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInVendorDetails(response);
  }

  void onErrorGetLoggedInVendorDetails(UserDetailsResponse? response) {}

  void onFailureGetLoggedInVendorDetails(UserDetailsResponse response) {}

  void onSuccessGetLoggedInVendorDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    final context = Get.context;
    if (context != null) {
      Get.toNamed(AppPageNames.signUpScreen);
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
