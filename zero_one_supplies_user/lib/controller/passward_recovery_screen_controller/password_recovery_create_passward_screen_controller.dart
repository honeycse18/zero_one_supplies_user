/* import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/reset_pass_create_new_pass_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PasswordRecoveryCreateNewPasswordScreenController extends GetxController {
  /// Toggle value of hide new password
  bool toggleHideNewPassword = true;

  /// Toggle value of hide confirm password
  bool toggleHideConfirmPassword = true;

  /// Toggle value of over 5 characters requirement
  bool isPasswordOver5Characters = false;

  /// Toggle value of at least 1 digit number
  bool isPasswordHasAtLeastSingleNumberDigit = false;

  /// Create new password editing controller
  TextEditingController newPasswordEditingController = TextEditingController();
  TextEditingController newPasswordConfirmEditingController =
      TextEditingController();
  String theToken = '_theToken';

  /// Password strong level value
  PasswordStrongLevel passwordStrengthLevel = PasswordStrongLevel.none;

  /// Find if any password text character has number digit.
  bool detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]'));

  /// Check password
  void passwordCheck(String passwordText) {
    setPasswordStrengthLevel(passwordText);
    if (passwordText.length > 5) {
      isPasswordOver5Characters = true;
    } else {
      isPasswordOver5Characters = false;
    }
    if (detectPasswordNumber(passwordText)) {
      isPasswordHasAtLeastSingleNumberDigit = true;
    } else {
      isPasswordHasAtLeastSingleNumberDigit = false;
    }
  }

  /// Simple password strong level algorithm for new password field
  void setPasswordStrengthLevel(String passwordText) {
    final isNumberFound = detectPasswordNumber(passwordText);
    if (passwordText.isEmpty) {
      passwordStrengthLevel = PasswordStrongLevel.none;
    } else {
      if (passwordText.length > 5 && isNumberFound) {
        passwordStrengthLevel = PasswordStrongLevel.strong;
        if (passwordText.length > 11 && isNumberFound) {
          passwordStrengthLevel = PasswordStrongLevel.veryStrong;
        }
      } else if (passwordText.length > 5) {
        passwordStrengthLevel = PasswordStrongLevel.normal;
      } else {
        passwordStrengthLevel = PasswordStrongLevel.weak;
      }
    }
  }

  void onSavePasswordButtonTap() {
    if (passMatched()) {
      savePassword();
    } else {
      AppDialogs.showErrorDialog(messageText: 'Passwords don\'t matched.');
    }
  }

  /* <-------- Initial state --------> */
  // @override
  // void initState() {
  //   newPasswordEditingController = TextEditingController();
  //   newPasswordEditingController.addListener(() {
  //     // if (mounted) {
  //     //   setState(() {
  //         passwordCheck(newPasswordEditingController.text);
  //       // });
  //     // }
  //   });
  //   // super.initState();
  // }

  bool passMatched() {
    return newPasswordConfirmEditingController.text ==
        newPasswordEditingController.text;
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      theToken = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    // newPasswordEditingController = TextEditingController();
    newPasswordEditingController.addListener(() {
      passwordCheck(newPasswordEditingController.text);
    });
    super.onInit();
  }

  Future<void> savePassword() async {
    final Map<String, Object> requestBody = {
      'password': newPasswordEditingController.text,
      'confirmPassword': newPasswordConfirmEditingController.text
    };
    String requestBodyJson = jsonEncode(requestBody);
    ResetPassCreateNewPassResponse? response =
        await APIRepo.resetPassCreateNewPass(requestBodyJson, theToken);
    if (response == null) {
      onErrorSavePassword(response);
      return;
    } else if (response.error) {
      onFailureSavePassword(response);
      return;
    }
    log(response.toJson().toString());
    onSuccessSavePassword(response);
  }

  void onErrorSavePassword(ResetPassCreateNewPassResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureSavePassword(ResetPassCreateNewPassResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onSuccessSavePassword(ResetPassCreateNewPassResponse response) {
    Get.offNamed(AppPageNames.passwordChangSuccessScreen, arguments: theToken);
  }
}
 */

import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/reset_pass_create_new_pass_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/api_repo.dart';

class ResetPasswordCreateNewPasswordController extends GetxController {
  TextEditingController newPassword1EditingController = TextEditingController();
  TextEditingController newPassword2EditingController = TextEditingController();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  String theToken = '_token';

  /// Toggle value of hide new password
  bool toggleHideNewPassword = true;

  /// Toggle value of hide confirm password
  bool toggleHideConfirmPassword = true;

  /// Toggle value of over 5 characters requirement
  bool isPasswordOver5Characters = false;

  /// Toggle value of at least 1 digit number
  bool isPasswordHasAtLeastSingleNumberDigit = false;

  /// Create new password editing controller
  // TextEditingController newPasswordEditingController = TextEditingController();

  /// Password strong level value
  PasswordStrongLevel passwordStrongLevel = PasswordStrongLevel.none;

  /// Find if any password text character has number digit.
  bool _detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]'));

  /// Check password
  void passwordCheck(String passwordText) {
    _setPasswordStrongLevel(passwordText);
    if (passwordText.length > 5) {
      isPasswordOver5Characters = true;
    } else {
      isPasswordOver5Characters = false;
    }
    if (_detectPasswordNumber(passwordText)) {
      isPasswordHasAtLeastSingleNumberDigit = true;
    } else {
      isPasswordHasAtLeastSingleNumberDigit = false;
    }
  }

  /// Simple password strong level algorithm form new password field
  void _setPasswordStrongLevel(String passwordText) {
    final isNumberFound = _detectPasswordNumber(passwordText);
    if (passwordText.isEmpty) {
      passwordStrongLevel = PasswordStrongLevel.none;
    } else {
      if (passwordText.length > 5 && isNumberFound) {
        passwordStrongLevel = PasswordStrongLevel.strong;
        if (passwordText.length > 11 && isNumberFound) {
          passwordStrongLevel = PasswordStrongLevel.veryStrong;
        }
      } else if (passwordText.length > 5) {
        passwordStrongLevel = PasswordStrongLevel.normal;
      } else {
        passwordStrongLevel = PasswordStrongLevel.weak;
      }
    }
  }

  void onSavePasswordButtonTap() {
    if (passMatched()) {
      sendPass();
    } else {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.passDontMassTransKey.toCurrentLanguage);
    }
  }

  bool passMatched() {
    return newPassword1EditingController.text ==
        newPassword2EditingController.text;
  }

  Future<void> sendPass() async {
    final Map<String, Object> requestBody = {
      'password': newPassword1EditingController.text,
      'confirmPassword': newPassword2EditingController.text,
      'role': Constants.userRoleUser,
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    ResetPassCreateNewPassResponse? response =
        await APIRepo.resetPassCreateNewPass(requestBodyJson, theToken);
    isLoading = false;
    log('${response?.toJson()} $theToken');
    if (response == null) {
      onErrorSavePassword(response);
      return;
    } else if (response.error) {
      onFailureSavePassword(response);
      return;
    }
    onSuccessSavePassword();
  }

  void onErrorSavePassword(ResetPassCreateNewPassResponse? response) {
    AppDialogs.showErrorDialog(
        messageText: response?.msg ??
            AppLanguageTranslation.errorSavingPassTransKey.toCurrentLanguage);
  }

  void onFailureSavePassword(ResetPassCreateNewPassResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onSuccessSavePassword() {
    Get.offNamed(AppPageNames.passwordChangSuccessScreen, arguments: theToken);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      theToken = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    // newPasswordEditingController = TextEditingController();
    newPassword1EditingController.addListener(() {
      passwordCheck(newPassword1EditingController.text);
      update();
    });
    super.onInit();
  }
}
