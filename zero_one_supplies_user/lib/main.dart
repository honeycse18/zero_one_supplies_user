import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/screens/home_navigator_screen.dart';
import 'package:ecomik/utils/app_notification_service.dart';
import 'package:ecomik/utils/app_pages.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  await GetStorage.init();
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = Constants.stripePublishableKey;
  await AppSingleton.instance.initialize();
  await Firebase.initializeApp();
  await LocalNotificationService.initialize();
  FirebaseMessaging.onMessage.listen(onForegroundHandler);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const ZeroOneSuppliesUserApp());
}

Future<void> onForegroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  log(remoteMessage.toMap().toString());
  try {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: jsonEncode(remoteMessage.data));
  } catch (e) {
    await Helper.showNotification(
        title: remoteMessage.notification?.title ?? '',
        message: remoteMessage.notification?.body ?? '',
        payload: remoteMessage.data.toString());
  }
}

class ZeroOneSuppliesUserApp extends StatelessWidget {
  const ZeroOneSuppliesUserApp({super.key});

  // This widget is the root of this app.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '01 Supplies',
      getPages: AppPages.pages,
      unknownRoute: AppPages.unknownScreenPageRoute,
      // onGenerateRoute: AppRouteGenerator.generateRoute,
      initialRoute: AppPageNames.rootScreen,
      theme: AppThemeData.appThemeData,
      // home: UpgradeAlert(child: const HomeNavigatorScreen()),
      // initialBinding: AppBindings(),
    );
  }
}
