import 'package:ecomik/controller/bottom_sheets/file_details.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

class FileDetailsBottomSheet extends StatelessWidget {
  const FileDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
        AppLanguageTranslation.fileDetailsTransKey.toCurrentLanguage,
        style: AppTextStyles.dialogTitleTextStyle);
    final titleRightSideWidget = TightIconButtonWidget(
        onTap: () {
          Get.back();
        },
        child: Image.asset(AppAssetImages.cross));
    return GetBuilder<FileDetailsBottomSheetController>(
      init: FileDetailsBottomSheetController(),
      global: false,
      builder: (controller) => SizedBox(
        height: 380,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BottomModalBodyWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: titleWidget),
                      titleRightSideWidget
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap16,
                      controller.isImageFile
                          ? Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CachedNetworkImageWidget(
                                    imageURL:
                                        controller.chatMessage.attachFileURL,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 1),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: AppComponents
                                                  .defaultBorderRadius,
                                              topRight: AppComponents
                                                  .defaultBorderRadius,
                                              bottomLeft: AppComponents
                                                  .defaultBorderRadius,
                                              bottomRight: AppComponents
                                                  .defaultBorderRadius),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ),
                                AppGaps.wGap10,
                                Expanded(
                                  child: Text(
                                    controller.getChatFileName,
                                    style: AppTextStyles.bodyMediumTextStyle
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                ),
                                AppGaps.wGap10,
                                TightTextButtonWidget(
                                  onTap: controller.onPreviewImageMessageTap,
                                  child: Text(AppLanguageTranslation
                                      .previewTransKey.toCurrentLanguage),
                                )
                              ],
                            )
                          : Row(
                              children: [
                                const Icon(
                                  Icons.download,
                                  size: 24,
                                ),
                                AppGaps.wGap10,
                                Expanded(
                                  child: Text(
                                    controller.getChatFileName,
                                    style: AppTextStyles.bodyMediumTextStyle
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                      controller.downloadTaskStatus ==
                              DownloadTaskStatus.running
                          ? Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                        value: controller.downloadFileProgress),
                                    Text('${controller.fileDownloadProgress}',
                                        style: AppTextStyles.bodySmallTextStyle)
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(height: 40),
                      AppGaps.hGap16,
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomScaffoldBottomBarWidget(
              child: Builder(builder: (context) {
                switch (controller.downloadTaskStatus) {
                  case DownloadTaskStatus.failed:
                    return Row(
                      children: [
                        Expanded(
                            child: CustomStretchedOutlinedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .cancelTransKey.toCurrentLanguage,
                                onTap: () {
                                  Get.back();
                                })),
                        AppGaps.wGap10,
                        Expanded(
                          child: CustomStretchedTextButtonWidget(
                              buttonText: AppLanguageTranslation
                                  .downloadFileAgainTransKey.toCurrentLanguage,
                              onTap: controller.onDownloadAgainButtonTap),
                        ),
                      ],
                    );
                  case DownloadTaskStatus.running:
                    return Row(
                      children: [
                        Expanded(
                            child: CustomStretchedOutlinedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .cancelDownloadTransKey.toCurrentLanguage,
                                onTap: controller.onCancelDownloadButtonTap)),
                        AppGaps.wGap10,
                        Expanded(
                          child: LoadingPlaceholderWidget(
                            child: CustomStretchedTextButtonWidget(
                              buttonText: AppLanguageTranslation
                                  .downloadingTransKey.toCurrentLanguage,
                            ),
                          ),
                        ),
                      ],
                    );

                  case DownloadTaskStatus.complete:
                    return Row(
                      children: [
                        Expanded(
                            child: CustomStretchedOutlinedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .cancelTransKey.toCurrentLanguage,
                                onTap: () {
                                  Get.back();
                                })),
                        AppGaps.wGap10,
                        Expanded(
                            child: CustomStretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .openDownloadedFileTransKey
                                    .toCurrentLanguage,
                                onTap:
                                    controller.onOpenDownloadedFileButtonTap)),
                      ],
                    );
                  default:
                    return Row(
                      children: [
                        Expanded(
                            child: CustomStretchedOutlinedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .cancelTransKey.toCurrentLanguage,
                                onTap: () {
                                  Get.back();
                                })),
                        AppGaps.wGap10,
                        Expanded(
                          child: CustomStretchedTextButtonWidget(
                              buttonText: AppLanguageTranslation
                                  .downloadFileTransKey.toCurrentLanguage,
                              onTap: controller.downloadChatMessageFile),
                        ),
                      ],
                    );
                }
              }),
            )),
      ),
    );
  }
}
