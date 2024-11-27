import 'package:ecomik/models/enums.dart';

class OTPScreenParameter {
  final String email;
  final String phone;
  final String type;
  final FromScreenName fromScreenName;

  OTPScreenParameter(
      {this.email = '',
      this.phone = '',
      this.type = '',
      this.fromScreenName = FromScreenName.resetOrForgetPassScreen});
}

class PasswordScreenParameter {
  final String productId;
  final String storeId;

  PasswordScreenParameter({
    this.productId = '',
    this.storeId = '',
  });
}
