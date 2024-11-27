import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class UserDetailsResponse {
  bool error;
  String msg;
  UserDetails data;

  UserDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) {
    return UserDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: UserDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory UserDetailsResponse.empty() =>
      UserDetailsResponse(data: UserDetails.empty());

  static UserDetailsResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserDetailsResponse.empty();
}

class UserDetails {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String role;
  bool verified;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime birthday;
  String gender;
  String image;

  UserDetails(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.phone = '',
      this.role = '',
      this.verified = false,
      this.active = false,
      required this.createdAt,
      required this.updatedAt,
      required this.birthday,
      this.gender = '',
      this.image = ''});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
      id: APIHelper.getSafeStringValue(json['_id']),
      firstName: APIHelper.getSafeStringValue(json['first_name']),
      lastName: APIHelper.getSafeStringValue(json['last_name']),
      email: APIHelper.getSafeStringValue(json['email']),
      phone: APIHelper.getSafeStringValue(json['phone']),
      role: APIHelper.getSafeStringValue(json['role']),
      verified: APIHelper.getSafeBoolValue(json['verified']),
      active: APIHelper.getSafeBoolValue(json['active']),
      createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      birthday: APIHelper.getSafeDateTimeValue(json['birthday']),
      gender: APIHelper.getSafeStringValue(json['gender']),
      image: APIHelper.getSafeStringValue(json['image']));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'role': role,
        'phone': phone,
        'verified': verified,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'birthday':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(birthday),
        'gender': gender,
        'image': image
      };

  factory UserDetails.empty() => UserDetails(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime,
      birthday: AppComponents.defaultUnsetDateTime);

  static UserDetails getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : UserDetails.empty();

  bool isEmpty() => id.isEmpty;
}
