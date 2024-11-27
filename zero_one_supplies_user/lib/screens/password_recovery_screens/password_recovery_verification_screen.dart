import 'package:ecomik/controller/passward_recovery_screen_controller/reset_password_otp_verification_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pinput/pinput.dart';

class PasswordRecoveryVerificationScreen extends StatelessWidget {
  const PasswordRecoveryVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordOtpVerificationController>(
        init: ResetPasswordOtpVerificationController(),
        builder: (controller) => DecoratedBox(
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
                                Image.asset(
                                    AppAssetImages.verificationIllustration,
                                    height: 240),
                                AppGaps.hGap20,
                                (controller.otpScreenParameter.type == 'phone')
                                    ? HighlightAndDetailTextWidget(
                                        slogan: AppLanguageTranslation
                                            .verificationTransKey
                                            .toCurrentLanguage,
                                        subtitle:
                                            '${AppLanguageTranslation.codeSentToPhoneWhichIsTransKey.toCurrentLanguage} ${controller.otpScreenParameter.email}')
                                    : HighlightAndDetailTextWidget(
                                        slogan: AppLanguageTranslation
                                            .verificationTransKey
                                            .toCurrentLanguage,
                                        subtitle:
                                            '${AppLanguageTranslation.codeSentToMailWhichIsTransKey.toCurrentLanguage} ${controller.otpScreenParameter.email}')
                              ],
                            ),
                          ),
                          AppGaps.hGap40,
                          /* <---- OTP input field ----> */
                          Pinput(
                            controller: controller.otpInputTextController,
                            length: 4,
                            focusedPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle:
                                  const TextStyle(color: AppColors.darkColor),
                              decoration: BoxDecoration(
                                color: AppColors.shadeColor2,
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 2),
                                borderRadius: const BorderRadius.all(
                                    AppComponents.defaultBorderRadius),
                              ),
                            ),
                            errorPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                color: Colors.red,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: const BorderRadius.all(
                                    AppComponents.defaultBorderRadius),
                              ),
                            ),
                            submittedPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(color: Colors.white),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  AppColors.primaryColor,
                                  AppColors.primaryColor.withOpacity(0.4)
                                ]),
                                color: AppColors.primaryColor,
                                borderRadius: const BorderRadius.all(
                                    AppComponents.defaultBorderRadius),
                              ),
                            ),
                            followingPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: const TextStyle(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w600),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: AppColors.lineShapeColor),
                                borderRadius: const BorderRadius.all(
                                    AppComponents.defaultBorderRadius),
                              ),
                            ),
                          ),
                          AppGaps.hGap24,
                          /* <---- 'Resend code in:' text and timer text row ----> */
                          Center(
                              child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(AppLanguageTranslation
                                  .resendCodeInTransKey.toCurrentLanguage),
                              /* <---- Resend otp code remaining text ----> */
                              Text(
                                  '${controller.otpTimerDuration.inMinutes.toString().padLeft(2, '0')}'
                                  ':${(controller.otpTimerDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                      color: AppColors.primaryColor)),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomStretchedTextButtonWidget(
                          buttonText: AppLanguageTranslation
                              .sendCodeTransKey.toCurrentLanguage,
                          isLoading: controller.isLoading,
                          onTap: () {
                            controller.onSendCodeButtonTap();
                          }),
                      TextButton(
                          onPressed: controller.isDurationOver()
                              ? () {
                                  controller.onResendButtonTap();
                                }
                              : null,
                          child: Text(
                              AppLanguageTranslation
                                  .resendTransKey.toCurrentLanguage,
                              style:
                                  const TextStyle(color: AppColors.darkColor))),
                    ],
                  ),
                ),
              ),
            ));
  }
}
