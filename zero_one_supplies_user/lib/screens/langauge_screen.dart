import 'package:ecomik/controller/language_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/language_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  /// Currently selected language
  // LanguageSetting currentLanguage = LanguageSetting.english;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageScreenController>(
        init: LanguageScreenController(),
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
                    titleWidget: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.languageTransKey),
                    )),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: CustomScrollView(
                    slivers: [
                      // Top extra spaces
                      const SliverToBoxAdapter(child: AppGaps.hGap15),
                      SliverToBoxAdapter(
                        child: Text(
                            LanguageHelper.currentLanguageText(
                                LanguageHelper.selectLanguageTransKey),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(color: AppColors.primaryColor)),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap16),
                      /* <---- Language choice list ----> */
                      SliverList.separated(
                        itemBuilder: (context, index) {
                          final language = controller.languages[index];
                          return LanguageListTileWidget(
                              // languageFlagLocalAssetFileName: AppAssetImages.usaFlagSVGLogoColor,
                              languageNameText: language.name,
                              isLanguageSelected:
                                  controller.selectedLanguage.id == language.id,
                              onTap: () => controller.onLanguageTap(language));
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap16,
                        itemCount: controller.languages.length,
                      ),
                      // Bottom extra spaces
                      const SliverToBoxAdapter(child: AppGaps.hGap30),
                    ],
                  ),
                ),
              ),
            ));
  }
}
