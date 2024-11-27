import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendOfferListWidget extends StatelessWidget {
  final String productName;
  final String productImageUrl;
  final String sellerName;
  final double originalPrice;
  final double offeringPrice;
  final int quantity;
  final DateTime date;
  final bool isCancelled;
  final String status;
  final void Function()? onTap;

  const SendOfferListWidget({
    super.key,
    required this.productName,
    required this.sellerName,
    required this.originalPrice,
    required this.offeringPrice,
    required this.quantity,
    required this.date,
    required this.productImageUrl,
    required this.isCancelled,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RawButtonWidget(
            borderRadiusValue: 16,
            onTap: status == 'Approved' ? onTap : null,
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: isCancelled
                      ? AppColors.alertBackgroundColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CachedNetworkImageWidget(
                        imageURL: productImageUrl,
                        imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            )),
                  ),
                  AppGaps.wGap10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                productName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyLargeMediumTextStyle,
                              ),
                            ),
                          ],
                        ),
                        AppGaps.hGap4,
                        Text(
                          sellerName,
                          style: AppTextStyles.bodyTextStyle,
                        ),
                        AppGaps.hGap4,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  AppLanguageTranslation
                                      .originalPriceTransKey.toCurrentLanguage,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodyTextStyle),
                            ),
                            Text(
                              Helper.getCurrencyFormattedAmountText(
                                  originalPrice),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyTextStyle,
                            )
                          ],
                        ),
                        AppGaps.hGap4,
                        Row(
                          children: [
                            Text(
                                AppLanguageTranslation
                                    .dateTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyTextStyle),
                            Text(
                              Helper.ddMMMyyyyFormattedDateTime(date),
                              style: AppTextStyles.bodyTextStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppGaps.wGap10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Helper.getCurrencyFormattedAmountText(offeringPrice),
                        style: AppTextStyles.labelTextStyle.copyWith(
                            color: isCancelled
                                ? Colors.red
                                : AppColors.primaryColor),
                      ),
                      AppGaps.hGap5,
                      Row(
                        children: [
                          Text(
                              '${AppLanguageTranslation.qtyTransKey.toCurrentLanguage}: $quantity',
                              style: AppTextStyles.bodyTextStyle)
                        ],
                      ),
                      Spacer(),
                      status == 'Pending'
                          ? Expanded(
                              child: Text(
                                status,
                                style: AppTextStyles.bodyMediumTextStyle,
                              ),
                            )
                          : status == 'Cancelled'
                              ? Text(
                                  status,
                                  style: AppTextStyles.bodyMediumTextStyle
                                      .copyWith(color: AppColors.alertColor),
                                )
                              : RawButtonWidget(
                                  borderRadiusValue: 10,
                                  onTap: onTap,
                                  child: Container(
                                    height: 30,
                                    width: 85,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor),
                                    child: Center(
                                      child: Text(
                                        AppLanguageTranslation
                                            .buyNowTransKey.toCurrentLanguage,
                                        style: AppTextStyles
                                            .bodyLargeBoldTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
