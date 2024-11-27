import 'dart:ui';

import 'package:ecomik/controller/bid_won_widget_controller.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_gaps.dart';

class BidWonWidget extends StatelessWidget {
  final String name;
  final bool isWishListed;
  final void Function()? onWishListTap;
  // final String shortFrame;
  final String money;
  final String categoryImageUrl;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final void Function()? onTap;

  const BidWonWidget({
    super.key,
    required this.name,
    // required this.shortFrame,
    this.onWishListTap,
    this.onTap,
    required this.isWishListed,
    required this.money,
    this.categoryImageUrl = '',
    required this.startDateTime,
    required this.endDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BidWonWidgetController>(
        init: BidWonWidgetController(),
        global: false,
        builder: (controller) {
          controller.bidEndDateTime = endDateTime;
          return CustomGridSingleItemWidget(
            borderRadius: AppComponents.productGridItemBorderRadius,
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    // height: 150,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SizedBox(
                          height: 139,
                          child: CachedNetworkImageWidget(
                            imageURL: categoryImageUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: AppComponents.imageBorderRadius,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain)),
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
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.transparent.withOpacity(0.1),
                                        //borderRadius: BorderRadius.circular(16.0),
                                        border: Border.all(
                                          width: 1.5,
                                          color: Colors.transparent
                                              .withOpacity(0.1),
                                        )),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '${controller.remainingDays()}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              AppLanguageTranslation
                                                  .daysTransKey
                                                  .toCurrentLanguage,
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '${controller.remainingHours()}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              AppLanguageTranslation
                                                  .hoursTransKey
                                                  .toCurrentLanguage,
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppTextStyles.bidCounterNumberTextStyle
                        .copyWith(color: AppColors.darkColor),
                  ),
                  /* AppGaps.hGap8,
            Text(
              shortFrame,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: AppColors.bodyTextColor),
            ), */
                  AppGaps.hGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        money,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppTextStyles.labelLargeTextStyle,
                      ),
                      const Spacer(),
                      Text(
                          AppLanguageTranslation
                              .bidClosedTransKey.toCurrentLanguage,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppTextStyles.bodySmallTextStyle),
                      const Spacer(),
                    ],
                  ),
                  AppGaps.hGap8,
                ],
              ),
            ),
          );
        });
  }
}
