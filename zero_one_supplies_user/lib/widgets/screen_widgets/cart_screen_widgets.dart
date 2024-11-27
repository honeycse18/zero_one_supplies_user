import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Cart list tile widget for my cart screen from home screen
class CartItemWidget extends StatelessWidget {
  final int index;
  // final CartProduct cartProduct;
  final String image;
  final String name;
  final String categoryName;
  final double price;
  final int quantity;
  final void Function()? onTap;
  final void Function()? onAddTap;
  final void Function()? onRemoveTap;
  final void Function()? onDeleteTap;
  const CartItemWidget({
    super.key,
    required this.index,
    this.onAddTap,
    this.onRemoveTap,
    this.onDeleteTap,
    this.onTap,
    required this.image,
    required this.name,
    required this.categoryName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
          extentRatio: 0.36,
          motion: const ScrollMotion(),
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppGaps.wGap16,
                Material(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    onTap: onDeleteTap,
                    child: Container(
                        width: 80,
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppAssetImages.deleteSVGLogoLine,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            )
          ]),
      child: CustomListTileWidget(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          paddingValue: const EdgeInsets.all(8),
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CachedNetworkImageWidget(
                    imageURL: image,
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(image: imageProvider),
                              borderRadius: const BorderRadius.all(
                                  (Radius.circular(16)))),
                        )),
              ),
              AppGaps.wGap16,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    AppGaps.hGap2,
                    Text(categoryName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppColors.bodyTextColor, fontSize: 12)),
                    AppGaps.hGap8,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                              Helper.getCurrencyFormattedAmountText(price),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                        PlusMinusCounterRow(
                            onRemoveTap: onRemoveTap,
                            counterText: '$quantity',
                            onAddTap: onAddTap),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

/// Cart list tile widget for my cart screen from home screen
class CartNoInteractableItemWidget extends StatelessWidget {
  final int index;
  // final CartProduct cartProduct;
  final String image;
  final String name;
  final String categoryName;
  final double price;
  final int quantity;
  const CartNoInteractableItemWidget({
    super.key,
    required this.index,
    required this.image,
    required this.name,
    required this.categoryName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        paddingValue: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImageWidget(
                  imageURL: image,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: imageProvider),
                            borderRadius:
                                const BorderRadius.all((Radius.circular(16)))),
                      )),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  AppGaps.hGap2,
                  Text(categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.bodyTextColor, fontSize: 12)),
                  AppGaps.hGap8,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            Helper.getCurrencyFormattedAmountText(price),
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class CartAmountWidget extends StatelessWidget {
  final String name;
  final double amount;
  const CartAmountWidget({super.key, this.name = '', this.amount = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(name, style: AppTextStyles.bodyLargeMediumTextStyle)),
        Text(Helper.getCurrencyFormattedAmountText(amount),
            style: AppTextStyles.bodyLargeMediumTextStyle),
      ],
    );
  }
}

class CartEmptyScreenWidget extends StatelessWidget {
  final String image;
  final String title;
  final String shortTitle;
  final void Function()? onTap;
  const CartEmptyScreenWidget({
    super.key,
    required this.image,
    required this.title,
    required this.shortTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppGaps.hGap40,
        AppGaps.hGap40,
        SizedBox(
          height: 231,
          //  width: 254,
          child: Image.asset(image),
        ),
        AppGaps.hGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: AppTextStyles.titleBoldTextStyle,
              ),
              AppGaps.hGap8,
              Text(shortTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.bodyLargeTextStyle),
            ],
          ),
        ),
        AppGaps.hGap50,
        CustomStretchedTextButtonWidget(
          buttonText:
              AppLanguageTranslation.discoverProductsTransKey.toCurrentLanguage,
          onTap: onTap,
        )
      ],
    );
  }
}
