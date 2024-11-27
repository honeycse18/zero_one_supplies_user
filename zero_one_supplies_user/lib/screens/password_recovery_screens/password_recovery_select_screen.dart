import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/password_recovery_select_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordRecoverySelectScreen extends StatefulWidget {
  const PasswordRecoverySelectScreen({super.key});

  @override
  State<PasswordRecoverySelectScreen> createState() =>
      _PasswordRecoverySelectScreenState();
}

class _PasswordRecoverySelectScreenState
    extends State<PasswordRecoverySelectScreen> {
  /// Reset password choice
  ResetPasswordSelectedChoice _currentlySelectedChoice =
      ResetPasswordSelectedChoice.none;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: Image.asset(AppAssetImages.backgroundFullPng).image,
              fit: BoxFit.fill,
            )),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          /* <-------- Empty appbar with back button --------> */
          appBar: CoreWidgets.appBarWidget(screenContext: context),
          /* <-------- Content --------> */
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppGaps.screenPaddingValue),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top extra spaces
                    AppGaps.hGap80,
                    /* <---- Verification icon and text ----> */
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppGaps.hGap20,
                          Text(
                              AppLanguageTranslation
                                  .resetPasswordTransKey.toCurrentLanguage,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displaySmall),
                          AppGaps.hGap16,
                          Text(
                              '${AppLanguageTranslation.verificationCodeSentToPhoneTransKey.toCurrentLanguage} Which is +880 (238) 282 982',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: AppColors.bodyTextColor,
                                      overflow: TextOverflow.clip)),
                        ],
                      ),
                    ),
                    AppGaps.hGap40,
                    /* <---- Password recovery option select ----> */
                    Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* <---- Email option ----> */
                        SelectResetPasswordWidget(
                          titleText: AppLanguageTranslation
                              .sendToMailTransKey.toCurrentLanguage,
                          contentText: AppLanguageTranslation
                              .resetLinkSentToMailTransKey.toCurrentLanguage,
                          isSelected: _currentlySelectedChoice ==
                              ResetPasswordSelectedChoice.mail,
                          currentSelectedRadioValue:
                              ResetPasswordSelectedChoice.mail,
                          groupRadioValue: _currentlySelectedChoice,
                          localSVGIconName: AppAssetImages.messageSVGLogoLine,
                          onTap: () => setState(() => _currentlySelectedChoice =
                              ResetPasswordSelectedChoice.mail),
                        ),
                        AppGaps.hGap24,
                        /* <---- Phone number option ----> */
                        SelectResetPasswordWidget(
                          titleText: AppLanguageTranslation
                              .sendToPhoneTransKey.toCurrentLanguage,
                          contentText: AppLanguageTranslation
                              .resetLinkSentToPhoneTransKey.toCurrentLanguage,
                          currentSelectedRadioValue:
                              ResetPasswordSelectedChoice.phoneNumber,
                          groupRadioValue: _currentlySelectedChoice,
                          isSelected: _currentlySelectedChoice ==
                              ResetPasswordSelectedChoice.phoneNumber,
                          localSVGIconName: AppAssetImages.phoneSVGLogoLine,
                          onTap: () => setState(() => _currentlySelectedChoice =
                              ResetPasswordSelectedChoice.phoneNumber),
                        ),
                      ],
                    )),
                    // Bottom extra spaces
                    AppGaps.hGap30,
                  ],
                ),
              ),
            ),
          ),
          /* <-------- Bottom bar of sign up text --------> */
          bottomNavigationBar: CustomScaffoldBottomBarWidget(
            child: CustomStretchedTextButtonWidget(
              buttonText: AppLanguageTranslation
                  .resetPasswordTransKey.toCurrentLanguage,
              onTap:
                  _currentlySelectedChoice == ResetPasswordSelectedChoice.none
                      ? null
                      : onResetPasswordButtonTap,
            ),
          ),
        ));
  }

  void onResetPasswordButtonTap() {
    switch (_currentlySelectedChoice) {
      case ResetPasswordSelectedChoice.mail:
        // Go to password recovery enter email address screen
        Get.toNamed(AppPageNames.passwordRecoveryEmailScreen);
        break;
      case ResetPasswordSelectedChoice.phoneNumber:
        // Go to password recovery enter phone number screen
        Get.toNamed(AppPageNames.passwordRecoveryPromptScreen);
        break;
      default:
    }
  }
}
