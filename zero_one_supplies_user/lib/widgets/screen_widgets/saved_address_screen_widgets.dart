import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Saved address card widget
class SavedAddressCardWidget extends StatelessWidget {
  final SavedAddressDeliveryType deliveryType;
  final String addressText;
  final bool isPrimary;
  final bool isSelectable;
  final bool isSelected;
  final void Function()? onTap;
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  const SavedAddressCardWidget({
    super.key,
    required this.deliveryType,
    required this.addressText,
    this.isPrimary = false,
    this.onEditTap,
    this.onDeleteTap,
    required this.isSelectable,
    this.isSelected = false,
    this.onTap,
  });

  Widget _getAddressTypeIcon() {
    switch (deliveryType) {
      case SavedAddressDeliveryType.home:
        return SvgPicture.asset(AppAssetImages.home2SVGLogoSolid,
            height: 32, width: 32, color: AppColors.primaryColor);
      case SavedAddressDeliveryType.office:
        return SvgPicture.asset(AppAssetImages.buildingSVGLogoSolid,
            height: 32, width: 32, color: AppColors.primaryColor);
      case SavedAddressDeliveryType.unknown:
        return SvgPicture.asset(AppAssetImages.buildings2SVGLogoSolid,
            height: 32, width: 32, color: AppColors.primaryColor);
      // default:
      //   return SvgPicture.asset(AppAssetImages.buildings2SVGLogoSolid,
      //       height: 32, width: 32, color: AppColors.primaryColor);
    }
  }

  String _getAddressTypeText() {
    switch (deliveryType) {
      case SavedAddressDeliveryType.home:
        return 'Home';
      case SavedAddressDeliveryType.office:
        return 'Office';
      case SavedAddressDeliveryType.unknown:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(AppComponents.defaultBorderRadius);
    return Material(
      color: isSelected
          ? Color.lerp(Colors.white, AppColors.primaryColor, 0.35)
          : Colors.white,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: isSelectable ? onTap : null,
        borderRadius: borderRadius,
        child: Container(
          height: 125,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
          decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(color: AppColors.lineShapeColor),
              borderRadius: borderRadius),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGaps.wGap19,
              _getAddressTypeIcon(),
              AppGaps.wGap15,
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGaps.hGap3,
                  Text(_getAddressTypeText(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600)),
                  AppGaps.hGap10,
                  Text(addressText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.bodyTextColor)),
                ],
              )),
              AppGaps.wGap10,
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TightIconButtonWidget(
                      onTap: onEditTap,
                      child: SvgPicture.asset(AppAssetImages.editSVGLogoLine)),
                  TightIconButtonWidget(
                      onTap: onDeleteTap,
                      child:
                          SvgPicture.asset(AppAssetImages.deleteSVGLogoLine)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
