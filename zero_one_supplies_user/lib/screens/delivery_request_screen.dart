import 'package:ecomik/controller/delivery_request_screen_controller.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryRequestScreen extends StatelessWidget {
  const DeliveryRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryRequestScreenController>(
        init: DeliveryRequestScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        .deliveryRequestTransKey.toCurrentLanguage)),
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppGaps.hGap15,
                        SettingsListTileWidget(
                            titleText: 'Create Delivery Request',
                            valueWidget: SettingsValueTextWidget(text: ''),
                            onTap: () async {
                              Get.toNamed(
                                  AppPageNames.createDeliveryRequestScreen);
                            }),
                        AppGaps.hGap15,
                        SettingsListTileWidget(
                            titleText: 'Delivery Requests List',
                            valueWidget: SettingsValueTextWidget(text: ''),
                            onTap: () {
                              Get.toNamed(
                                  AppPageNames.deliveryRequestListScreen);
                            }),
                        AppGaps.hGap15,
                        SettingsListTileWidget(
                            titleText: 'Track Recent Delivery Request',
                            valueWidget: SettingsValueTextWidget(text: ''),
                            onTap: () async {
                              Get.toNamed(AppPageNames
                                  .trackRecentDeliveryRequestScreen);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
