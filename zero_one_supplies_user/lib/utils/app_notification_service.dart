import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      AppSingleton.instance.flutterLocalNotificationsPlugin;

  static Future<bool?> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/launcher_icon');

    var initializationSettingsiOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestProvisionalPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    InitializationSettings initializationSettings = InitializationSettings(
        // android: AndroidInitializationSettings('notification'));
        android: initializationSettingsAndroid,
        iOS: initializationSettingsiOS);
    return await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse:
            _onForegroundNotificationTap,
        onDidReceiveNotificationResponse: _onBackgroundNotificationTap);
  }

  static void _onForegroundNotificationTap(
          NotificationResponse notificationResponse) =>
      _onNotificationTap(notificationResponse);

  static void _onBackgroundNotificationTap(
          NotificationResponse notificationResponse) =>
      _onNotificationTap(notificationResponse);

  static void _onNotificationTap(NotificationResponse notificationResponse) {
    log(notificationResponse.payload.toString());
    if (notificationResponse.payload == null) {
      return;
    }
    try {
      final payloadAsMap = jsonDecode(notificationResponse.payload!);
      if (payloadAsMap is! Map) {
        return;
      }
      const String payloadTypeMapKeyName = 'type';
      final PushNotificationTypeStatus type =
          PushNotificationTypeStatus.toEnumValue(
              payloadAsMap[payloadTypeMapKeyName]);
      if (type == PushNotificationTypeStatus.order) {
        Get.toNamed(AppPageNames.myOrdersScreen);
      }
    } catch (e) {
      return;
    }
  }
}
