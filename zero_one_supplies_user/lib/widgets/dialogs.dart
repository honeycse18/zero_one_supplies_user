import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialogs {
  static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.successTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.successBackgroundColor,
      titleWidget: Text(dialogTitle,
          style: AppTextStyles.titleSmallSemiboldTextStyle
              .copyWith(color: AppColors.successColor),
          textAlign: TextAlign.center),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomStretchedTextButtonWidget(
          buttonText: AppLanguageTranslation.okTransKey.toCurrentLanguage,
          onTap: () {
            Get.back(result: true);
          },
        )
      ],
    ));
  }

  static Future<Object?> showErrorDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.showErrorAlert),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
          // backgroundColor: AppColors.alertColor,
          onTap: () {
            Get.back();
          },
          child: Text(AppLanguageTranslation.okTransKey.toCurrentLanguage),
        )
      ],
    ));
  }

  static Future<Object?> showProcessingDialog({String? message}) async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              message ??
                  AppLanguageTranslation.processingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  static Future<Object?> showConfirmDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(AlertDialogWidget(
      titleWidget: Text(
          titleText ?? AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
          style: AppTextStyles.titleSmallSemiboldTextStyle,
          textAlign: TextAlign.center),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        Row(
          children: [
            Expanded(
              child: CustomStretchedOutlinedTextButtonWidget(
                buttonText: noButtonText ??
                    AppLanguageTranslation.noTransKey.toCurrentLanguage,
                onTap: onNoTap ??
                    () {
                      Get.back();
                    },
              ),
            ),
            AppGaps.wGap12,
            Expanded(
              child: CustomStretchedTextButtonWidget(
                buttonText: yesButtonText ??
                    AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                onTap: () async {
                  await onYesTap();
                  if (shouldCloseDialogOnceYesTapped) Get.back();
                },
              ),
            ),
          ],
        )
      ],
    ));
  }

  static Future<Object?> showActionableDialog(
      {String? titleText,
      required String messageText,
      Color titleTextColor = AppColors.alertColor,
      String? buttonText,
      void Function()? onTap}) async {
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.alertBackgroundColor,
      titleWidget: Text(
          titleText ?? AppLanguageTranslation.errorTransKey.toCurrentLanguage,
          style: AppTextStyles.titleSmallSemiboldTextStyle
              .copyWith(color: titleTextColor),
          textAlign: TextAlign.center),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomStretchedTextButtonWidget(
          buttonText:
              buttonText ?? AppLanguageTranslation.okTransKey.toCurrentLanguage,
          // backgroundColor: AppColors.alertColor,
          onTap: onTap,
        )
      ],
    ));
  }

  static Future<Object?> showImageProcessingDialog() async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              AppLanguageTranslation.imageProcessingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(
                AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        barrierDismissible: false);
  }
}
