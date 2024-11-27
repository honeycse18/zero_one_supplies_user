import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Toggle option widget for selecting password recovery
class SelectResetPasswordWidget extends StatelessWidget {
  final String titleText;
  final String contentText;
  final String localSVGIconName;
  final bool isSelected;
  final ResetPasswordSelectedChoice currentSelectedRadioValue;
  final ResetPasswordSelectedChoice groupRadioValue;
  final void Function() onTap;
  const SelectResetPasswordWidget({
    super.key,
    required this.isSelected,
    required this.titleText,
    required this.contentText,
    required this.onTap,
    required this.currentSelectedRadioValue,
    required this.groupRadioValue,
    required this.localSVGIconName,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(AppComponents.defaultBorderRadius),
      child: InkWell(
        borderRadius: const BorderRadius.all(AppComponents.defaultBorderRadius),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.lineShapeColor),
              borderRadius:
                  const BorderRadius.all(AppComponents.defaultBorderRadius)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRadioWidget(
                  value: currentSelectedRadioValue,
                  groupValue: groupRadioValue,
                  onChanged: (currentlySelectedRadioValue) => onTap()),
              AppGaps.wGap16,
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 5,
                    children: [
                      Text(titleText,
                          style: TextStyle(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : AppColors.darkColor,
                              fontWeight: FontWeight.w600)),
                      SvgPicture.asset(localSVGIconName,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.darkColor),
                    ],
                  ),
                  AppGaps.hGap16,
                  Text(contentText,
                      style: const TextStyle(color: AppColors.bodyTextColor)),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
