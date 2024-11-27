import 'package:ecomik/controller/passward_recovery_screen_controller/password_change_success_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangSuccessScreen extends StatelessWidget {
  const PasswordChangSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordChangeSuccessScreenController>(
        init: PasswordChangeSuccessScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: Image.asset(AppAssetImages.backgroundFullPng).image,
                    fit: BoxFit.fill,
                  )),
              child: Scaffold(
                  /* <-------- Empty appbar with back button --------> */
                  appBar: CoreWidgets.appBarWidget(screenContext: context),
                  /* <-------- Content --------> */
                  body: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /* <---- Password change success illustration ----> */
                          Image.asset(
                              AppAssetImages.passwordChangeSuccessIllustration,
                              cacheHeight: (240 * 1.5).toInt(),
                              cacheWidth: (260 * 1.5).toInt(),
                              height: 240,
                              width: 260),
                          AppGaps.hGap56,
                          HighlightAndDetailTextWidget(
                              isSpaceShorter: true,
                              slogan: AppLanguageTranslation
                                  .greatPassChangedTransKey.toCurrentLanguage,
                              subtitle: AppLanguageTranslation
                                  .dontWorryWillLetYouKnowTransKey
                                  .toCurrentLanguage),
                          AppGaps.hGap30,
                        ],
                      ),
                    ),
                  ),
                  /* <-------- Bottom bar button --------> */
                  bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: CustomStretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .keepMeLoggedInTransKey.toCurrentLanguage,
                        onTap: () {
                          // Go to home screen
                          controller.onKeepMeLoggedInButtonTap();
                          // Get.toNamed(AppPageNames.homeNavigatorScreen);
                        }),
                  )),
            ));
  }
}
