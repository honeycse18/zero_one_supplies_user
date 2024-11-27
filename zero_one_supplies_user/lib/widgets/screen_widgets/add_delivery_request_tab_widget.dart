import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class AddDeliveryRequestTabWidget extends StatelessWidget {
  final int tabIndex;
  final String tabName;
  final bool isLine;
  final AddDeliveryRequestTabState currentTabState;
  final AddDeliveryRequestTabState myTabState;
  const AddDeliveryRequestTabWidget({
    super.key,
    required this.tabIndex,
    required this.tabName,
    this.isLine = false,
    this.currentTabState = AddDeliveryRequestTabState.step1,
    required this.myTabState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (tabIndex != 1)
              Expanded(
                  child: DottedHorizontalLine(
                dashColor: _getTabStateColor(myTabState, currentTabState),
              )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPictureAssetWidget(
                  AppAssetImages.radioButtonSVGLogoLine,
                  color: _getTabStateColor(myTabState, currentTabState),
                ),
                AppGaps.hGap2,
                Text(
                  tabName,
                  style: AppTextStyles.bodyMediumTextStyle.copyWith(
                      color: _getTabStateColor(myTabState, currentTabState)),
                ),
              ],
            ),
            if (tabIndex != 4)
              Expanded(
                  child: DottedHorizontalLine(
                dashColor: _getTabStateColor(myTabState, currentTabState),
              ))
          ],
        ));
  }

  Widget _getTabStatePrefixIconWidget(AddDeliveryRequestTabState tabState) {
    // ignore: unrelated_type_equality_checks
    if (tabState == AddDeliveryRequestDetailsTabState.completed) {
      return const LocalAssetSVGIcon(AppAssetImages.tickIconSVG,
          color: AppColors.primaryColor, height: 4.81);
    }
    return Text(
      '$tabIndex',
      style:
          AppTextStyles.smallestMediumTextStyle.copyWith(color: Colors.white),
    );
  }

  Color _getTabStateColor(AddDeliveryRequestTabState myTabState,
      AddDeliveryRequestTabState currentTabState) {
    const Color inactiveStateColor = AppColors.bodyTextColor;
    Color currentTabStateColor = inactiveStateColor;
    switch (myTabState) {
      case AddDeliveryRequestTabState.step1:
        if (currentTabState == AddDeliveryRequestTabState.step1) {
          currentTabStateColor = AppColors.primaryColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step2) {
          currentTabStateColor = AppColors.primaryColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step3) {
          currentTabStateColor = AppColors.primaryColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step4) {
          currentTabStateColor = AppColors.primaryColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddDeliveryRequestTabState.step2:
        if (currentTabState == AddDeliveryRequestTabState.step1) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step2) {
          currentTabStateColor = AppColors.primaryColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step3) {
          currentTabStateColor = AppColors.primaryColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step4) {
          currentTabStateColor = AppColors.primaryColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddDeliveryRequestTabState.step3:
        if (currentTabState == AddDeliveryRequestTabState.step1) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step2) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step3) {
          currentTabStateColor = AppColors.primaryColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step4) {
          currentTabStateColor = AppColors.primaryColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;
      case AddDeliveryRequestTabState.step4:
        if (currentTabState == AddDeliveryRequestTabState.step1) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step2) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step3) {
          currentTabStateColor = inactiveStateColor;
        } else if (currentTabState == AddDeliveryRequestTabState.step4) {
          currentTabStateColor = AppColors.primaryColor;
        } else {
          currentTabStateColor = inactiveStateColor;
        }
        break;

      default:
        currentTabStateColor = AppColors.primaryColor;
    }
    return currentTabStateColor;
  }
}
