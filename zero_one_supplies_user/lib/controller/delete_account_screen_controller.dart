import 'dart:developer';

import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';

class DeleteAccountScreenController extends GetxController {
  Future<void> deleteAccount() async {
    RawAPIResponse? response = await APIRepo.deleteAccount();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetTermsCondition(response);
  }

  void onSuccessGetTermsCondition(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    await Helper.logout();
    update();
  }
}
