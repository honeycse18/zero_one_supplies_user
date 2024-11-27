import 'package:ecomik/utils/helpers/api_helper.dart';

class VendorChatRecipients {
  bool error;
  String msg;
  List<VendorChatRecipient> data;

  VendorChatRecipients(
      {this.error = false, this.msg = '', this.data = const []});

  factory VendorChatRecipients.fromJson(Map<String, dynamic> json) {
    return VendorChatRecipients(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => VendorChatRecipient.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static VendorChatRecipients getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VendorChatRecipients.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VendorChatRecipients();
}

class VendorChatRecipient {
  String id;
  String firstName;
  String lastName;
  String email;

  VendorChatRecipient(
      {this.id = '', this.firstName = '', this.lastName = '', this.email = ''});

  factory VendorChatRecipient.fromJson(Map<String, dynamic> json) =>
      VendorChatRecipient(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };
  static VendorChatRecipient getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? VendorChatRecipient.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : VendorChatRecipient();
}
