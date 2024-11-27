import 'package:ecomik/controller/chat_with_deliveryman_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/chat_deliveryman_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatDeliverymanScreen extends StatelessWidget {
  const ChatDeliverymanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsetPaddingValue = MediaQuery.of(context).viewInsets.bottom;
    return GetBuilder<ChatDeliverymanScreenController>(
        init: ChatDeliverymanScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                extendBody: true,
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(
                        AppLanguageTranslation.chatTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppGaps.screenPaddingValue),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      /* <---- Chat background image ----> */
                      image: DecorationImage(
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.scaleDown,
                          image: Image.asset(
                                  AppAssetImages
                                      .chatWithDeliveryManIllustration,
                                  width: 275)
                              .image)),
                  child: SafeArea(
                    bottom: true,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top extra spaces
                        AppGaps.hGap10,
                        /* <---- Delivery man name, designation, profile picture and 
                         call button row----> */
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            NoImageAvatarWidget(
                                firstName: controller.chatUser.firstName,
                                lastName: controller.chatUser.lastName),
                            AppGaps.wGap16,
                            /* <---- Delivery man name and designation column ----> */
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${controller.chatUser.firstName} ${controller.chatUser.lastName}',
                                    // style: Theme.of(context).textTheme.labelLarge,
                                    style:
                                        AppTextStyles.notificationDateSection,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        AppGaps.hGap10,
                        /* <---- Chat with deliveryman ----> */
                        Expanded(
                            child: ListView.separated(
                          controller: controller.chatScrollController,
                          reverse: true,
                          padding: const EdgeInsets.only(top: 17, bottom: 30),
                          separatorBuilder: (context, index) => AppGaps.hGap24,
                          itemCount: controller.chatMessages.length,
                          itemBuilder: (context, index) {
                            /// Per chat message data
                            final chatMessage = controller.chatMessages[index];
                            return ChatDeliveryManScreenWidgets
                                .getCustomDeliveryChatWidget(
                              dateTime: chatMessage.createdAt,
                              message: chatMessage.message,
                              isMyMessage:
                                  controller.isMyChatMessage(chatMessage),
                              isMessageAsImage:
                                  controller.isMessageAsImage(chatMessage),
                              imageURL: chatMessage.attachFileURL,
                              imageFileName:
                                  controller.getChatFileName(chatMessage),
                              isMessageAsFile:
                                  controller.isMessageAsFile(chatMessage),
                              fileName: controller.getChatFileName(chatMessage),
                              fileURL: chatMessage.attachFileURL,
                              onImageMessageTap: () {
                                controller.onImageMessageTap(chatMessage);
                              },
                              onFileMessageTap: () {
                                controller.onFileMessageTap(chatMessage);
                              },
                            );
                          },
                        )),
                      ],
                    ),
                  ),
                ),
                /* <-------- Bottom bar of chat text field --------> */
                bottomNavigationBar: Padding(
                  padding: AppGaps.bottomNavBarPadding
                      .copyWith(bottom: 15 + bottomInsetPaddingValue),
                  /* <---- Chat message text field ----> */
                  child: CustomTextFormField(
                    controller: controller.messageController,
                    hintText: AppLanguageTranslation
                        .writeMessageTransKey.toCurrentLanguage,
                    prefixIcon: const SizedBox.shrink(),
                    suffixIconConstraints: const BoxConstraints(maxHeight: 48),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* <---- Attachment icon button ----> */
                        CustomIconButtonWidget(
                          onTap: controller.onImageButtonTap,
                          child: SvgPicture.asset(
                            AppAssetImages.attachmentSVGLogoLine,
                            height: 24,
                            width: 24,
                            color: AppColors.bodyTextColor,
                          ),
                        ),
                        AppGaps.wGap8,
                        /* <---- Camera icon button ----> */
                        /*                       CustomIconButtonWidget(
                          child: SvgPicture.asset(
                            AppAssetImages.cameraSVGLogoSolid,
                            height: 24,
                            width: 24,
                            color: AppColors.bodyTextColor,
                          ),
                          onTap: () {},
                        ),
                        AppGaps.wGap8, */
                        /* <---- Send icon button ----> */
                        CustomIconButtonWidget(
                          backgroundColor: AppColors.primaryColor,
                          hasShadow: true,
                          onTap: controller.onSendButtonTap,
                          child: Transform.scale(
                            scaleX: -1,
                            child: SvgPicture.asset(
                              AppAssetImages.arrowLeftSVGLogoLine,
                              height: 16,
                              width: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
