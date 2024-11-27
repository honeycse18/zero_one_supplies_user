import 'dart:convert';
import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/screen_parameters/send_offer_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeOfferBottomSheetController extends GetxController {
  final GlobalKey<FormState> detailsKey = GlobalKey<FormState>();
  String storeId = '';
  String productId = '';
  double oldPrice = 0;
  RxInt productCount = 1.obs;
  TextEditingController priceController = TextEditingController();

  void onAddButtonTap() {
    productCount++;
    update();
  }

  void onRemoveButtonTap() {
    productCount.value <= 1 ? productCount.value = 1 : productCount--;
    update();
  }

  String? priceValidator(String? number) {
    if (number != null) {
      if (number.isEmpty) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
      if (number.toDouble() > oldPrice) {
        return 'Offer price should be less than ${Helper.getCurrencyFormattedAmountText(oldPrice)}';
      }
    }
    return null;
  }

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  Future<void> sendAnOffer() async {
    final Map<String, dynamic> requestBody = {
      'product_id': productId,
      'store': storeId,
      'price': priceController.text,
      'quantity': productCount.value,
    };

    final requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.sendAnOffer(requestBodyJson);
    if (response == null) {
      APIHelper.onError(
        response?.msg,
      );
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessSendAnOffer(response);
  }

  void _onSuccessSendAnOffer(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    update();
    Get.back();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is SendOfferScreenParameter) {
      productId = argument.productId;
      storeId = argument.storeId;
      oldPrice = argument.oldPrice;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameter();
    super.onInit();
  }
}
