import 'package:ecomik/controller/passward_recovery_screen_controller/password_recovery_create_passward_screen_controller.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/password_recovery_create_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PasswordRecoveryCreatePasswordScreen extends StatelessWidget {
  const PasswordRecoveryCreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordCreateNewPasswordController>(
      init: ResetPasswordCreateNewPasswordController(),
      builder: (controller) => DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(AppAssetImages.backgroundFullPng).image,
                fit: BoxFit.fill)),
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
                          HighlightAndDetailTextWidget(
                              slogan: AppLanguageTranslation
                                  .createNewPasswordTransKey.toCurrentLanguage,
                              subtitle: AppLanguageTranslation
                                  .createNewPasswordSubtitleTransKey
                                  .toCurrentLanguage),
                        ],
                      ),
                    ),
                    AppGaps.hGap40,
                    /* <---- Create new password text field ----> */
                    CustomTextFormField(
                      controller: controller.newPassword1EditingController,
                      hasShadow: false,
                      isPasswordTextField: controller.toggleHideNewPassword,
                      labelText: AppLanguageTranslation
                          .newPasswordTransKey.toCurrentLanguage,
                      hintText: '********',
                      prefixIcon:
                          SvgPicture.asset(AppAssetImages.unlockSVGLogoLine),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          color: Colors.transparent,
                          onPressed: () {
                            controller.toggleHideNewPassword =
                                !controller.toggleHideNewPassword;
                            controller.update();
                          },
                          icon: SvgPicture.asset(AppAssetImages.hideSVGLogoLine,
                              color: controller.toggleHideNewPassword
                                  ? AppColors.bodyTextColor
                                  : AppColors.primaryColor)),
                    ),
                    AppGaps.hGap24,
                    /* <---- Create confirm password text field ----> */
                    CustomTextFormField(
                      controller: controller.newPassword2EditingController,
                      hasShadow: false,
                      isPasswordTextField: controller.toggleHideConfirmPassword,
                      labelText: AppLanguageTranslation
                          .confirmPasswordTransKey.toCurrentLanguage,
                      hintText: '********',
                      prefixIcon:
                          SvgPicture.asset(AppAssetImages.unlockSVGLogoLine),
                      suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          color: Colors.transparent,
                          onPressed: () {
                            controller.toggleHideConfirmPassword =
                                !controller.toggleHideConfirmPassword;
                            controller.update();
                          },
                          icon: SvgPicture.asset(AppAssetImages.hideSVGLogoLine,
                              color: controller.toggleHideConfirmPassword
                                  ? AppColors.bodyTextColor
                                  : AppColors.primaryColor)),
                    ),
                    AppGaps.hGap24,
                    /* <---- Password requirement strong level columns ----> */
                    Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* <---- Password strong level widget ----> */
                        PasswordStrongLevelWidget(
                            currentPasswordStrongLevel:
                                controller.passwordStrongLevel),
                        AppGaps.hGap16,
                        /* <---- Password 1st requirement ----> */
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                AppAssetImages.tickRoundedSVGLogoSolid,
                                color: controller.isPasswordOver5Characters
                                    ? AppColors.successColor
                                    : AppColors.darkColor.withOpacity(0.25)),
                            AppGaps.wGap15,
                            Text(
                                AppLanguageTranslation
                                    .atLeast6CharsTransKey.toCurrentLanguage,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        AppGaps.hGap16,
                        /* <---- Password 2nd requirement ----> */
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                AppAssetImages.tickRoundedSVGLogoSolid,
                                color: controller
                                        .isPasswordHasAtLeastSingleNumberDigit
                                    ? AppColors.successColor
                                    : AppColors.darkColor.withOpacity(0.25)),
                            AppGaps.wGap15,
                            Text(
                                AppLanguageTranslation
                                    .containAtLeast1NumberTransKey
                                    .toCurrentLanguage,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    )),
                    AppGaps.hGap30,
                  ],
                ),
              ),
            ),
          ),
          /* <-------- Bottom bar of sign up text --------> */
          bottomNavigationBar: CustomScaffoldBottomBarWidget(
            child: CustomStretchedTextButtonWidget(
                isLoading: controller.isLoading,
                buttonText: AppLanguageTranslation
                    .savePasswordTransKey.toCurrentLanguage,
                onTap: controller.onSavePasswordButtonTap),
          ),
        ),
      ),
    );
  }
}
