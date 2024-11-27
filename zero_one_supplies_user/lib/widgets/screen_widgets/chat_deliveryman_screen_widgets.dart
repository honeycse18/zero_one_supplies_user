import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class ChatDeliveryManScreenWidgets {
  /// Get chat message widget based on who sent the message
  static Widget getCustomDeliveryChatWidget({
    required DateTime dateTime,
    DateTime? previousMessageDateTime,
    bool isMessageAsImage = false,
    String imageFileName = '',
    String imageURL = '',
    void Function()? onImageMessageTap,
    bool isMessageAsFile = false,
    String fileName = '',
    String fileURL = '',
    void Function()? onFileMessageTap,
    required String message,
    required bool isMyMessage,
  }) {
    if (isMyMessage) {
      return MyMessageSingleWidget(
        dateTime: dateTime,
        message: message,
        isMessageAsImage: isMessageAsImage,
        imageFileName: imageFileName,
        imageURL: imageURL,
        onImageMessageTap: onImageMessageTap,
        isMessageAsFile: isMessageAsFile,
        fileName: fileName,
        fileURL: fileURL,
        onFileMessageTap: onFileMessageTap,
      );
    } else {
      return RecipientMessageSingleWidget(
        dateTime: dateTime,
        message: message,
        isMessageAsImage: isMessageAsImage,
        imageFileName: imageFileName,
        imageURL: imageURL,
        onImageMessageTap: onImageMessageTap,
        isMessageAsFile: isMessageAsFile,
        fileName: fileName,
        fileURL: fileURL,
        onFileMessageTap: onFileMessageTap,
      );
    }
  }
}

/// Chat message widget of my message
class MyMessageSingleWidget extends StatelessWidget {
  final DateTime dateTime;
  final DateTime? previousMessageDateTime;
  final bool isMessageAsImage;
  final String imageFileName;
  final String imageURL;
  final void Function()? onImageMessageTap;
  final bool isMessageAsFile;
  final String fileName;
  final String fileURL;
  final void Function()? onFileMessageTap;
  final String message;
  const MyMessageSingleWidget({
    super.key,
    required this.dateTime,
    this.previousMessageDateTime,
    required this.message,
    this.isMessageAsImage = false,
    this.isMessageAsFile = false,
    this.onImageMessageTap,
    this.onFileMessageTap,
    this.imageFileName = '',
    this.imageURL = '',
    this.fileName = '',
    this.fileURL = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Builder(builder: (context) {
                    if (isMessageAsImage) {
                      return MyMessageContainerWidget(children: [
                        RawButtonWidget(
                          borderRadiusValue: 0,
                          onTap: onImageMessageTap,
                          child: SizedBox(
                            height: 170,
                            width: 170,
                            child: CachedNetworkImageWidget(
                              imageURL: imageURL,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1),
                                    borderRadius: const BorderRadius.only(
                                        topLeft:
                                            AppComponents.defaultBorderRadius,
                                        topRight:
                                            AppComponents.defaultBorderRadius,
                                        bottomLeft:
                                            AppComponents.defaultBorderRadius,
                                        bottomRight:
                                            AppComponents.defaultBorderRadius),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        AppGaps.hGap3,
                        Text(
                          imageFileName,
                          textAlign: TextAlign.end,
                          style: AppTextStyles.bodySmallTextStyle
                              .copyWith(color: AppColors.lineShapeColor),
                        )
                      ]);
                    }
                    if (isMessageAsFile) {
                      return MyMessageContainerWidget(children: [
                        RawButtonWidget(
                          borderRadiusValue: 0,
                          onTap: onFileMessageTap,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.download,
                                size: 24,
                              ),
                              AppGaps.wGap10,
                              Text(
                                fileName,
                                textAlign: TextAlign.end,
                                style: AppTextStyles.bodyMediumTextStyle
                                    .copyWith(
                                        color: AppColors.lineShapeColor,
                                        decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        )
                      ]);
                    }
                    if (message.isEmpty) {
                      return AppGaps.emptyGap;
                    }

                    return MyMessageContainerWidget(
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
/*                           AppGaps.hGap5,
                          Text(
                            dateTimeText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ), */
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool get showDate {
/*     if (previousMessageDateTime == null) {
      return true;
    }
    return Helper.isDateDifferenceIn1Day(dateTime, previousMessageDateTime!); */
    return false;
  }
}

class MyMessageContainerWidget extends StatelessWidget {
  final List<Widget> children;
  const MyMessageContainerWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: AppComponents.defaultBorderRadius,
              topRight: AppComponents.defaultBorderRadius,
              bottomLeft: AppComponents.defaultBorderRadius,
              bottomRight: Radius.circular(0)),
          color: AppColors.primaryColor,
          boxShadow: [
            BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.25),
                offset: const Offset(0, 8),
                spreadRadius: -8,
                blurRadius: 10)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      ),
    );
  }
}

/// Chat message widget of my message
class RecipientMessageSingleWidget extends StatelessWidget {
  final DateTime dateTime;
  final DateTime? previousMessageDateTime;
  final String message;
  final bool isMessageAsImage;
  final String imageFileName;
  final String imageURL;
  final void Function()? onImageMessageTap;
  final bool isMessageAsFile;
  final String fileName;
  final String fileURL;
  final void Function()? onFileMessageTap;
  const RecipientMessageSingleWidget({
    super.key,
    required this.dateTime,
    this.previousMessageDateTime,
    required this.message,
    this.isMessageAsImage = false,
    this.isMessageAsFile = false,
    this.onImageMessageTap,
    this.onFileMessageTap,
    this.imageFileName = '',
    this.imageURL = '',
    this.fileName = '',
    this.fileURL = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    if (isMessageAsImage) {
                      return RecipientMessageSingleContainerWidget(children: [
                        RawButtonWidget(
                          borderRadiusValue: 0,
                          onTap: onImageMessageTap,
                          child: SizedBox(
                            height: 170,
                            width: 170,
                            child: CachedNetworkImageWidget(
                              imageURL: imageURL,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1),
                                    borderRadius: const BorderRadius.only(
                                        topLeft:
                                            AppComponents.defaultBorderRadius,
                                        topRight:
                                            AppComponents.defaultBorderRadius,
                                        bottomLeft:
                                            AppComponents.defaultBorderRadius,
                                        bottomRight:
                                            AppComponents.defaultBorderRadius),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          ),
                        ),
                        AppGaps.hGap3,
                        Text(
                          imageFileName,
                          textAlign: TextAlign.start,
                          style: AppTextStyles.bodySmallTextStyle,
                        )
                      ]);
                    }
                    if (isMessageAsFile) {
                      return RecipientMessageSingleContainerWidget(
                        children: [
                          RawButtonWidget(
                            borderRadiusValue: 0,
                            onTap: onFileMessageTap,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.download,
                                  size: 24,
                                ),
                                AppGaps.wGap10,
                                Text(
                                  fileName,
                                  textAlign: TextAlign.start,
                                  style: AppTextStyles.bodyMediumTextStyle
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    if (message.isEmpty) {
                      return AppGaps.emptyGap;
                    }
                    return RecipientMessageSingleContainerWidget(
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                              color: AppColors.bodyTextColor, fontSize: 14),
                        ),
/*                         AppGaps.hGap5,
                        Text(
                          Helper.getRelativeDateTimeText(dateTime),
                          style: const TextStyle(
                              color: AppColors.bodyTextColor, fontSize: 10),
                        ), */
                      ],
                    );
                  }),
                ],
              ),
            ),
            const Spacer(flex: 2)
          ],
        ),
      ],
    );
  }

  bool get showDate {
/*     if (previousMessageDateTime == null) {
      return true;
    }
    return Helper.isDateDifferenceIn1Day(dateTime, previousMessageDateTime!); */
    return false;
  }
}

class RecipientMessageSingleContainerWidget extends StatelessWidget {
  final List<Widget> children;
  const RecipientMessageSingleContainerWidget(
      {super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: AppComponents.defaultBorderRadius,
              topRight: AppComponents.defaultBorderRadius,
              bottomLeft: Radius.circular(0),
              bottomRight: AppComponents.defaultBorderRadius),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 8),
                spreadRadius: -5,
                blurRadius: 10)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
