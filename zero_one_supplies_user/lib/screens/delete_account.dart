import 'package:ecomik/controller/delete_account_screen_controller.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteAccountScreenController>(
        init: DeleteAccountScreenController(),
        global: false,
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(AppLanguageTranslation
                        .deleteAccountTransKey.toCurrentLanguage)),
                body: CustomScaffoldBodyWidget(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap30,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .deleteAccountTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleLargeXBoldTextStyle
                                  .copyWith(color: Colors.black),
                            ),
                            AppGaps.hGap20,
                            Text(AppLanguageTranslation
                                .areYouSureYouWantDeleteYourAccountPleaseReadAffectTransKey
                                .toCurrentLanguage), //Expanded(child: Text("Description")),
                            AppGaps.hGap20,
                            Text(
                              AppLanguageTranslation
                                  .accountTransKey.toCurrentLanguage,
                              style: AppTextStyles.titleLargeXBoldTextStyle
                                  .copyWith(color: Colors.black),
                            ),
                            AppGaps.hGap20,
                            Text(AppLanguageTranslation
                                .deleteingAccountRemovesPersonalInfoDatabaseTransKey
                                .toCurrentLanguage), //Expanded(child: Text("Description")),

                            AppGaps.hGap30,
                            CustomStretchedDeleteButtonWidget(
                                // onTap: () {},
                                onTap: controller.deleteAccount,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.delete),
                                    AppGaps.wGap10,
                                    RawButtonWidget(
                                      onTap: controller.deleteAccount,
                                      child: Text(
                                        AppLanguageTranslation
                                            .deleteAccountTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles
                                            .bodyLargeMediumTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ));
  }
}
