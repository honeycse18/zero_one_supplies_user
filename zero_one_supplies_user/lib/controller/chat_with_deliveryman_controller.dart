import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:ecomik/models/api_responses/chat_messages.dart';
import 'package:ecomik/models/api_responses/chat_recipients.dart';
import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/single_image_upload_response.dart';
import 'package:ecomik/screens/bottom_sheets/file_details.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/image_picker_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:objectid/objectid.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDeliverymanScreenController extends GetxController {
  ScrollController chatScrollController = ScrollController();
  ChatRecipient chatUser = ChatRecipient.empty();
  List<ChatMessage> chatMessages = [];
  TextEditingController messageController = TextEditingController();
  final ReceivePort _port = ReceivePort();
  IO.Socket socket = IO.io(
      '${Constants.appBaseURL}messages',
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  ChatMessage? previousChatMessage(int currentIndex) {
    if (currentIndex == 0) {
      return null;
    }
    final previousIndex = currentIndex - 1;
    try {
      return chatMessages[previousIndex];
    } catch (e) {
      return null;
    }
  }

  bool isMyChatMessage(ChatMessage chatMessage) {
    final myID = Helper.getUser().id;
    return chatMessage.from == myID;
  }

  void sendMessage(String id, String message) {
    socket.emit('send',
        <String, dynamic>{'_id': id, 'user': chatUser.id, 'message': message});
  }

  String generateID() {
    final objectId = ObjectId();
    return objectId.hexString;
  }

  String getChatFileName(ChatMessage chatMessage) =>
      '${chatMessage.fileName}.${Helper.getFileExtensionFromURL(chatMessage.attachFileURL)}';

  void onImageMessageTap(ChatMessage chatMessage) async {
    // await Get.toNamed(AppPageNames.imageHeroScreen, arguments: chatMessage.attachFileURL);
    // _downloadChatMessageImageFile(chatMessage);
    await Get.bottomSheet(const FileDetailsBottomSheet(),
        backgroundColor: AppColors.backgroundColor,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: AppComponents.bottomSheetBorderRadius),
        settings: RouteSettings(arguments: chatMessage));
  }

  bool isMessageAsImage(ChatMessage chatMessage) {
    return chatMessage.attachFileURL.isNotEmpty &&
        Helper.isImageFileURL(chatMessage.attachFileURL);
  }

  bool isMessageAsFile(ChatMessage chatMessage) {
    return chatMessage.attachFileURL.isNotEmpty &&
        (!Helper.isImageFileURL(chatMessage.attachFileURL));
  }

  void onFileMessageTap(ChatMessage chatMessage) {
    Helper.launchDefaultBrowserUrl(url: chatMessage.attachFileURL);
  }

  void onSendButtonTap() {
    if (messageController.text.isEmpty) {
      return;
    }
    sendMessage(generateID(), messageController.text);
    messageController.clear();
  }

  dynamic onLoadMessages(dynamic data) {
    log('data');
    // chatMessages.clear();
    chatMessages.insertAll(
        0, ChatMessages.getAPIResponseObjectSafeValue(data).messages);
    update();
    Helper.scrollToStart(chatScrollController);
  }

  void refreshChatMessages() {
    socket.emit('load_message', <String, dynamic>{'user': chatUser.id});
  }

  void initSocket() {
    socket.on('load_message', onLoadMessages);
    socket.onConnect((data) {
      log('data');
      refreshChatMessages();
    });
    /* socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err)); */
    socket.onConnectError((data) {
      log('data'.toString());
    });
    socket.onConnecting((data) {
      log('data'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data');
    });
    socket.onReconnectAttempt((data) {
      log('data');
    });
    socket.onReconnect((data) {
      log('data');
    });
    socket.onReconnectFailed((data) {
      log('data');
    });
    socket.onReconnectError((data) {
      log('data');
    });
    socket.onError((data) {
      log('data');
    });
    socket.onDisconnect((data) {
      log('data');
    });
    socket.onPing((data) {
      log('data');
    });
    socket.onPong((data) {
      log('data');
    });
  }

  void onImageButtonTap() async {
    ImagePickerHelper.uploadImage((SingleImageUploadResponse response,
        Map<String, dynamic> additionalData) {
      final String fileName =
          ((additionalData['original_file_name'] ?? '') as String)
                  .split('.')
                  .firstOrNull ??
              '';
      uploadChatImage(response.data, fileName);
    }, {});
  }

  Future<void> uploadChatImage(
      String uploadedFileURL, String fileNameWithoutExtension) async {
    final user = Helper.getUser();
    final fromUserID = user.id;
    Map<String, dynamic> requestBody = {
      'from': fromUserID,
      'to': chatUser.id,
      'attach_file': uploadedFileURL,
      'file_name': fileNameWithoutExtension,
    };
    String requestBodyJson = jsonEncode(requestBody);
    // isSubmitOrderCreateLoading.value = true;
    final RawAPIResponse? response =
        await APIRepo.uploadChatImage(requestBodyJson);
    // isSubmitOrderCreateLoading.value = false;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    _onSuccessUploadChatImage(response);
  }

  void _onSuccessUploadChatImage(RawAPIResponse response) {
    refreshChatMessages();
  }

  void _onDownloadStatus(dynamic data) {
    final String id = data[0];
    final DownloadTaskStatus status = DownloadTaskStatus.fromInt(data[1]);
    final int progress = data[2];
    log('$id:$progress:$status');
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is ChatRecipient) {
      chatUser = argument;
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  void onInit() {
    _getScreenParameter();
    chatMessages.clear();
    initSocket();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen(_onDownloadStatus);
    FlutterDownloader.registerCallback(downloadCallback);
    super.onInit();
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    messageController.dispose();
    chatScrollController.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }
}
