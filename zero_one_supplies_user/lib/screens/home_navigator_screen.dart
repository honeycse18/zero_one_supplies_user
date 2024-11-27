import 'dart:async';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:ecomik/screens/home_navigator_screens/cart_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/categories.dart';
import 'package:ecomik/screens/home_navigator_screens/home_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/message_recipients_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/my_account_screen.dart';
import 'package:ecomik/screens/sign_in_screen.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

class HomeNavigatorScreen extends StatefulWidget {
  /// The parameter variable argument holds screen index number to show that tab
  /// screen initially.
  final Object? screenTabIndex;
  const HomeNavigatorScreen({super.key, this.screenTabIndex});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  /// Current page index
  int _currentPageIndex = 2;

  /// Tabbed screen widget of selected tab
  Widget _nestedScreenWidget = const Scaffold();
  DateTime currentBackPressTime = AppComponents.defaultUnsetDateTime;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  /* <-------- Select current page index initially --------> */
  void _setCurrentPageIndex(Object? argument) {
    if (argument != null) {
      if (argument is int) {
        _currentPageIndex = argument;
      }
    }
  }

  /* <-------- Select current tab screen --------> */
  void _setCurrentTab() {
    const int categoryScreenIndex = 0;
    const int cartScreenIndex = 1;
    const int homeScreenIndex = 2;
    const int messageScreenIndex = 3;
    const int accountScreenIndex = 4;
    switch (_currentPageIndex) {
      case homeScreenIndex:
        _nestedScreenWidget = const HomeScreen();
        break;
      case cartScreenIndex:
        _nestedScreenWidget =
            Helper.isUserLoggedIn() ? const CartScreen() : cartScreenMethod();
        // case cartScreenIndex:
        //   _nestedScreenWidget = const DeliverySetLocationScreen();
        break;
      case categoryScreenIndex:
        _nestedScreenWidget = const CategoriesPage();
        break;
      case messageScreenIndex:
        _nestedScreenWidget = Helper.isUserLoggedIn()
            ? const MessageRecipientsScreen()
            : messageMethods();
        break;
      case accountScreenIndex:
        _nestedScreenWidget = const MyAccountScreen();
        break;
      default:
        // Invalid page index set tab to dashboard screen
        _nestedScreenWidget = const HomeScreen();
    }
  }

  SignInScreen cartScreenMethod() {
    Get.snackbar(
      AppLanguageTranslation.loginRequiredTransKey.toCurrentLanguage,
      AppLanguageTranslation.continueCartLoginTransKey.toCurrentLanguage,
    );

    return const SignInScreen();
  }

  SignInScreen messageMethods() {
    Get.snackbar(AppLanguageTranslation.loginRequiredTransKey.toCurrentLanguage,
        AppLanguageTranslation.loginMessageContinueTransKey.toCurrentLanguage);
    return const SignInScreen();
  }

  Future<bool> onWillPop(BuildContext context) {
/*     if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
      return Future.value(false);
    } */
    DateTime now = DateTime.now();
    if (currentBackPressTime.year == Constants.defaultUnsetDateTimeYear ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Helper.showSnackBar(
          AppLanguageTranslation.tapBackAgainToExitTransKey.toCurrentLanguage);
      // ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Tap back again to exit')));
      return Future.value(false);
    }
    Helper.exitApp();
    return Future.value(true);
  }

  void _setNotificationPermission() async {
    await Helper.setNotificationPermission();
  }

  Future<void> _openAppLink(Uri? uri) async {
    if (uri == null) {
      return;
    }
    if (uri.queryParameters.isEmpty) {
      return;
    }
    if (uri.scheme == 'zeroonesuppliesuser') {
      if (Get.currentRoute != AppPageNames.homeNavigatorScreen) {
        await Get.offAllNamed(AppPageNames.homeNavigatorScreen);
      }
      return;
    }

    if (uri.scheme == 'zeroonesuppliesuserpaygateglobal') {
      Helper.showSnackBar(AppLanguageTranslation
          .youHaveSuccessfullyMadePaymentFromPaygateGlobalTransKey
          .toCurrentLanguage);
      if (Get.currentRoute != AppPageNames.homeNavigatorScreen) {
        await Get.offAllNamed(AppPageNames.homeNavigatorScreen);
      }
      AppDialogs.showSuccessDialog(
          messageText: AppLanguageTranslation
              .youHaveSuccessfullyMadePaymentFromPaygateGlobalTransKey
              .toCurrentLanguage,
          titleText: AppLanguageTranslation
              .paymentSuccessfullyCompletedTransKey.toCurrentLanguage);
      return;
    }
    if (uri.queryParameters['payment'] == null) {
      return;
    }
    if (uri.queryParameters['payment'] == 'true') {
      AppDialogs.showSuccessDialog(
          messageText: AppLanguageTranslation
              .youHaveSuccessfullyMadePaymentTransKey.toCurrentLanguage,
          titleText: AppLanguageTranslation
              .paymentSuccessfullyCompletedTransKey.toCurrentLanguage);
    }
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      _openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      _openAppLink(uri);
    });
  }

  Future<void> _checkBatteryOptimizationDisabled() async {
    if (Platform.isAndroid) {
/*       await DisableBatteryOptimization.isAllBatteryOptimizationDisabled;
      await DisableBatteryOptimization.showDisableAllOptimizationsSettings(
          'Enable Auto Start',
          'Follow the steps and enable the auto start of this app',
          'Your device has additional battery optimization',
          'Follow the steps and disable the optimizations to allow smooth functioning of this app'); */
      final bool? isAutoStartEnabled =
          await DisableBatteryOptimization.isAutoStartEnabled;
      if (isAutoStartEnabled == false) {
        await DisableBatteryOptimization.showEnableAutoStartSettings(
            'Enable Auto Start',
            'Follow the steps and enable the auto start of this app');
      }
      final bool? isBatteryOptimizationDisabled =
          await DisableBatteryOptimization.isBatteryOptimizationDisabled;
      if (isBatteryOptimizationDisabled == false) {
        final bool? isEnableAutoStartSettingsShown =
            await DisableBatteryOptimization.showEnableAutoStartSettings(
                'Enable Auto Start',
                'Follow the steps and enable the auto start of this app');
      }
/*       final bool? isManBatteryOptimizationDisabled =
          await DisableBatteryOptimization
              .isManufacturerBatteryOptimizationDisabled;
      final bool? isDisableManufacturerBatteryOptimizationSettingsShown =
          await DisableBatteryOptimization
              .showDisableManufacturerBatteryOptimizationSettings(
                  'Your device has additional battery optimization',
                  'Follow the steps and disable the optimizations to allow smooth functioning of this app'); */
    }
  }

  /* <-------- Initial state --------> */
  @override
  void initState() {
    _initDeepLinks();
    _setCurrentPageIndex(widget.screenTabIndex);
    _setCurrentTab();
    _setNotificationPermission();
    _checkBatteryOptimizationDisabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: Image.asset(AppAssetImages.backgroundFullPng).image,
                  fit: BoxFit.fill)),
          child: Scaffold(
              backgroundColor: Colors.transparent,

              /* <-------- Content --------> */
              body: _nestedScreenWidget,
              /* <-------- Bottom tab bar --------> */
              bottomNavigationBar: SizedBox(
                height: Platform.isIOS ? 87 : 77,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: Platform.isIOS ? 80 : 60,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: Image.asset(
                                      AppAssetImages.bottomMenuBarBackground)
                                  .image,
                              fit: BoxFit.fill)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: bottomMenuButton(
                                          AppLanguageTranslation
                                              .categoryTransKey
                                              .toCurrentLanguage,
                                          AppAssetImages.categoryMenu,
                                          0),
                                    ),
                                    Expanded(
                                      child: bottomMenuButton(
                                          AppLanguageTranslation
                                              .cartTransKey.toCurrentLanguage,
                                          AppAssetImages.cartMenu,
                                          1),
                                    )
                                  ]),
                            ),
                            AppGaps.wGap60,
                            Expanded(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: bottomMenuButton(
                                          AppLanguageTranslation.messageTransKey
                                              .toCurrentLanguage,
                                          AppAssetImages.messageSVGLogoLine,
                                          3),
                                    ),
                                    Expanded(
                                      child: bottomMenuButton(
                                          Helper.isUserLoggedIn()
                                              ? 'Profile'
                                              : 'Menu',
                                          Helper.isUserLoggedIn()
                                              ? AppAssetImages.profileMenu
                                              : AppAssetImages.menuMenu,
                                          4),
                                    )
                                  ]),
                            )
                          ]),
                    ),
                    Positioned(
                      // bottom: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTightTextButtonWidget(
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: (_currentPageIndex == 2)
                                      ? LinearGradient(colors: [
                                          AppColors.primaryColor,
                                          AppColors.primaryColor
                                              .withOpacity(0.4)
                                        ])
                                      : null,
                                  image: _currentPageIndex == 2
                                      ? null
                                      : DecorationImage(
                                          image: Image.asset(
                                                  AppAssetImages.homeMenuBack)
                                              .image,
                                          fit: BoxFit.fill)),
                              child: SvgPicture.asset(
                                AppAssetImages.homeMenu,
                                color: _currentPageIndex == 2
                                    ? Colors.white
                                    : AppColors.bodyTextColor,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _setCurrentPageIndex(2);
                                _setCurrentTab();
                              });
                            },
                          ),
                          // Expanded( child: Container(),)
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Widget bottomMenuButton(String name, String image, int index) {
    return TightIconButtonWidget(
      constraints: const BoxConstraints(minHeight: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
            color: (_currentPageIndex == index)
                ? AppColors.primaryColor
                : AppColors.bodyTextColor,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: (_currentPageIndex == index)
                    ? AppColors.primaryColor
                    : AppColors.bodyTextColor,
                fontWeight: (_currentPageIndex == index)
                    ? FontWeight.w500
                    : FontWeight.normal),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          _setCurrentPageIndex(index);
          _setCurrentTab();
        });
      },
    );
  }
}
