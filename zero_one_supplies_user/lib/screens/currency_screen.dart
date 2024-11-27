import 'package:ecomik/controller/currency_controller.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/language_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyScreen extends StatelessWidget {
  const CurrencyScreen({super.key});

  /// Currently selected language
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrencyScreenController>(
        init: CurrencyScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: true,
                    titleWidget: Text(AppLanguageTranslation
                        .currencyTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top extra spaces
                        AppGaps.hGap15,
                        Text(
                            AppLanguageTranslation
                                .selectCurrencyTransKey.toCurrentLanguage,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.primaryColor)),
                        AppGaps.hGap16,
                        /* <---- English language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentLanguage =
                                LanguageSetting.english;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.usaFlagSVGLogoColor,
                          languageNameText: 'USD',
                          isLanguageSelected: controller.currentLanguage ==
                              LanguageSetting.english,
                        ),
                        AppGaps.hGap16,
                        /* <---- Russian language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentLanguage =
                                LanguageSetting.russian;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName: AppAssetImages.gbpsvg,
                          languageNameText: 'GBP',
                          isLanguageSelected: controller.currentLanguage ==
                              LanguageSetting.russian,
                        ),
                        AppGaps.hGap16,
                        /* <---- French language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentLanguage = LanguageSetting.french;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName: AppAssetImages.bdtsvg,
                          languageNameText: 'BDT',
                          isLanguageSelected: controller.currentLanguage ==
                              LanguageSetting.french,
                        ),
                        AppGaps.hGap16,
                        /* <---- Canada language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentLanguage = LanguageSetting.canada;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.canadaFlagSVGLogoColor,
                          languageNameText: 'CAD',
                          isLanguageSelected: controller.currentLanguage ==
                              LanguageSetting.canada,
                        ),
                        AppGaps.hGap16,
                        /* <---- Australia language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentLanguage =
                                LanguageSetting.australian;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName:
                              AppAssetImages.australiaFlagSVGLogoColor,
                          languageNameText: 'AUS',
                          isLanguageSelected: controller.currentLanguage ==
                              LanguageSetting.australian,
                        ),
                        AppGaps.hGap16,
                        /* <---- German language choice list tile ----> */
                        LanguageListTileWidget(
                          onTap: () {
                            // setState(() {
                            controller.currentLanguage = LanguageSetting.german;
                            controller.update();
                            // });
                          },
                          languageFlagLocalAssetFileName: AppAssetImages.jpysvg,
                          languageNameText: 'JPY',
                          isLanguageSelected: controller.currentLanguage ==
                              LanguageSetting.german,
                        ),
                        // Bottom extra spaces
                        AppGaps.hGap30,
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
