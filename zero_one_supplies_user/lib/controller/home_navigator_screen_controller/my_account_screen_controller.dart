import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class MyAccountScreenController extends GetxController {
  UserDetails userDetails = UserDetails.empty();

  getUser() {
    userDetails = Helper.getUser();
    update();
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
