import 'dart:ui';

import 'package:ecomik/controller/bid_widget_controller.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidWidget extends StatelessWidget {
  final bool isWishListed;
  final void Function()? onWishListTap;
  final String name;
  final String categoryName;
  final String price;
  final String categoryImageUrl;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final void Function()? onTap;
  final String storeName;
  final bool isVerified;
  const BidWidget({
    super.key,
    required this.name,
    this.categoryName = '',
    this.onWishListTap,
    this.onTap,
    this.isWishListed = false,
    this.price = '',
    this.categoryImageUrl = '',
    required this.startDateTime,
    required this.endDateTime,
    required this.storeName,
    required this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BidWidgetController>(
        init: BidWidgetController(),
        global: false,
        builder: (controller) {
          controller.bidEndDateTime = endDateTime;
          return CustomGridSingleItemWidget(
            borderRadius: AppComponents.productGridItemBorderRadius,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  // height: 159,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 159,
                        child: CachedNetworkImageWidget(
                          imageURL: categoryImageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: AppComponents.imageBorderRadius,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10.0,
                                  sigmaY: 10.0,
                                ),
                                child: Container(
                                  height: 40,
                                  // width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      //borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        width: 1.5,
                                        color: Colors.black.withOpacity(0.1),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${controller.remainingDays()}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            AppLanguageTranslation
                                                .daysTransKey.toCurrentLanguage,
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${controller.remainingHours()}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            AppLanguageTranslation.hoursTransKey
                                                .toCurrentLanguage,
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${controller.remainingMinutes()}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            AppLanguageTranslation
                                                .minutesTransKey
                                                .toCurrentLanguage,
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '${controller.remainingSeconds()}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            AppLanguageTranslation
                                                .secondsTransKey
                                                .toCurrentLanguage,
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (Helper.isUserLoggedIn())
                        Positioned(
                            top: 10,
                            right: 10,
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              // color: Colors.white.withOpacity(0.9),
                              child: WishlistItemButtonWidget(
                                  isWishListed: isWishListed,
                                  onTap: onWishListTap),
                            ))
                    ],
                  ),
                ),
                AppGaps.hGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppTextStyles.bidCounterNumberTextStyle
                            .copyWith(color: AppColors.darkColor),
                      ),
                      AppGaps.hGap8,
                      if (categoryName.isNotEmpty)
                        Text(
                          categoryName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: AppColors.bodyTextColor),
                        ),
                      AppGaps.hGap4,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            storeName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: AppColors.bodyTextColor),
                          ),
                          AppGaps.wGap5,
                          VerifiedSellerTickWidget(isVerified: isVerified)
                        ],
                      ),
                      AppGaps.hGap8,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            price,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppTextStyles.labelLargeTextStyle,
                          ),
                          AppGaps.wGap8,
                          Text(
                              AppLanguageTranslation
                                  .currentbidTransKey.toCurrentLanguage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppTextStyles.bodySmallTextStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                AppGaps.hGap8,
              ],
            ),
          );
        });
  }
}
