import 'package:ecomik/controller/cancelllation_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancellationScreen extends StatelessWidget {
  const CancellationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    return GetBuilder<CancellationScreenController>(
        init: CancellationScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Empty appbar with back button --------> */
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(AppLanguageTranslation
                        .cancellationPolicyTransKey.toCurrentLanguage)),
                // appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */

                body: Container(
                  margin: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                      child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap10,
                      Text(
                        AppLanguageTranslation
                            .cancellationPolicyTransKey.toCurrentLanguage,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'At 01 Supplies, we understand that sometimes orders need to be cancelled. Our cancellation policy outlines our commitment to providing you with a hassle-free cancellation process.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Cancellation Eligibility:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'To be eligible for a cancellation, your order must not have already been shipped. If your order has already been shipped, it will be subject to our returns policy.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Cancellation Process:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'To cancel your order, please contact our customer support team as soon as possible. Our team will check the status of your order and assist you with cancelling it if it has not yet been shipped.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Refunds:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'If your order is eligible for cancellation, we will issue a refund to the original payment method used to purchase the item. Please note that it may take up to 10 business days for the refund to appear on your account.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Contact Us:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'We accept a variety of payment methods, including credit cards, debit cards, and PayPal. All payments are processed securely, and your payment information is never stored on our servers.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Customer Service:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'If you have any questions or concerns about our cancellation policy, please contact us through our customer support channels.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Contact Us:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'If you have any questions or concerns about our shopping policy, please contact us through our customer support channels.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                    ],
                  )),
                ),

                /* <-------- Bottom bar of sign up text --------> */
              ),
            ));
  }
}
