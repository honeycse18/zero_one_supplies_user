import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/about_us_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreenController extends GetxController {
  WebViewController webViewController = WebViewController();

  AboutUsShortItem privacyPolicy = AboutUsShortItem.empty();
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

  Future<void> getPrivacyPolicy() async {
    final Map<String, String> requestBody = {'key': 'privacy_policy'};

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
    privacyPolicy = response.data;
    webViewController.loadHtmlString(setHTML(privacyPolicy.description));
    update();
  }

  @override
  void onInit() {
    getPrivacyPolicy();

    super.onInit();
  }
}
