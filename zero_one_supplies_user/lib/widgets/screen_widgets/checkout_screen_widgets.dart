import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Payment option list tile widget from checkout screen
class PaymentOptionListTileWidget extends StatelessWidget {
  const PaymentOptionListTileWidget({
    super.key,
    required this.hasShadow,
    required this.paymentIconWidget,
    required this.paymentName,
    required this.index,
    required this.selectedPaymentOptionIndex,
    required this.radioOnChange,
    this.onTap,
  });

  final bool hasShadow;
  final Widget paymentIconWidget;
  final String paymentName;
  final int index;
  final int selectedPaymentOptionIndex;
  final void Function(Object?) radioOnChange;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        hasShadow: hasShadow,
        paddingValue: const EdgeInsets.all(8),
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 62,
              width: 62,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: AppColors.shadeColor1,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: paymentIconWidget,
            ),
            AppGaps.wGap16,
            Expanded(
                child: Text(
              paymentName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )),
            AppGaps.wGap16,
            CustomRadioWidget(
                value: index,
                groupValue: selectedPaymentOptionIndex,
                onChanged: radioOnChange)
          ],
        ));
  }
}
