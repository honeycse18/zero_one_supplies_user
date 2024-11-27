import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:ecomik/models/api_responses/chat_messages.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class FileDetailsBottomSheetController extends GetxController {
  // Variables
  static const String _isolateNameServer = 'file_downloader_port';
  final ReceivePort _port = ReceivePort();
  String downloadTaskID = '';
  DownloadTaskStatus downloadTaskStatus = DownloadTaskStatus.undefined;
  ChatMessage chatMessage = ChatMessage.empty();
  String? currentFileDownloadTaskID;
  // bool isDownloading = false;
  int fileDownloadProgress = 0;

  // Getters
  bool get isImageFile => Helper.isImageFileURL(chatMessage.attachFileURL);

  double get downloadFileProgress => fileDownloadProgress / 100;

  String get getChatFileName =>
      '${chatMessage.fileName}.${Helper.getFileExtensionFromURL(chatMessage.attachFileURL)}';

  // Functions
  void onPreviewImageMessageTap() async {
    await Get.toNamed(AppPageNames.imageScreen,
        arguments: [chatMessage.attachFileURL]);
  }

  void onOpenDownloadedFileButtonTap() async {
    try {
      final fileFullPath = await chatFileFullPath();
      final result = await OpenFile.open(fileFullPath);
      log(result.toString());
    } catch (e) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .failedToOpenFileTransKey.toCurrentLanguage);
    }
  }

  void onDownloadAgainButtonTap() async {
    downloadTaskID =
        await FlutterDownloader.retry(taskId: downloadTaskID) ?? '';
  }

  void onCancelDownloadButtonTap() async {
    AppDialogs.showConfirmDialog(
      messageText: AppLanguageTranslation.areYouSureTransKey.toCurrentLanguage,
      shouldCloseDialogOnceYesTapped: true,
      onYesTap: () async {
        if (currentFileDownloadTaskID == null) {
          return;
        }
        await FlutterDownloader.cancel(taskId: currentFileDownloadTaskID!);
      },
    );
  }

  Future<String> chatFileFullPath() async {
    final savedDir = await getSavedDir();
    return '$savedDir/$getChatFileName';
  }

  Future<bool> openDownloadedFile() async {
    if (currentFileDownloadTaskID == null) {
      return false;
    }

    return await FlutterDownloader.open(taskId: currentFileDownloadTaskID!);
  }

  Future<String?> getSavedDir() async {
    final String? externalStorageDirPath;
    // externalStorageDirPath = (await getApplicationDocumentsDirectory()).absolute.path;
    externalStorageDirPath = (await getDownloadsDirectory())?.absolute.path;

    return externalStorageDirPath;
  }

  void downloadChatMessageFile() async {
    final isPermitted = await Helper.checkFileDownloadPermission();
    if (!isPermitted) {
      return;
    }
    final saveDir = await getSavedDir();
    if (saveDir == null) {
      log('SaveDir not found');
      return;
    }
    // isDownloading = true;
    update();
    currentFileDownloadTaskID = await FlutterDownloader.enqueue(
      url: chatMessage.attachFileURL,
      fileName: getChatFileName,
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: saveDir,
      saveInPublicStorage: false,
      showNotification:
          false, // show download progress in status bar (for Android)
      openFileFromNotification:
          false, // click on notification to open downloaded file (for Android)
    );
    log(currentFileDownloadTaskID ?? '');
  }

  void _onDownloadStatus(dynamic data) {
    downloadTaskID = data[0];
    downloadTaskStatus = DownloadTaskStatus.fromInt(data[1]);
    fileDownloadProgress = data[2];
    log('$downloadTaskID:$fileDownloadProgress:$downloadTaskStatus');
/*     if (downloadTaskStatus == DownloadTaskStatus.running) {
      // isDownloading = true;
    } else {
      // isDownloading = false;
    } */
    update();
    switch (downloadTaskStatus) {
      case DownloadTaskStatus.failed:
        AppDialogs.showErrorDialog(
            messageText: AppLanguageTranslation
                .failedToDownloadFilePleaseTryAgainTransKey.toCurrentLanguage);
        break;
      case DownloadTaskStatus.canceled:
        Helper.showSnackBar(
            AppLanguageTranslation.downloadCancelledTransKey.toCurrentLanguage);
        break;
      case DownloadTaskStatus.paused:
      case DownloadTaskStatus.enqueued:
      case DownloadTaskStatus.undefined:
      case DownloadTaskStatus.complete:
        Helper.showSnackBar(
            AppLanguageTranslation.downloadCompletedTransKey.toCurrentLanguage);
        break;
      case DownloadTaskStatus.running:
        break;
      default:
    }
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      _isolateNameServer,
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen(_onDownloadStatus);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping(_isolateNameServer);
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is ChatMessage) {
      chatMessage = argument;
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName(_isolateNameServer);
    send?.send([id, status, progress]);
  }

  Future<void> _isFileAlreadyDownloaded() async {
    final fileFullPath = await chatFileFullPath();
    final isChatFileExists = await Helper.isFileExists(fileFullPath);
    if (isChatFileExists) {
      downloadTaskStatus = DownloadTaskStatus.complete;
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameter();
    _isFileAlreadyDownloaded();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback, step: 20);
    super.onInit();
  }

  @override
  void onClose() {
    _unbindBackgroundIsolate();
    super.onClose();
  }
}
