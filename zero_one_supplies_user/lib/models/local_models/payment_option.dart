import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:flutter/material.dart';

class PaymentOption {
  final String id;
  final String name;
  final Widget paymentImage;
  PaymentOption({
    this.id = '',
    this.name = '',
    this.paymentImage = AppGaps.emptyGap,
  });
}
