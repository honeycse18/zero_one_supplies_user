import 'package:ecomik/models/local_models/delivery_pickup_time.dart';
import 'package:ecomik/models/local_models/payment_option.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocalData {
  static List<DeliveryPickupTime> localDeliveryPickupTimes = [
    DeliveryPickupTime(id: '1', timeText: 'Full Day'),
    DeliveryPickupTime(id: '2', timeText: 'Morning 9 AM To  1 PM'),
    DeliveryPickupTime(id: '3', timeText: 'Afternoon 3 PM To 9 PM'),
  ];

  static List<PaymentOption> localPaymentOptions = [
    PaymentOption(
        id: '1',
        name: 'Cash on delivery',
        paymentImage: SvgPicture.asset(AppAssetImages.walletSVGLogoSolid,
            color: AppColors.primaryColor, height: 32, width: 32)),
/*     PaymentOption(
        id: '2',
        name: 'Stripe',
        paymentImage: SvgPicture.asset(AppAssetImages.stripeSVGLogo,
            color: AppColors.primaryColor)), */
    PaymentOption(
        id: '3',
        name: 'Paypal',
        paymentImage: SvgPicture.asset(AppAssetImages.paypalCardSVGLogoColor)),
    PaymentOption(
        id: '4',
        name: 'Moov',
        paymentImage: Image.asset(AppAssetImages.payGateGlobalIconImage)),
    PaymentOption(
        id: '5',
        name: 'Togocell',
        paymentImage: Image.asset(AppAssetImages.payGateGlobalIconImage)),
  ];
}
