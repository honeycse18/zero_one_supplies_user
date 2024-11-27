import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ContactUsScreenController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController massageController = TextEditingController();
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  Future<void> sendMassage() async {
    final Map<String, Object> requestBody = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'subject': subjectController.text,
      'message': massageController.text,
    };
    String requestBodyJson = jsonEncode(requestBody);
    isLoading = true;
    RawAPIResponse? response =
        await APIRepo.submitContactUsMassage(requestBodyJson);
    isLoading = false;
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessSubmitMassage(response);
  }

  void onSuccessSubmitMassage(RawAPIResponse response) async {
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.messageSentTransKey.toCurrentLanguage);
  }

  String? nameFormValidator(String? name) {
    if (name != null) {
      if (name.isEmpty) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
      if (name.length < 3) {
        return AppLanguageTranslation.minLength3TransKey.toCurrentLanguage;
      }
    }
    return null;
  }

  String? massageFormValidator(String? massage) {
    if (massage != null) {
      if (massage.isEmpty) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
      if (massage.length < 3) {
        return AppLanguageTranslation.minLength3TransKey.toCurrentLanguage;
      }
    }
    return null;
  }

  @override
  void onInit() {
    final user = Helper.getUser();
    emailController.text = user.email;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    phoneController.text = user.phone;
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    massageController.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
