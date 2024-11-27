import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/about_us_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreenController extends GetxController {
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

  AboutUsShortItem aboutUs = AboutUsShortItem.empty();

  Future<void> getAboutUs() async {
    final Map<String, String> requestBody = {'key': 'about_us'};

    final requestBodyJson = jsonEncode(requestBody);
    AboutUsResponse? response = await APIRepo.getAboutUs(requestBodyJson);
    if (response == null) {
      onErrorGetAboutUs(response);
      return;
    } else if (response.error) {
      onFailureGetAboutUs(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetAboutUs(response);
  }

  void onErrorGetAboutUs(AboutUsResponse? response) {}

  void onFailureGetAboutUs(AboutUsResponse response) {}

  void onSuccessGetAboutUs(AboutUsResponse response) {
    aboutUs = response.data;
    webViewController.loadHtmlString(setHTML(aboutUs.description));
    update();
  }

  @override
  void onInit() {
    getAboutUs();

    super.onInit();
  }
}
