import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomContentWidget extends StatelessWidget {
  final bool isLocationSelected;
  final void Function()? onCrossButtonTap;
  final void Function()? onConfirmTap;
  final TextEditingController textEditingController;
  const BottomContentWidget(
      {super.key,
      this.isLocationSelected = false,
      this.onConfirmTap,
      this.onCrossButtonTap,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    if (isLocationSelected) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTextFormField(
          controller: textEditingController,
          isReadOnly: true,
          hintText: 'Select location',
          labelText: AppLanguageTranslation
              .isThisYourLocationTransKey.toCurrentLanguage,
          prefixIcon: SvgPicture.asset(AppAssetImages.locationSVGLogoLine),
          suffixIcon: CustomIconButtonWidget(
            onTap: onCrossButtonTap,
            isCircleShape: true,
            child: SvgPicture.asset(AppAssetImages.crossicon),
          ),
        ),
        AppGaps.hGap24,
        CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
            onTap: onConfirmTap),
      ]);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: textEditingController,
          isReadOnly: true,
          hintText: 'Select location',
          prefixIcon: SvgPicture.asset(AppAssetImages.locationSVGLogoLine),
        ),
        AppGaps.hGap24,
        CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
            onTap: null),
      ],
    );
  }
}
