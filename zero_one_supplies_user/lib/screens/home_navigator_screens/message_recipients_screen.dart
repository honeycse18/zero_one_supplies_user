import 'package:ecomik/controller/home_navigator_screen_controller/message_recipients_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageRecipientsScreen extends StatelessWidget {
  const MessageRecipientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageRecipientsScreenController>(
      global: false,
      init: MessageRecipientsScreenController(),
      builder: (controller) => DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(AppAssetImages.backgroundFullPng).image,
                fit: BoxFit.fill)),
        child: Scaffold(
          // / <-------- Appbar --------> /
          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              hasBackButton: controller.vendorID.isNotEmpty,
              titleWidget: Text(LanguageHelper.currentLanguageText(
                  LanguageHelper.messageTransKey))),
          // / <-------- Content --------> /
          body: CustomScaffoldBodyWidget(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async =>
                          await controller.getChatRecipients(),
                      child: controller.chatUsers.isEmpty
                          ? SingleChildScrollView(
                              child: Center(
                                child: EmptyScreenWidget(
                                    localImageAssetURL:
                                        AppAssetImages.messageSVGLogoLine,
                                    isSVGImage: true,
                                    title: AppLanguageTranslation
                                        .noMessagesTransKey.toCurrentLanguage,
                                    shortTitle: ''),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(bottom: 30),
                              itemBuilder: (context, index) {
                                final chatUser = controller.chatUsers[index];
                                return CustomListTileWidget(
                                  paddingValue: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: AppGaps.screenPaddingValue),
                                  child: Row(
                                    children: [
                                      NoImageAvatarWidget(
                                          firstName: chatUser.firstName,
                                          lastName: chatUser.lastName),
                                      AppGaps.wGap15,
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                              '${chatUser.firstName} ${chatUser.lastName}'),
                                          AppGaps.hGap5,
                                          Row(
                                            children: [
                                              /* Expanded(
                                                child: Text(
                                                    chatUser
                                                        .lastMessage.message,
                                                    style: AppTextStyles
                                                        .bodySmallTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .bodyTextColor)),
                                              ),
                                              AppGaps.wGap4, */
                                              Expanded(
                                                child: Text(
                                                    Helper
                                                        .ddMMMyyyyFormattedDateTime(
                                                            chatUser.lastMessage
                                                                .createdAt),
                                                    style: AppTextStyles
                                                        .bodySmallTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .bodyTextColor)),
                                              ),
                                              Text(
                                                chatUser.role,
                                                style: AppTextStyles
                                                    .bodySmallMediumTextStyle,
                                              )
                                            ],
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                  onTap: () async {
                                    await Get.toNamed(
                                        AppPageNames.chatWithDeliverymanScreen,
                                        arguments: chatUser);
                                    controller.getChatRecipients();
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap12,
                              itemCount: controller.chatUsers.length),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
