import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ChatRecipients {
  bool error;
  String msg;
  List<ChatRecipient> data;

  ChatRecipients({this.error = false, this.msg = '', this.data = const []});

  factory ChatRecipients.fromJson(Map<String, dynamic> json) {
    return ChatRecipients(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => ChatRecipient.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static ChatRecipients getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatRecipients.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ChatRecipients();
}

class ChatRecipient {
  String id;
  String firstName;
  String lastName;
  String email;
  String role;
  ChatRecipientLastMessage lastMessage;

  ChatRecipient(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.role = '',
      required this.lastMessage});

  factory ChatRecipient.fromJson(Map<String, dynamic> json) => ChatRecipient(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        role: APIHelper.getSafeStringValue(json['role']),
        lastMessage: ChatRecipientLastMessage.getAPIResponseObjectSafeValue(
            json['last_message']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'role': role,
        'last_message': lastMessage.toJson(),
      };

  factory ChatRecipient.empty() =>
      ChatRecipient(lastMessage: ChatRecipientLastMessage.empty());

  static ChatRecipient getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatRecipient.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ChatRecipient.empty();
}

class ChatRecipientLastMessage {
  String message;
  DateTime createdAt;

  ChatRecipientLastMessage({this.message = '', required this.createdAt});

  factory ChatRecipientLastMessage.fromJson(Map<String, dynamic> json) =>
      ChatRecipientLastMessage(
        message: APIHelper.getSafeStringValue(json['message']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
      };

  factory ChatRecipientLastMessage.empty() =>
      ChatRecipientLastMessage(createdAt: AppComponents.defaultUnsetDateTime);

  static ChatRecipientLastMessage getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatRecipientLastMessage.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChatRecipientLastMessage.empty();
}
