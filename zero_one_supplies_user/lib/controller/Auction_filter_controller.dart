import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/bid_details_response.dart';
import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/dialog_Parameters/auction_bid_dialouge_parameters.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyBidWidgetController extends GetxController {
  TextEditingController bidAmountController = TextEditingController();
  BidDetails bidDetails = BidDetails.empty();
  AuctionBidsDialogParameters dialogParameter =
      AuctionBidsDialogParameters(id: '', applyBid: 0);

  void onBidNowButtonTap() {
    final double? bidAmount = double.tryParse(bidAmountController.text);
    if (bidAmount == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .enterValidBidAmountTransKey.toCurrentLanguage);
      return;
    }
    applyBid(bidAmount);
  }

  // String bidProductID = '';
  Future<void> applyBid(double amount) async {
    final Map<String, Object> requestBody = {
      '_id': dialogParameter.id,
      'bid_amount': amount
    };
    final requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.applyBid(requestBodyJson);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessApplyBid(response);
  }

  void onSuccessApplyBid(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.yourBidUpdatedTransKey.toCurrentLanguage);
    Get.back();
  }

  String? applyBidValidator(String? price) {
    if (price != null) {
      if (price.isEmpty) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
    }
    return null;
  }

  void _getScreenParameter() {
    dynamic argument = Get.arguments;
    if (argument is AuctionBidsDialogParameters) {
      dialogParameter = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    bidAmountController.text =
        (dialogParameter.applyBid + 1).toInt().toString();
    super.onInit();
  }

  @override
  void onClose() {
    bidAmountController.dispose();
    super.onClose();
  }
}
