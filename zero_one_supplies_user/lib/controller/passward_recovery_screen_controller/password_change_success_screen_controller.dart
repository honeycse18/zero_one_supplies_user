import 'dart:developer';

import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_local_stored_keys.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PasswordChangeSuccessScreenController extends GetxController {
  onKeepMeLoggedInButtonTap() {
    keepMeLoggedIn();
  }

  Future<void> keepMeLoggedIn() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      // Add Action
      return;
    } else if (response.error) {
      // Add Action
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingUserDetails(response);
  }

  void onSuccessGettingUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    Get.offNamed(AppPageNames.homeNavigatorScreen);
  }

  String theToken = '_notFound';
  _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      theToken = argument;
    }
  }

  void writeTokenToStorage() async {
    await GetStorage().write(LocalStoredKeyName.loggedInVendorToken, theToken);
  }

  @override
  void onInit() {
    _getScreenParameters();
    writeTokenToStorage();
    super.onInit();
  }
}
