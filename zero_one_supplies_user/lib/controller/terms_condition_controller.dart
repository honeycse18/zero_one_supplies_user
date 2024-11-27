import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/about_us_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionScreenController extends GetxController {
  WebViewController webViewController = WebViewController();

  AboutUsShortItem termsCondition = AboutUsShortItem.empty();
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

  Future<void> getTermsCondition() async {
    final Map<String, String> requestBody = {'key': 'terms_&_conditions'};

    final requestBodyJson = jsonEncode(requestBody);
    AboutUsResponse? response =
        await APIRepo.getTermsCondition(requestBodyJson);
    if (response == null) {
      onErrorGetTermsCondition(response);
      return;
    } else if (response.error) {
      onFailureGetTermsCondition(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetTermsCondition(response);
  }

  void onErrorGetTermsCondition(AboutUsResponse? response) {}

  void onFailureGetTermsCondition(AboutUsResponse response) {}

  void onSuccessGetTermsCondition(AboutUsResponse response) {
    termsCondition = response.data;
    webViewController.loadHtmlString(setHTML(termsCondition.description));
    update();
  }

  @override
  void onInit() {
    getTermsCondition();

    super.onInit();
  }
}
