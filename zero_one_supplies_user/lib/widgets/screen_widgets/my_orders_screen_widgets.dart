import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Order status box widget
class OrderStatusWidget extends StatelessWidget {
  final String orderStatus;
  const OrderStatusWidget({
    super.key,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    final String statusText;
    final Color statusBackgroundColor;
    final orderStatusEnum = MyOrderStatusTypes.toEnumValue(orderStatus);
    switch (orderStatusEnum) {
      case MyOrderStatusTypes.placed:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.placed.stringValueForView);
        statusBackgroundColor = AppColors.mainColor;
        break;
      case MyOrderStatusTypes.pending:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.pending.stringValueForView);
        statusBackgroundColor = AppColors.secondaryColor;
        break;
      case MyOrderStatusTypes.confirm:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.confirm.stringValueForView);
        statusBackgroundColor = AppColors.darkColor;
        break;
      case MyOrderStatusTypes.processing:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.processing.stringValueForView);
        statusBackgroundColor = AppColors.tertiaryColor;
        break;
      case MyOrderStatusTypes.picked:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.picked.stringValueForView);
        statusBackgroundColor = AppColors.primaryColor;
        break;
      case MyOrderStatusTypes.onWay:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.onWay.stringValueForView);
        statusBackgroundColor = AppColors.primaryMaterialColor;
        break;
      case MyOrderStatusTypes.delivered:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.delivered.stringValueForView);
        statusBackgroundColor = AppColors.successColor;
        break;
      case MyOrderStatusTypes.cancelled:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.cancelled.stringValueForView);
        statusBackgroundColor = AppColors.alertColor;
        break;
      default:
        statusText = LanguageHelper.currentLanguageText(
            MyOrderStatusTypes.pending.stringValueForView);
        statusBackgroundColor = AppColors.secondaryColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: statusBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(6))),
      child: Text(
        statusText,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Product list tile for my order tab page from home screen.
class MyOrderProductWidget extends StatelessWidget {
  final void Function()? onTap;
  final String productImage;
  final String productName;
  final String priceText;
  final String paymentMetod;
  final String orderStatusText;
  final DateTime dateText;
  const MyOrderProductWidget({
    super.key,
    this.onTap,
    required this.productImage,
    required this.productName,
    required this.priceText,
    required this.paymentMetod,
    required this.orderStatusText,
    required this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        paddingValue: const EdgeInsets.all(16),
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: 70,
              // decoration: BoxDecoration(
              //     borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     image:
              //         DecorationImage(image: productImage, fit: BoxFit.cover)),
              child: CachedNetworkImageWidget(imageURL: productImage),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLanguageTranslation.idTransKey.toCurrentLanguage} #$productName',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  AppGaps.hGap12,
                  Row(
                    children: [
                      Text(
                        AppLanguageTranslation
                            .totalCostTransKey.toCurrentLanguage,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        priceText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  AppGaps.hGap12,
                  if (paymentMetod.isNotEmpty)
                    Row(
                      children: [
                        Text(
                          AppLanguageTranslation
                              .methodTransKey.toCurrentLanguage,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: AppColors.darkColor,
                                  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          paymentMetod,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                OrderStatusWidget(orderStatus: orderStatusText),
                AppGaps.hGap16,
                Text(
                  Helper.MMMddyyyyFormattedDateTime(dateText),
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.bodyTextColor),
                ),
              ],
            )
          ],
        ));
  }
}

/// Order Status widget.
class OrderStatusProductWidget extends StatelessWidget {
  final void Function()? onTap;
  final String imageUrl;
  final String productName;
  final double price;
  final String categoryName;
  final int quantity;

  const OrderStatusProductWidget({
    super.key,
    this.onTap,
    this.imageUrl = '',
    this.productName = '',
    this.price = 0,
    this.categoryName = '',
    this.quantity = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        paddingValue: const EdgeInsets.all(16),
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image:
                      DecorationImage(image: productImage, fit: BoxFit.cover)),
            ), */

            SizedBox(
              height: 99,
              width: 99,
              child: CachedNetworkImageWidget(
                imageURL: imageUrl,
                loadingAssetImageLocation: AppAssetImages.profileAvatar,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.imageBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  AppGaps.hGap2,
                  Text(
                    categoryName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                  AppGaps.hGap10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Helper.getCurrencyFormattedAmountText(price),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        '${AppLanguageTranslation.qtyTransKey.toCurrentLanguage} :  $quantity',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
