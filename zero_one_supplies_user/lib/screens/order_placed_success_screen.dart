import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPlacedSuccessScreen extends StatelessWidget {
  const OrderPlacedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: Image.asset(AppAssetImages.backgroundFullPng).image,
              fit: BoxFit.fill)),
      child: Scaffold(
        /* <-------- Content --------> */
        body: SafeArea(
            top: true,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 356,
                        child: Column(
                          children: [
                            /* <---- Illustration image ----> */
                            Image.asset(AppAssetImages.orderSuccessIllustration,
                                height: 240),
                            AppGaps.hGap20,
                            /* <---- Highlighter text and subtitle text ----> */
                            HighlightAndDetailTextWidget(
                                slogan: AppLanguageTranslation
                                    .orderConfirmTransKey.toCurrentLanguage,
                                subtitle: AppLanguageTranslation
                                    .dontWorryOrderConfirmedTransKey
                                    .toCurrentLanguage),
                          ],
                        ),
                      ),
                    ]),
              ),
            )),
        /* <-------- Bottom bar --------> */

        bottomNavigationBar: CustomScaffoldBottomBarWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: CustomStretchedOutlinedButtonWidget(
                      child: Text(AppLanguageTranslation
                          .trackOrderTransKey.toCurrentLanguage),
                      onTap: () {
                        // Go to delivery info screen
                        Get.toNamed(AppPageNames.deliveryInfoScreen);
                      }),
                ),
              ),
              AppGaps.hGap19,
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .keepShoppingTransKey.toCurrentLanguage,
                      onTap: () {
                        // Go to delivery info screen
                        Get.toNamed(AppPageNames.productsScreen);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
