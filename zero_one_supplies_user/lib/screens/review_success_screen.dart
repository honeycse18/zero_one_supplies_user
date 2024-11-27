import 'package:ecomik/controller/reviewsuccess_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewSuccessScreen extends StatelessWidget {
  const ReviewSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewSuccessScreenController>(
        init: ReviewSuccessScreenController(),
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
                    titleWidget: Text(AppLanguageTranslation
                        .reviewSubmittedTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* <---- Add review illustration ----> */
                        Image.asset(AppAssetImages.reviewSuccessIllustration,
                            height: 170, width: 170),
                        AppGaps.hGap56,
                        HighlightAndDetailTextWidget(
                            slogan: AppLanguageTranslation
                                .thankYouTransKey.toCurrentLanguage,
                            subtitle: AppLanguageTranslation
                                .reviewSubmittedSuccessfullyTransKey
                                .toCurrentLanguage),
                        // Bottom extra spaces
                        AppGaps.hGap30,
                      ],
                    ),
                  )),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .goToHomeTransKey.toCurrentLanguage,
                      onTap: () {
                        Get.toNamed(
                          AppPageNames.homeNavigatorScreen,
                        );
                      }),
                ),
              ),
            ));
  }
}
