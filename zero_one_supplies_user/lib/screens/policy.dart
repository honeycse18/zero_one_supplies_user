import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/settings_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  /// Toggle value of notification

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: Image.asset(AppAssetImages.backgroundFullPng).image,
              fit: BoxFit.fill)),
      child: Scaffold(
        /* <-------- Appbar --------> */
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            titleWidget: Text(
              LanguageHelper.currentLanguageText(LanguageHelper.policyTransKey),
            )),
        /* <-------- Content --------> */
        body: CustomScaffoldBodyWidget(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top extra spaces
                AppGaps.hGap16,
                /* <---- 'Country' List Tile ----> */
                SettingsListTileWidget(
                    titleText: LanguageHelper.currentLanguageText(
                        LanguageHelper.privacyPolicyTransKey),
                    valueWidget: const SettingsValueTextWidget(text: ''),
                    onTap: () {
                      Get.toNamed(AppPageNames.privacyPolicyScreen);
                    }),
                AppGaps.hGap16,
                /* <---- 'Currency' List Tile ----> */
                SettingsListTileWidget(
                    titleText: LanguageHelper.currentLanguageText(
                        LanguageHelper.returnPolicyTransKey),
                    valueWidget: const SettingsValueTextWidget(text: ''),
                    onTap: () {
                      Get.toNamed(AppPageNames.returnPolicyScreen);
                    }),
                AppGaps.hGap16,
                /* /* <---- 'Language' List Tile ----> */
                SettingsListTileWidget(
                    titleText: 'Shopping Policy',
                    valueWidget: const SettingsValueTextWidget(text: ''),
                    onTap: () {
                      Get.toNamed(AppPageNames.soppingPolicyScreen);
                    }),
                AppGaps.hGap16,
                /* <---- 'Language' List Tile ----> */
                SettingsListTileWidget(
                    titleText: 'Cancellation Policy',
                    valueWidget: const SettingsValueTextWidget(text: ''),
                    onTap: () {
                      Get.toNamed(AppPageNames.cancellationScreen);
                    }), */
                /* <---- Section space ----> */

                /* <---- 'Notification' List Tile ----> */
                /* <---- Section space ----> */
                // AppGaps.hGap32,
                // Text('Support', style: Theme.of(context).textTheme.headline4),
                // AppGaps.hGap16,
                // /* <---- 'Help center' List Tile ----> */
                // SettingsListTileWidget(titleText: 'Help center', onTap: () {}),
                // AppGaps.hGap16,
                // /* <---- 'Terms & conditions' List Tile ----> */
                // SettingsListTileWidget(
                //     titleText: 'Terms & conditions', onTap: () {}),
                // // Bottom extra spaces
                // AppGaps.hGap30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
