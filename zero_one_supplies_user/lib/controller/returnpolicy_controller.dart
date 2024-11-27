import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/about_us_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReturnPolicyScreenController extends GetxController {
  WebViewController webViewController = WebViewController();

  AboutUsShortItem returnPolicy = AboutUsShortItem.empty();
  String setHTML(String content) {
    return ('''
    <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      </head>
        <body>
        $content
        </body>
      </html>
    ''');
  }

  Future<void> getReturnPolicy() async {
    final Map<String, String> requestBody = {'key': 'return_policy'};

    final requestBodyJson = jsonEncode(requestBody);
    AboutUsResponse? response =
        await APIRepo.getTermsCondition(requestBodyJson);
    if (response == null) {
      onErrorGetPrivacyPolicy(response);
      return;
    } else if (response.error) {
      onFailureGetTermsCondition(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetPrivacyPolicy(response);
  }

  void onErrorGetPrivacyPolicy(AboutUsResponse? response) {}

  void onFailureGetTermsCondition(AboutUsResponse response) {}

  void onSuccessGetPrivacyPolicy(AboutUsResponse response) {
    returnPolicy = response.data;
    webViewController.loadHtmlString(setHTML(returnPolicy.description));
    update();
  }

  @override
  void onInit() {
    getReturnPolicy();

    super.onInit();
  }
}
