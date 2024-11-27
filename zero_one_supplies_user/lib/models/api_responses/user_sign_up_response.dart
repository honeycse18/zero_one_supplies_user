import 'package:ecomik/utils/helpers/api_helper.dart';

class UserSignUpResponse {
  bool error;
  String msg;
  String otp;
  String phone;
  String email;

  UserSignUpResponse(
      {this.error = false,
      this.msg = '',
      this.otp = '',
      this.phone = '',
      this.email = ''});

  factory UserSignUpResponse.fromJson(Map<String, dynamic> json) {
    return UserSignUpResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      otp: APIHelper.getSafeStringValue(json['otp']),
      phone: APIHelper.getSafeStringValue(json['phone']),
      email: APIHelper.getSafeStringValue(json['email']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'otp': otp,
        'phone': phone,
        'email': email,
      };
  static UserSignUpResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserSignUpResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserSignUpResponse();
}
