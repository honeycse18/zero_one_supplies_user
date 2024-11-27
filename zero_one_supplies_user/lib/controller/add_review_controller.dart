import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReviewScreenController extends GetxController {
  int currentStarRate = 0;
  TextEditingController reviewController = TextEditingController();

  String productId = '';
  String storeId = '';

  void updateRating(int rating) {
    currentStarRate = rating;
    update();
  }

  Future<void> postReview() async {
    final Map<String, dynamic> requestBody = {
      'review': reviewController.text,
      'rating': currentStarRate,
      'product': productId,
      'store': storeId
    };

    final requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.postReview(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetAboutUs(response);
  }

  void onSuccessGetAboutUs(RawAPIResponse response) {
    Get.toNamed(AppPageNames.reviewSuccessScreen);
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is PasswordScreenParameter) {
      productId = argument.productId;
      storeId = argument.storeId;
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameter();
    super.onInit();
  }
}
