import 'package:ecomik/models/fake_data.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  final PageController pageController = PageController(keepPage: false);

  /// Go to next intro section
  void gotoNextIntroSection(BuildContext context) {
    // If intro section ends, goto sign in screen.
    if (pageController.page == FakeData.fakeIntroContents.length - 1) {
      Get.toNamed(AppPageNames.signInScreen);
    }
    // Goto next intro section
    pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }
}
