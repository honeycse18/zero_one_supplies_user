import 'package:ecomik/controller/returnpolicy_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReturnPolicyScreen extends StatelessWidget {
  const ReturnPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    return GetBuilder<ReturnPolicyScreenController>(
        init: ReturnPolicyScreenController(),
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
                    titleWidget: Text(controller.returnPolicy.title)),
                // appBar: CoreWidgets.appBarWidget(screenContext: context),
                /* <-------- Content --------> */

                body: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: WebViewWidget(
                            controller: controller.webViewController),
                      )
                    ],
                  ),
                ),
                /* <-------- Bottom bar of sign up text --------> */
              ),
            ));
  }
}
