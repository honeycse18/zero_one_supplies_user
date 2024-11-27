// ignore_for_file: file_names

import 'package:ecomik/controller/support_ticket_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/app_page_names.dart';
import '../widgets/core_widgets.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportTicketScreenController>(
        init: SupportTicketScreenController(),
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
                    hasBackButton: false,
                    titleWidget: const Text('')),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: Center(
                    child: EmptyScreenWidget(
                      localImageAssetURL: AppAssetImages.ticketLogo,
                      title: AppLanguageTranslation
                          .noTicketFoundTransKey.toCurrentLanguage,
                      shortTitle: AppLanguageTranslation
                          .youveNoSupportTicketTransKey.toCurrentLanguage,
                    ),

                    /*        SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppGaps.hGap10,

                        /* <---- Congratulation illustration ----> */
                        Image.asset(AppAssetImages.ticketLogo, height: 250),
                        AppGaps.hGap56,
                        const HighlightAndDetailTextWidget(
                            slogan: 'Sorry! No Ticket Found ',
                            subtitle:
                                'You have no support ticket. Create a support ticket based on your issue'),
                        // Bottom extra spaces
                        AppGaps.hGap20,
                      ],
                    ),
                  ) */
                  ),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .createNewTicketTransKey.toCurrentLanguage,
                      onTap: () {
                        Get.toNamed(AppPageNames.supportTicketScreen);
                      }),
                ),
              ),
            ));
  }
}
