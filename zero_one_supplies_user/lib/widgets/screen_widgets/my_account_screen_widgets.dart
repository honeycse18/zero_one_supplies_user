import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// List tile button for my_account screens
class CustomListTileMyAccountWidget extends StatelessWidget {
  final String text;
  final Widget icon;
  final void Function()? onTap;
  const CustomListTileMyAccountWidget({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: onTap,
        borderRadiusRadiusValue: const Radius.circular(14),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomIconButtonWidget(
              fixedSize: const Size(48, 48),
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: icon,
            ),
            AppGaps.wGap16,
            Expanded(
              child: Text(text,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            Transform.scale(
                scaleX: -1,
                child: SvgPicture.asset(AppAssetImages.arrowLeftSVGLogoLine,
                    color: AppColors.bodyTextColor)),
          ],
        ));
  }
}
