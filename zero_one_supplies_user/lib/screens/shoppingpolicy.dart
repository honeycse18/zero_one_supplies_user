import 'package:ecomik/controller/shoppingpolicy_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoppingPolicyScreen extends StatelessWidget {
  const SoppingPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    // final screenSize = MediaQuery.of(context).size;
    return GetBuilder<ShoppingPolicyScreenController>(
        init: ShoppingPolicyScreenController(),
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
                        .shoppingPolicyTransKey.toCurrentLanguage)),
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
                            .shoppingPolicyTransKey.toCurrentLanguage,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'At 01 Supplies, we strive to provide our customers with a seamless and enjoyable online shopping experience. Our shopping policy outlines our commitment to providing you with quality products, competitive prices, and excellent customer service.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Product Selection and Availability:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'We offer a wide range of products, including household items, office supplies, electronics, and more. We are constantly updating our inventory to ensure that we offer the latest and greatest products to our customers. However, some items may be subject to availability, and we cannot guarantee that all items will be in stock at all times.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Pricing:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'We offer competitive prices on all our products. However, prices are subject to change without notice, and we cannot guarantee that a product will be priced the same in the future.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Order Processing and Shipping:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      AppGaps.hGap10,
                      const Text(
                        'We strive to process orders as quickly as possible. Once your order is placed, we will provide you with an estimated delivery date. Please note that delivery times may vary depending on your location and shipping method.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      AppGaps.hGap25,
                      const Text(
                        'Payment:',
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
                        'At 01 Supplies, we are committed to providing excellent customer service. If you have any questions or concerns, please contact our customer support team. Our team is available to assist you with any issues you may have.',
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
