import 'package:ecomik/controller/shipping_address_2nd_screen_controller.dart';
import 'package:ecomik/models/local_models/local_data.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/cart_screen_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/checkout_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddress2ndScreen extends StatelessWidget {
  const ShippingAddress2ndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShippingAddress2ndScreenController>(
        init: ShippingAddress2ndScreenController(),
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
                    hasBackButton: true,
                    titleWidget: Text(LanguageHelper.currentLanguageText(
                        LanguageHelper.shippingAddressTransKey))),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: CustomScrollView(slivers: [
                    // Top extra spaces
                    const SliverToBoxAdapter(child: AppGaps.hGap15),
                    /* <---- 'Payment' text ----> */
                    SliverToBoxAdapter(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LanguageHelper.currentLanguageText(
                              LanguageHelper.paymentTransKey),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
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
                    const SliverToBoxAdapter(child: AppGaps.hGap32),
                    SliverToBoxAdapter(
                      child: Obx(() => CartAmountsAndButtonWidget(
                            subtotalAmount: controller.subTotalAmount,
                            discountAmount: controller.discountAmountForView,
                            vatAmount: controller.vatAmountForView,
                            totalAmount:
                                controller.totalAmountForView.toDouble(),
                            deliveryChargeAmount:
                                controller.deliveryChargeAmountForView,
                            showDeliveryCharge:
                                controller.showDeliveryChargeSectionForView,
                            showTotalInUSD:
                                controller.selectedPaymentOptionIndex == 2,
                            totalAmountInUSD: controller.totalInUSD,
                            additionalCartAmountWidgets: [
/*                               CartAmountWidget(
                                  name: LanguageHelper.currentLanguageText(
                                      LanguageHelper.shippingChargeTransKey),
                                  amount: controller.shippingChargeForView), */
                              AppGaps.hGap8,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${LanguageHelper.currentLanguageText(LanguageHelper.distanceFareTransKey)}: ${controller.distanceFareForView}',
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.bodyTextColor),
                                  ),
                                  AppGaps.hGap8,
                                  Text(
                                    '${LanguageHelper.currentLanguageText(LanguageHelper.deliveryDistanceTransKey)}: ${controller.deliveryDistanceForView}',
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.bodyTextColor),
                                  ),
                                  AppGaps.hGap8,
                                  Text(
                                    '${LanguageHelper.currentLanguageText(LanguageHelper.transactionFeeTransKey)}: ${controller.transactionFeeForView}',
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.bodyTextColor),
                                  ),
                                ],
                              ),
                              AppGaps.hGap8,
                            ],
                            isLoading: controller.isLoading,
                            buttonText: LanguageHelper.currentLanguageText(
                                LanguageHelper.finishAndPayTransKey),
                            onButtonTap: controller.onFinishAndTapTap,
                          )),
                    ),
                    const SliverToBoxAdapter(child: AppGaps.hGap30),
                  ]),
                ),
              ),
            ));
  }
}
