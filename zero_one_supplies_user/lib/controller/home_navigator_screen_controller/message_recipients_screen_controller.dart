import 'dart:developer';

import 'package:ecomik/models/api_responses/chat_recipients.dart';
import 'package:ecomik/models/screen_parameters/message_recipient_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageRecipientsScreenController extends GetxController {
  String vendorID = '';
  List<ChatRecipient> chatUsers = [];
  IO.Socket socket = IO.io(
      '${Constants.appBaseURL}messages',
      IO.OptionBuilder()
          .setAuth({'token': Helper.getUserToken()}).setTransports(
              ['websocket']) // for Flutter or Dart VM
          .build());

  dynamic onUserList(dynamic data) {
/*     chatUsers = APIHelper.getSafeListValue(data)
        .map((e) => ChatUser.getAPIResponseObjectSafeValue(e))
        .toList(); */
    update();
  }

  dynamic onLoadMessages(dynamic data) {
    log('data');
    // chatMessages.clear();
    getChatRecipients();
    update();
  }

  void initSocket() {
    // socket.on('users', onUserList);
    socket.on('load_message', onLoadMessages);
    socket.onConnect((data) {
      log('data');
      getChatRecipients();
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

  Future<void> getChatRecipients() async {
    final ChatRecipients? response =
        await APIRepo.getChatList(vendorID: vendorID);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetChatRecipient(response);
  }

  void _onSuccessGetChatRecipient(ChatRecipients response) {
    chatUsers = response.data;
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is MessageRecipientScreenParameter) {
      vendorID = argument.vendorID;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    initSocket();
    getChatRecipients();
    super.onInit();
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.onClose();
  }
}
