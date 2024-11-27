import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Save address as home/office/other category from delivery_set_location screen
class SaveAddressSelectionWidget extends StatelessWidget {
  final bool isSelected;
  final String text;
  final String localSVGIconAssetName;
  final void Function()? onTap;
  const SaveAddressSelectionWidget({
    super.key,
    required this.isSelected,
    required this.text,
    required this.localSVGIconAssetName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 90,
        height: 98,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 78,
                  // width: 98,
                  decoration: const BoxDecoration(
                      color: AppColors.lineShapeColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                Positioned(
                    top: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomIconButtonWidget(
                            hasShadow: true,
                            backgroundColor: isSelected
                                ? AppColors.primaryColor
                                : Colors.white,
                            child: SvgPicture.asset(
                              localSVGIconAssetName,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.primaryColor,
                            )),
                        AppGaps.hGap16,
                        Text(
                          text,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
