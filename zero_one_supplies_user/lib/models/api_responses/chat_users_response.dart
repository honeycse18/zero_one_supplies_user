import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ChatUser {
  String id;
  String firstName;
  String lastName;
  String email;
  ChatUserLastMessage lastMessage;

  ChatUser({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    required this.lastMessage,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        lastMessage: ChatUserLastMessage.getAPIResponseObjectSafeValue(
            json['last_message']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'last_message': lastMessage.toJson(),
      };

  factory ChatUser.empty() =>
      ChatUser(lastMessage: ChatUserLastMessage.empty());

  static ChatUser getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatUser.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ChatUser.empty();
}

class ChatUserLastMessage {
  String message;
  DateTime createdAt;

  ChatUserLastMessage({this.message = '', required this.createdAt});

  factory ChatUserLastMessage.fromJson(Map<String, dynamic> json) =>
      ChatUserLastMessage(
        message: APIHelper.getSafeStringValue(json['message']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
      };

  factory ChatUserLastMessage.empty() =>
      ChatUserLastMessage(createdAt: AppComponents.defaultUnsetDateTime);

  static ChatUserLastMessage getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatUserLastMessage.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChatUserLastMessage.empty();
}
