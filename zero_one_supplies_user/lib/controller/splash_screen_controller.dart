import 'dart:developer';

import 'package:ecomik/models/api_responses/language_translations_response.dart';
import 'package:ecomik/models/api_responses/payment_credentials.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final bool isUserLoggedIn = Helper.isUserLoggedIn();

  Future<void> _delayAndGotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // Go to intro or home screen
    isUserLoggedIn ? getMethod() : Get.offAllNamed(AppPageNames.introScreen);
  }

  void getMethod() {
    Get.offNamedUntil(_pageRouteName, (_) => false);
  }

  String get _pageRouteName {
    final String pageRouteName;
    if (Helper.isUserLoggedIn()) {
      if (Helper.isRememberedMe()) {
        pageRouteName = AppPageNames.homeNavigatorScreen;
      } else {
        pageRouteName = AppPageNames.introScreen;
      }
    } else {
      pageRouteName = AppPageNames.introScreen;
    }
    return pageRouteName;
  }

  static Future<void> getLanguageTranslations() async {
    LanguageTranslationsResponse? response =
        await APIRepo.fetchLanguageTranslations();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetLanguageTranslations(response);
  }

  static void _onSuccessGetLanguageTranslations(
      LanguageTranslationsResponse response) async {
    dynamic defaultLanguage =
        AppSingleton.instance.localBox.get(Constants.hiveDefaultLanguageKey);
    bool isDefaultLanguageSet = (defaultLanguage is String);
    for (LanguageTranslation languageTranslation in response.data) {
      languageTranslation.translation[Constants.languageTranslationKeyCode] =
          '${languageTranslation.code}_${languageTranslation.flag}';
      await AppSingleton.instance.localBox
          .put(languageTranslation.name, languageTranslation.translation);
      if (!isDefaultLanguageSet && languageTranslation.isDefault) {
        await AppSingleton.instance.localBox
            .put(Constants.hiveDefaultLanguageKey, languageTranslation.name);
      }
    }
  }

  Future<void> getPaymentCredentials() async {
    final PaymentCredentials? paymentCredentials =
        await APIHelper.getPaymentCredentials();
    if (paymentCredentials != null) {
      Stripe.publishableKey =
          paymentCredentials.stripe.credentials.publishableKey;
    }
  }

  @override
  void onInit() {
    _delayAndGotoNextScreen();
    APIHelper.getSiteSettings();
    if (Helper.isUserLoggedIn()) {
      getPaymentCredentials();
    }
    getLanguageTranslations();
    super.onInit();
  }
}
