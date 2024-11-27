import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/edit_accound_response.dart';
import 'package:ecomik/models/api_responses/otp_verify_response.dart';
import 'package:ecomik/models/api_responses/reset_password_otp_response.dart';
import 'package:ecomik/models/api_responses/send_otp_response.dart';
import 'package:ecomik/models/api_responses/sign_up_otp_verification_response.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_local_stored_keys.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResetPasswordOtpVerificationController extends GetxController {
  TextEditingController otpInputTextController = TextEditingController();

  OTPScreenParameter otpScreenParameter = OTPScreenParameter();
  bool isResent = false;
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  /// OTP timer duration value
  Duration otpTimerDuration = const Duration();

  /// OTP timer
  Timer otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is OTPScreenParameter) {
      otpScreenParameter = argument;
    }
  }

  bool isDurationOver() {
    return otpTimerDuration.inSeconds <= 0;
  }

  void onSendCodeButtonTap() {
    sendCode();
  }

  void onResendButtonTap() {
    /* if (isDurationOver()) {
      _resetTimer();
      resendCode();
    } else {
      AppDialogs.showErrorDialog(messageText: 'Please wait few more seconds');
    } */
    resendCode();
  }

  void _resetTimer() {
    otpTimerDuration = const Duration(minutes: 2);
  }

  Future<void> resendCode() async {
    isResent = true;
    if (otpScreenParameter.fromScreenName ==
        FromScreenName.resetOrForgetPassScreen) {
      final Map<String, Object> requestBody = {
        'user_input': (otpScreenParameter.type == 'email')
            ? otpScreenParameter.email
            : otpScreenParameter.phone,
        'type': otpScreenParameter.type,
        'role': Constants.userRoleUser,
      };
      String requestBodyJson = jsonEncode(requestBody);
      isLoading = true;
      ResetPasswordOtpResponse? response =
          await APIRepo.sendResetOtp(requestBodyJson);
      isLoading = false;
      if (response == null) {
        onErrorResendCode(response);
        return;
      } else if (response.error) {
        onFailureResendCode(response);
        return;
      }
      log((response.toJson()).toString());
      onSuccessResendCode();
    } else {
      final Map<String, Object> requestBody = {};
      switch (AppSingleton.instance.settings.otpOptionAsEnum) {
        case SettingsOTPOption.email:
          requestBody['email'] = otpScreenParameter.email;
          break;
        case SettingsOTPOption.sms:
          requestBody['phone'] = otpScreenParameter.phone;
          break;
        default:
          requestBody['email'] = otpScreenParameter.email;
      }
      // final Map<String, Object> requestBody = {
      //   'phone': otpScreenParameter.userInput
      // };
      if (otpScreenParameter.fromScreenName ==
          FromScreenName.googleSignupScreen) {
        final token = Get.find<String>(tag: 'token');
        requestBody['token'] = token;
      }
      String requestBodyJson = jsonEncode(requestBody);
      SendOtpResponse? response =
          await APIRepo.sendVerifyUserOTP(requestBodyJson);
      if (response == null) {
        onErrorResendOTP(response);
        return;
      } else if (response.error) {
        onFailureResendOTP(response);
        return;
      }
      log(response.toJson().toString());
      onSuccessResendCode();
    }
  }

// For ResetPassword OTP
  void onErrorResendCode(ResetPasswordOtpResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureResendCode(ResetPasswordOtpResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onSuccessResendCode() {
    _resetTimer();
  }

// For SignUp page OTP
  void onErrorResendOTP(SendOtpResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureResendOTP(SendOtpResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  Future<void> sendCode() async {
    if (otpScreenParameter.fromScreenName ==
        FromScreenName.resetOrForgetPassScreen) {
      final Map<String, Object> requestBody = {
        'otp': otpInputTextController.text,
        'user_input': (otpScreenParameter.type == 'email')
            ? otpScreenParameter.email
            : otpScreenParameter.phone,
        'role': Constants.userRoleUser,
      };
      String requestBodyJson = jsonEncode(requestBody);
      isLoading = true;
      OtpVerifyResponse? response =
          await APIRepo.verifyOtpForResetPass(requestBodyJson);
      isLoading = false;
      if (response == null) {
        APIHelper.onError(response?.msg);
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log((response.toJson().toString()).toString());
      _onSuccessResponse(response);
    } else {
      final Map<String, Object> requestBody = {
        // 'phone': otpScreenParameter.phone,
        'otp': otpInputTextController.text
      };
      /* if (otpScreenParameter.fromScreenName ==
          FromScreenName.verifyUnverified) {
        requestBody['email'] = otpScreenParameter.email;
      } else  */ /* else {
        if (isResent) {
          requestBody['email'] = otpScreenParameter.email;
        } else {
          requestBody['phone'] = otpScreenParameter.phone;
        }
      } */
      switch (AppSingleton.instance.settings.otpOptionAsEnum) {
        case SettingsOTPOption.email:
          requestBody['email'] = otpScreenParameter.email;
          break;
        case SettingsOTPOption.sms:
          requestBody['phone'] = otpScreenParameter.phone;
          break;
        default:
          requestBody['email'] = otpScreenParameter.email;
      }

      if (otpScreenParameter.fromScreenName ==
          FromScreenName.googleSignupScreen) {
        final token = Get.find<String>(tag: 'token');
        final emailAddress = Get.find<String>(tag: 'email_address');
        requestBody['token'] = token;
        requestBody['email'] = emailAddress;
      }
      String requestBodyJson = jsonEncode(requestBody);
      isLoading = true;
      SignUpOtpVerificationResponse? response =
          await APIRepo.signUpOtpVerification(requestBodyJson);
      isLoading = false;
      if (response == null) {
        APIHelper.onError(response?.msg);
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      _onSuccessResponseOfVendorVerify(response);
    }
  }

  void _onSuccessResponse(OtpVerifyResponse response) {
    BuildContext? context = Get.context;

    if (context != null) {
      Get.offNamed(AppPageNames.passwordRecoveryCreateScreen,
          arguments: response.token);
    }
  }

  // From sign in page
  void onErrorResponseOfVendorVerify(SignUpOtpVerificationResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureResponseVendorVerify(SignUpOtpVerificationResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void _onSuccessResponseOfVendorVerify(
      SignUpOtpVerificationResponse response) async {
    if (otpScreenParameter.fromScreenName == FromScreenName.signupScreen ||
        otpScreenParameter.fromScreenName == FromScreenName.verifyUnverified) {
      BuildContext? context = Get.context;
      if (context != null) {
        Get.offNamed(AppPageNames.signInScreen);
      }
    } else if (otpScreenParameter.fromScreenName ==
        FromScreenName.googleSignupScreen) {
      final isSuccessSetPhone = await _setUserPhoneNumber();
      if (!isSuccessSetPhone) {
        return;
      }
      final isSuccessSaveDetails = await _saveUserTokenAndDetails();
      if (!isSuccessSaveDetails) {
        return;
      }
      await Get.delete<String>(tag: 'token');
      await Get.delete<String>(tag: 'email_address');
      _gotoHomeScreen();
    }
  }

  Future<bool> _setUserPhoneNumber() async {
    final Map<String, Object> requestBody = {
      'phone': otpScreenParameter.phone,
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

  Future<bool> _saveUserTokenAndDetails() async {
    final token = Get.find<String>(tag: 'token');
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return false;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return false;
    }
    // Successfully get user details
    await GetStorage().write(LocalStoredKeyName.loggedInVendorToken, token);
    await Helper.setLoggedInUserToLocalStorage(response.data);
    return true;
  }

  void _gotoHomeScreen() {
    Get.toNamed(AppPageNames.homeNavigatorScreen);
  }

  @override
  void onInit() {
    _getScreenParameter();
    otpTimerDuration = const Duration(minutes: 2);
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimerDuration.inSeconds > 0) {
        otpTimerDuration = otpTimerDuration - const Duration(seconds: 1);
      }
      update();
    });
    // if (!otpScreenParameter.isFromResetPassPage) {
    //   resendCode();
    // }
    super.onInit();
  }

  @override
  void onClose() {
    if (otpTimer.isActive) {
      otpTimer.cancel();
    }
    super.onClose();
  }
}

/* 

  /// OTP timer duration value
  Duration _otpTimerDuration = const Duration();

  /// OTP timer
  Timer _otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );
  @override
  void initState() {
    _otpTimerDuration = const Duration(minutes: 1);
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_otpTimerDuration.inSeconds > 0) {
          _otpTimerDuration = _otpTimerDuration - const Duration(seconds: 1);
        }
      });
    });
    super.initState();
  }




  
  /* <-------- Exit state --------> */
  @override
  void dispose() {
    if (_otpTimer.isActive) {
      _otpTimer.cancel();
    }
    super.dispose();
  }
 */
