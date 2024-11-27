import 'package:ecomik/controller/settings_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// Toggle value of notification

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenController>(
        init: SettingsScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    titleWidget: Text(LanguageHelper.currentLanguageText(
                        LanguageHelper.settingsTransKey))),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top extra spaces
                        AppGaps.hGap15,
                        Text(
                            LanguageHelper.currentLanguageText(
                                LanguageHelper.preferenceTransKey),
                            style: Theme.of(context).textTheme.headlineMedium),
                        AppGaps.hGap16,
                        /* <---- 'Country' List Tile ----> */
                        /* SettingsListTileWidget(
                            titleText: LanguageHelper.currentLanguageText(
                                LanguageHelper.countryTransKey),
                            valueWidget:
                                const SettingsValueTextWidget(text: 'USA'),
                            onTap: () {
                              Get.toNamed(AppPageNames.countryScreen);
                            }),
                        AppGaps.hGap16,
                        /* <---- 'Currency' List Tile ----> */
                        SettingsListTileWidget(
                            titleText: LanguageHelper.currentLanguageText(
                                LanguageHelper.currencyTransKey),
                            valueWidget:
                                const SettingsValueTextWidget(text: 'USD'),
                            onTap: () {
                              Get.toNamed(AppPageNames.currencyScreen);
                            }),
                        AppGaps.hGap16, */
                        /* <---- 'Language' List Tile ----> */
                        SettingsListTileWidget(
                            titleText: LanguageHelper.currentLanguageText(
                                LanguageHelper.languageTransKey),
                            valueWidget: SettingsValueTextWidget(
                                text: controller.currentLanguageText),
                            onTap: () async {
                              await Get.toNamed(AppPageNames.languageScreen);
                              controller.update();
                            }),
                        /* <---- Section space ----> */
                        AppGaps.hGap32,
                        Text(
                            LanguageHelper.currentLanguageText(
                                LanguageHelper.applicationSettingTransKey),
                            style: Theme.of(context).textTheme.headlineMedium),
                        AppGaps.hGap16,
                        /* <---- 'Notification' List Tile ----> */
                        SettingsListTileWidget(
                            titleText: LanguageHelper.currentLanguageText(
                                LanguageHelper.notificationTransKey),
                            showRightArrow: false,
                            valueWidget: FlutterSwitch(
                              value: controller.toggleNotification.value,
                              width: 35,
                              height: 20,
                              toggleSize: 12,
                              activeColor: AppColors.primaryColor,
                              onToggle: (value) {
                                // setState(() {
                                controller.toggleNotification.value = value;
                                controller.update();
                                // });
                              },
                            ),
                            onTap: () {
                              // setState(
                              //   () {
                              controller.toggleNotification.value =
                                  !controller.toggleNotification.value;
                              // });
                            }),
                        /* <---- Section space ----> */
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
