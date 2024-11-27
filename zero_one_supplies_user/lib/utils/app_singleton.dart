import 'package:ecomik/models/api_responses/site_settings_response.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppSingleton {
  static AppSingleton? _instance;
  SiteSettings settings = SiteSettings.empty();
  CameraPosition defaultCameraPosition = Constants.defaultMapCameraPosition;
  late Box localBox;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
          Constants.notificationChannelID, Constants.notificationChannelName,
          channelDescription: Constants.notificationChannelDescription,
          importance: Importance.max,
          priority: Priority.max,
          ticker: Constants.notificationChannelTicker);

  final DarwinNotificationDetails darwinNotificationDetails =
      const DarwinNotificationDetails(
    // sound: 'sound.mp3',
    presentAlert: true,
    presentBadge: true,
    presentBanner: true,
    presentSound: true,
    // presentList:
  );

  AppSingleton._();

  Future<void> initialize() async {
    localBox = await Hive.openBox(Constants.hiveBoxName);
    // Plugin must be initialized before using
    await FlutterDownloader.initialize(
        debug:
            true, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
  }

  static AppSingleton get instance => _instance ??= AppSingleton._();
}
