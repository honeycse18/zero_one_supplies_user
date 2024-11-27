// ignore_for_file: file_names

import 'package:ecomik/controller/all_help_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/core_widgets.dart';

class TicketStatusScreen extends StatelessWidget {
  const TicketStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketStatusScreenController>(
        init: TicketStatusScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.all(8.0),
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
                        .supportTicketTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGaps.hGap15,
                        singleSupportTicket(
                            'hi', 'Website', true, '26 Dec, 2021'),
                        AppGaps.hGap15,
                        singleSupportTicket(
                            'Login Problem', r'$23.60', false, '21 Mar, 2022'),
                      ],
                    ),
                  ),
                ),
                /* <-------- Bottom bar --------> */
              ),
            ));
  }

  Widget singleSupportTicket(
      String title, String desc, bool status, String date) {
    return Container(
      height: 102,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          border: Border.all(
              color: Colors.white, width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkColor),
                ),
                Text(
                  desc,
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.bodyTextColor),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 28,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      gradient: status
                          ? LinearGradient(colors: [
                              const Color(0xFF48E98A),
                              Colors.green.withOpacity(0.4)
                            ])
                          : LinearGradient(colors: [
                              const Color(0xFFFE4651),
                              Colors.red.withOpacity(0.4)
                            ])),
                  child: Center(
                      child: Text(
                          status
                              ? AppLanguageTranslation
                                  .openTransKey.toCurrentLanguage
                              : AppLanguageTranslation
                                  .closedTransKey.toCurrentLanguage,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white))),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      color: AppColors.bodyTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
