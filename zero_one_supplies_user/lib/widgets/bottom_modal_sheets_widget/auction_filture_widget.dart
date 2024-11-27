import 'dart:ui';

import 'package:ecomik/controller/Auction_filter_controller.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyBidScreenWidget extends StatelessWidget {
  const ApplyBidScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplyBidWidgetController>(
        init: ApplyBidWidgetController(),
        builder: (controller) => Container(
              margin: const EdgeInsets.all(18),
              height: 290,
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        // margin: const EdgeInsets.all(18),
                        // height: 290,
                        // width: 300,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.white.withOpacity(0.9),
                            )),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white.withOpacity(0.2),
                              )),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          18.0, 0.0, 12, 0.0),
                                      child: Text(
                                        AppLanguageTranslation.placeABidTransKey
                                            .toCurrentLanguage,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      child: Container(
                                        margin: const EdgeInsets.all(18),
                                        height: 13,
                                        width: 13,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Image.asset(
                                                    AppAssetImages.cross)
                                                .image,
                                            //          xFit.fill
                                          ),
                                        ),
                                      ),
                                      onTap: () => Get.back(),
                                    )
                                  ],
                                ),
                                AppGaps.hGap16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Text(
                                            Helper
                                                .getCurrencyFormattedAmountText(
                                                    controller.dialogParameter
                                                        .applyBid),
                                            // maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .titleLargeXBoldTextStyle),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 18),
                                      child: Text(
                                        AppLanguageTranslation
                                            .lastHighestBidTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles
                                            .bodyLargeSemiboldTextStyle
                                            .copyWith(
                                                color: AppColors.bodyTextColor),
                                      ),
                                    ),
                                  ],
                                ),
                                AppGaps.hGap16,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 18),
                                      child: Text(
                                          AppLanguageTranslation
                                              .enterBidAmountTransKey
                                              .toCurrentLanguage,
                                          style: AppTextStyles
                                              .bidCounterNumberTextStyle),
                                    ),
                                  ],
                                ),

                                AppGaps.hGap10,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: CustomTextFormField(
                                    controller: controller.bidAmountController,
                                    textInputType: TextInputType.number,
                                    validator: controller.applyBidValidator,
                                    prefixIcon: AppGaps.emptyGap,
                                    hintText: r'Eg: $65',
                                  ),
                                ),
                                /* Container(
                                  margin: const EdgeInsets.all(5),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      
                                      contentPadding: EdgeInsets.all(15),
                                    //labelText: 'Enter your name',
                                      hintText: r'Eg: $65',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ), */
                                AppGaps.hGap5,
                                // const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: const EdgeInsets.all(10),
                                          width: 322,
                                          height: 62,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child:
                                              CustomStretchedTextButtonWidget(
                                                  buttonText:
                                                      AppLanguageTranslation
                                                          .bidNowTransKey
                                                          .toCurrentLanguage,
                                                  onTap: controller
                                                      .onBidNowButtonTap)),
                                    )
                                  ],
                                ),
                                // const Spacer(),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
