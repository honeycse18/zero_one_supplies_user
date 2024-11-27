import 'dart:developer';

import 'package:ecomik/models/api_responses/languages_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:get/get.dart';

class LanguageScreenController extends GetxController {
  List<Language> languages = [];
  Language selectedLanguage = Language();

  void onLanguageTap(Language language) async {
    selectedLanguage = language;
    update();
    await AppSingleton.instance.localBox
        .put(Constants.hiveDefaultLanguageKey, language.name);
  }

  Future<void> getLanguages() async {
    LanguagesResponse? response = await APIRepo.fetchLanguages();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetLanguages(response);
  }

  void _onSuccessGetLanguages(LanguagesResponse response) async {
    languages = response.data.where((language) => language.active).toList();
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(Constants.hiveDefaultLanguageKey);
    if (currentLanguageName is String) {
      final Language? foundLanguage = languages
          .firstWhereOrNull((language) => language.name == currentLanguageName);
      if (foundLanguage != null) {
        selectedLanguage = foundLanguage;
      }
    }
    update();
  }

  @override
  void onInit() {
    getLanguages();
    // AppSingleton.instance.localBox.get(Constants.hiveDefaultLanguageKey);
    super.onInit();
  }
}
