import 'package:get/get.dart';

class ImageZoomScreenController extends GetxController {
  List<String> imageURLs = [];

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is List<String>) {
      imageURLs = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }
}
