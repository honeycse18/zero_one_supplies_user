import 'package:ecomik/controller/checkout_screen_controller.dart';
import 'package:ecomik/models/local_models/local_data.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/checkout_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  /// Currently selected checkout option index

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<CheckOutScreenController>(
        init: CheckOutScreenController(),
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
                        .checkoutTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: CustomScrollView(slivers: [
                    // Top extra spaces
                    const SliverToBoxAdapter(child: AppGaps.hGap15),
                    /* <---- Payment card widget ----> */
/*                     SliverToBoxAdapter(
                        child: PaymentCardWidget(
                            child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Name',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.white.withOpacity(0.7))),
                        AppGaps.hGap2,
                        Text('Michel John Doe',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                        AppGaps.hGap16,
                        Text(
                          '****    ****    ****    2382',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        AppGaps.hGap16,
                        Text('Balance',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.white.withOpacity(0.7))),
                        AppGaps.hGap2,
                        Text(r'$2373.00',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                      ],
                    ))), */
                    // const SliverToBoxAdapter(child: AppGaps.hGap32),
                    /* <---- 'Payment' text and add new text button row ----> */
                    SliverToBoxAdapter(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLanguageTranslation
                              .paymentTransKey.toCurrentLanguage,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        /* <---- + Add new text button ----> */
/*                         CustomTightTextButtonWidget(
                            onTap: () {
                              Get.toNamed(AppPageNames.addNewCardScreen);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    AppAssetImages.plusSVGLogoSolid,
                                    color: AppColors.primaryColor,
                                    height: 12,
                                    width: 12),
                                AppGaps.wGap2,
                                Text(
                                  'Add new',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            )) */
                      ],
                    )),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                    /* <---- Payment options list ----> */
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        /// Single payment Option
                        final paymentOption =
                            LocalData.localPaymentOptions[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: PaymentOptionListTileWidget(
                            hasShadow:
                                controller.selectedPaymentOptionIndex == index,
                            onTap: () {
                              // setState(() {
                              controller.selectedPaymentOptionIndex = index;
                              controller.update();
                              // });
                            },
                            paymentIconWidget: paymentOption.paymentImage,
                            paymentName: paymentOption.name,
                            radioOnChange: (value) {
                              // setState(() {
                              controller.selectedPaymentOptionIndex = index;
                              controller.update();
                              // });
                            },
                            index: index,
                            selectedPaymentOptionIndex:
                                controller.selectedPaymentOptionIndex,
                          ),
                        );
                      },
                      childCount: LocalData.localPaymentOptions.length,
                    )),
                    // Bottom extra spaces
                    const SliverToBoxAdapter(child: AppGaps.hGap30),
                  ]),
                ),
                /* <-------- Bottom bar of row of price and pay now button --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${AppLanguageTranslation.totalTransKey.toCurrentLanguage} \$65.00',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      AppGaps.wGap5,
                      /* <---- Pay now button ----> */
                      CustomLargeTextButtonWidget(
                        // If screen size is small, set small button size,
                        // else, set large button size.
                        isSmallScreen: screenSize.width < 350,
                        text: AppLanguageTranslation
                            .payNowTransKey.toCurrentLanguage,
                        textColor: Colors.white,
                        onTap: () {
                          Get.toNamed(AppPageNames.orderSuccessScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
