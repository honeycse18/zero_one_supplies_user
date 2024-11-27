import 'package:ecomik/controller/bid_wallet_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BidWaletScreen extends StatelessWidget {
  const BidWaletScreen({super.key});

  /// Currently selected checkout option index

  // int _currentStep = 0;

  // List<Step> _steps = [
  //   Step(
  //     title: Text('Delivery Address'),
  //     content: Text('This is the content of Delivery Address.'),
  //     isActive: true,
  //   ),
  //   Step(
  //     title: Text('Payment'),
  //     content: Text('This is the content of Payment.'),
  //     isActive: true,
  //   ),
  //   Step(
  //     title: Text('Order Placed'),
  //     content: Text('This is the content of Order Placed.'),
  //     isActive: true,
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    /// Get screen size

    return GetBuilder<BidWalletScreenController>(
        init: BidWalletScreenController(),
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
                        .paymentTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: CustomScrollView(slivers: [
                    // Top extra spaces
                    const SliverToBoxAdapter(child: AppGaps.hGap15),
                    //========================================================
                    // SliverToBoxAdapter(
                    //   child: Stepper(
                    //     currentStep: _currentStep,
                    //     steps: _steps,
                    //     onStepContinue: () {
                    //       setState(() {
                    //         _currentStep += 1;
                    //       });
                    //     },
                    //     onStepCancel: () {
                    //       setState(() {
                    //         _currentStep -= 1;
                    //       });
                    //     },
                    //   ),
                    // ),
                    //====================================================

                    /* <---- Payment card widget ----> */
                    SliverToBoxAdapter(
                        child: PaymentCardWidget(
                            child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            AppLanguageTranslation
                                .nameTransKey.toCurrentLanguage,
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
                        Text(
                            AppLanguageTranslation
                                .balanceTransKey.toCurrentLanguage,
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
                    ))),
                    const SliverToBoxAdapter(child: AppGaps.hGap32),
                    //   ======pay to walet=======
                    SliverToBoxAdapter(
                        child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Action to be performed when the button is pressed
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(
                                150, 60)), // minimum width and height
                            maximumSize: MaterialStateProperty.all(const Size(
                                300, 60)), // maximum width and height
                            side: MaterialStateProperty.all(const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1, // border thickness
                            )),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // border radius
                            )),
                          ),
                          child: Text(
                            AppLanguageTranslation
                                .payToWalletTransKey.toCurrentLanguage,
                            style:
                                const TextStyle(color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    )),
                    const SliverToBoxAdapter(child: AppGaps.hGap32),
                    SliverToBoxAdapter(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLanguageTranslation
                              .paymentTransKey.toCurrentLanguage,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        /* <---- + Add new text button ----> */
                        CustomTightTextButtonWidget(
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
                                  AppLanguageTranslation
                                      .addNewTransKey.toCurrentLanguage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ))
                      ],
                    )),
                    const SliverToBoxAdapter(child: AppGaps.hGap16),
                    /* <---- Payment options list ----> */
                    /* SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        /// Single payment Option
                        final paymentOption = FakeData.paymentOptions[index];
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
                      childCount: FakeData.paymentOptions.length,
                    )), */
                    // Bottom extra spaces
                    const SliverToBoxAdapter(child: AppGaps.hGap30),
                  ]),
                ),
                /* <-------- Bottom bar of row of price and pay now button --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: Container(
                    // margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),

                    height: 210,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .subTotalTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  r' $150.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .discountTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  r' $0.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .deliveryChargeTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  r' $0.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .taxTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  r' $0.00',
                                  // style: Theme.of(context).textTheme.headlineSmall,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap10,
                            Row(
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .totalTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  r' $150.00',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap15,
                            Column(
                              children: [
                                CustomStretchedButtonWidget(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AppGaps.wGap8,
                                        Text(AppLanguageTranslation
                                            .finishAndPayTransKey
                                            .toCurrentLanguage),
                                      ],
                                    ),
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.orderSuccessScreen);
                                    }),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
