import 'package:ecomik/models/fake_data.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/intro_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upgrader/upgrader.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  /// Page controller for managing intro content sequences.
  final PageController _pageController = PageController(keepPage: false);

  void _gotoNextScreen() {
    // Get.toNamed(AppPageNames.signInScreen);
    Get.toNamed(AppPageNames.homeNavigatorScreen);
  }

  /// Go to next intro section
  void _gotoNextIntroSection(BuildContext context) {
    // If intro section ends, goto sign in screen.
    if (_pageController.page == FakeData.fakeIntroContents.length - 1) {
      _gotoNextScreen();
    }
    // Goto next intro section
    _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  void _setNotificationPermission() async {
    await Helper.setNotificationPermission();
  }

  @override
  void initState() {
    if (Helper.isUserLoggedIn()) {
      _setNotificationPermission();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return UpgradeAlert(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(AppAssetImages.backgroundFullPng).image,
                fit: BoxFit.fill)),
        child: Scaffold(
          /* <-------- Content --------> */
          body: SafeArea(
            top: true,
            bottom: true,
            left: true,
            right: true,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: FakeData.fakeIntroContents.length,
                      itemBuilder: (context, index) {
                        /// Single intro screen data
                        final fakeIntroContent =
                            FakeData.fakeIntroContents[index];
                        /* <---- Single Intro screen widget ----> */
                        return Padding(
                          padding: EdgeInsets.only(
                              top: context.mediaQueryViewPadding.top + 90),
                          child: IntroContentWidget(
                              screenSize: screenSize,
                              localImageLocation:
                                  fakeIntroContent.localSVGImageLocation,
                              slogan: fakeIntroContent.slogan,
                              subtitle: fakeIntroContent.content),
                        );
                      },
                    ),
                  ),
                  AppGaps.hGap10,
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: FakeData.fakeIntroContents.length,
                    axisDirection: Axis.horizontal,
                    effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 2,
                        expansionFactor: 3,
                        activeDotColor: AppColors.primaryColor,
                        dotColor: AppColors.darkColor.withOpacity(0.2)),
                  ),
                  AppGaps.hGap50,
                ]),
          ),
          /* <-------- Bottom bar --------> */
          bottomNavigationBar: CustomScaffoldBottomBarWidget(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /* <---- Next button ----> */
                  CustomStretchedTextButtonWidget(
                      buttonText: LanguageHelper.currentLanguageText(
                          LanguageHelper.nextTransKey),
                      onTap: () {
                        _gotoNextIntroSection(context);
                      }),
                  /* <---- Skip button ----> */
                  TextButton(
                      onPressed: () {
                        // Goto sign in screen.
                        _gotoNextScreen();
                      },
                      child: Text(LanguageHelper.currentLanguageText(
                          LanguageHelper.skipTransKey)))
                ]),
          ),
        ),
      ),
    );
  }
}
