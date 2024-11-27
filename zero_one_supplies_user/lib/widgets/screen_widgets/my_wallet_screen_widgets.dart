import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Recent payment product details list tile from my_wallet screen
class RecentPaymentProductListTileWidget extends StatelessWidget {
  final ImageProvider<Object> productImage;
  final String productName;
  final String dateTimeText;
  final int itemCount;
  final String productPriceText;
  const RecentPaymentProductListTileWidget({
    super.key,
    required this.productImage,
    required this.productName,
    required this.dateTimeText,
    required this.itemCount,
    required this.productPriceText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        hasShadow: true,
        paddingValue: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* <---- Product image ----> */
            Container(
              height: 62,
              width: 62,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: productImage,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16))),
            ),
            AppGaps.wGap16,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* <---- Product name ----> */
                Text(
                  productName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                AppGaps.hGap8,
                /* <---- Product payment date and time ----> */
                Text(
                  dateTimeText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.bodyTextColor),
                ),
              ],
            )),
            AppGaps.wGap16,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /* <---- Product price ----> */
                Text(
                  '\$$productPriceText',
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500),
                ),
                AppGaps.hGap8,
                /* <---- Product count ----> */
                Text(
                  '$itemCount ${AppLanguageTranslation.itemsTransKey.toCurrentLanguage}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.bodyTextColor,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ));
  }
}
