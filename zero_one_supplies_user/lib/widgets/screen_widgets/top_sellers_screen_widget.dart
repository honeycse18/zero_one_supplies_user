import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class TopSellerScreenWidget extends StatelessWidget {
  final String name;
  final String image;
  final String category;
  final int product;
  final SellerStatus status;
  final bool showStatus;
  final bool isVerified;

  const TopSellerScreenWidget(
      {super.key,
      this.name = '',
      this.image = '',
      this.category = '',
      this.product = 0,
      required this.status,
      this.isVerified = false,
      this.showStatus = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 248,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(
          height: 139,
          // width: 80,
          child: CachedNetworkImageWidget(
            imageURL: image,
            loadingAssetImageLocation: AppAssetImages.profileAvatar,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  borderRadius: AppComponents.imageBorder,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
        ),
        AppGaps.hGap10,
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLargeSemiboldTextStyle,
              ),
            ),
            VerifiedSellerTickWidget(isVerified: isVerified),
            if (showStatus) SellerStatusBadgeWidget(status: status),
          ],
        ),
        AppGaps.hGap2,
        Center(
          child: Text(
            category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppColors.bodyTextColor),
          ),
        ),
        AppGaps.hGap10,
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
            decoration: BoxDecoration(
                color: AppColors.shadeColor1,
                borderRadius: AppComponents.borderRadius(6)),
            child: Text(
              '$product ${AppLanguageTranslation.itemsTransKey.toCurrentLanguage}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColors.bodyTextColor),
            ),
          ),
        ),
        AppGaps.wGap4,
      ]),
    );
  }

  String getDateTimeText() {
    return '';
  }
}
