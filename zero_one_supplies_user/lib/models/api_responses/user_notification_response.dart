import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class UserNotificationResponse {
  bool error;
  String msg;
  NotificationDataResponse data;

  UserNotificationResponse(
      {this.error = false, this.msg = '', required this.data});

  factory UserNotificationResponse.fromJson(Map<String, dynamic> json) {
    return UserNotificationResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data:
          NotificationDataResponse.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory UserNotificationResponse.empty() =>
      UserNotificationResponse(data: NotificationDataResponse());

  static UserNotificationResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserNotificationResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserNotificationResponse.empty();
}

class NotificationDataResponse {
  List<UserNotificationDocResponse> docs;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  int prevPage;
  int nextPage;

  NotificationDataResponse({
    this.docs = const [],
    this.totalDocs = 0,
    this.limit = 0,
    this.page = 0,
    this.totalPages = 0,
    this.pagingCounter = 0,
    this.hasPrevPage = false,
    this.hasNextPage = false,
    this.prevPage = 0,
    this.nextPage = 0,
  });

  factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
      NotificationDataResponse(
        docs: APIHelper.getSafeListValue(json['docs'])
            .map((e) =>
                UserNotificationDocResponse.getAPIResponseObjectSafeValue(e))
            .toList(),
        totalDocs: APIHelper.getSafeIntValue(json['totalDocs']),
        limit: APIHelper.getSafeIntValue(json['limit']),
        page: APIHelper.getSafeIntValue(json['page']),
        totalPages: APIHelper.getSafeIntValue(json['totalPages']),
        pagingCounter: APIHelper.getSafeIntValue(json['pagingCounter']),
        hasPrevPage: APIHelper.getSafeBoolValue(json['hasPrevPage']),
        hasNextPage: APIHelper.getSafeBoolValue(json['hasNextPage']),
        prevPage: APIHelper.getSafeIntValue(json['prevPage']),
        nextPage: APIHelper.getSafeIntValue(json['nextPage']),
      );

  Map<String, dynamic> toJson() => {
        'docs': docs.map((e) => e.toJson()).toList(),
        'totalDocs': totalDocs,
        'limit': limit,
        'page': page,
        'totalPages': totalPages,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
      };

  static NotificationDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NotificationDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NotificationDataResponse();
}

class UserNotificationDocResponse {
  String id;
  String type;
  bool read;
  String user;
  UserNotificationDataResponse notificationData;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;
  UserNotificationDocResponse? previousNotification;

  UserNotificationDocResponse({
    this.id = '',
    this.type = '',
    this.read = false,
    this.user = '',
    required this.notificationData,
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
    this.previousNotification,
  });

  factory UserNotificationDocResponse.fromJson(Map<String, dynamic> json) =>
      UserNotificationDocResponse(
        id: APIHelper.getSafeStringValue(json['_id']),
        type: APIHelper.getSafeStringValue(json['type']),
        read: APIHelper.getSafeBoolValue(json['read']),
        user: APIHelper.getSafeStringValue(json['user']),
        notificationData:
            UserNotificationDataResponse.fromJson(json['notification_data']),
        expireAt: APIHelper.getSafeDateTimeValue(json['expireAt']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'type': type,
        'read': read,
        'user': user,
        'notification_data': notificationData.toJson(),
        'expireAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(expireAt),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory UserNotificationDocResponse.empty() => UserNotificationDocResponse(
        notificationData: UserNotificationDataResponse(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        expireAt: AppComponents.defaultUnsetDateTime,
      );

  static UserNotificationDocResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserNotificationDocResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserNotificationDocResponse.empty();

  NotificationType get notificationType => NotificationType.toEnumValue(type);
}

class UserNotificationDataResponse {
  String status;
  String id;
  String orderNumber;
  String deliveryNumber;

  UserNotificationDataResponse(
      {this.status = '',
      this.id = '',
      this.orderNumber = '',
      this.deliveryNumber = ''});

  factory UserNotificationDataResponse.fromJson(Map<String, dynamic> json) {
    return UserNotificationDataResponse(
      status: APIHelper.getSafeStringValue(json['status']),
      id: APIHelper.getSafeStringValue(json['_id']),
      orderNumber: APIHelper.getSafeStringValue(json['order_number']),
      deliveryNumber: APIHelper.getSafeStringValue(json['delivery_number']),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        '_id': id,
        'order_number': orderNumber,
        'delivery_number': deliveryNumber,
      };

  static UserNotificationDataResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? UserNotificationDataResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : UserNotificationDataResponse();
  NotificationTypeStatus get notificationStatus =>
      NotificationTypeStatus.toEnumValue(status);
}
