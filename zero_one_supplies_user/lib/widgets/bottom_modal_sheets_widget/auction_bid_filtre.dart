import 'dart:ui';

import 'package:ecomik/controller/auction_bid_filter_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuctionBidFilter extends StatelessWidget {
  final AuctionBidFilterScreenController controller =
      Get.put(AuctionBidFilterScreenController());

  AuctionBidFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuctionBidFilterScreenController>(
        init: AuctionBidFilterScreenController(),
        builder: (controller) => Container(
              margin: const EdgeInsets.all(18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    // margin: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.9),
                        )),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 24, 16, 24),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.white.withOpacity(0.2),
                          )),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // const Spacer(),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(18),
                                    child: Text(
                                      LanguageHelper.currentLanguageText(
                                          LanguageHelper.filterTransKey),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const Spacer(),
                                  CustomTightTextButtonWidget(
                                    child: Container(
                                      margin: const EdgeInsets.all(18),
                                      height: 13,
                                      width: 13,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              Image.asset(AppAssetImages.cross)
                                                  .image,
                                          //          xFit.fill
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                    },
                                  )
                                ],
                              ),

                              Obx(() => Column(
                                    children: [
                                      CustomExpansionTile(
                                          title: Text(
                                              LanguageHelper
                                                  .currentLanguageText(
                                                      LanguageHelper
                                                          .sortByTransKey),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                          children: [
                                            Wrap(
                                              children: [
                                                ChoiceChip(
                                                  selectedColor:
                                                      AppColors.primaryColor,
                                                  label: Text(LanguageHelper
                                                      .currentLanguageText(
                                                          LanguageHelper
                                                              .lowToHighTransKey)),
                                                  selected: controller
                                                          .selectedOptions
                                                          .value ==
                                                      'lowToHigh',
                                                  onSelected: (selected) {
                                                    controller.toggleOption(
                                                        'lowToHigh');
                                                  },
                                                ),
                                                AppGaps.wGap20,
                                                ChoiceChip(
                                                  selectedColor:
                                                      AppColors.primaryColor,
                                                  label: Text(LanguageHelper
                                                      .currentLanguageText(
                                                          LanguageHelper
                                                              .highToLowTransKey)),
                                                  selected: controller
                                                          .selectedOptions
                                                          .value ==
                                                      'highToLow',
                                                  onSelected: (selected) {
                                                    controller.toggleOption(
                                                        'highToLow');
                                                  },
                                                ),
                                                AppGaps.wGap20,
                                                ChoiceChip(
                                                  selectedColor:
                                                      AppColors.primaryColor,
                                                  label: Text(LanguageHelper
                                                      .currentLanguageText(
                                                          LanguageHelper
                                                              .aToZTransKey)),
                                                  selected: controller
                                                          .selectedOptions
                                                          .value ==
                                                      'a2z',
                                                  onSelected: (selected) {
                                                    controller
                                                        .toggleOption('a2z');
                                                  },
                                                ),
                                                AppGaps.wGap20,
                                                ChoiceChip(
                                                  selectedColor:
                                                      AppColors.primaryColor,
                                                  label: Text(LanguageHelper
                                                      .currentLanguageText(
                                                          LanguageHelper
                                                              .zToATransKey)),
                                                  selected: controller
                                                          .selectedOptions
                                                          .value ==
                                                      'z2a',
                                                  onSelected: (selected) {
                                                    controller
                                                        .toggleOption('z2a');
                                                  },
                                                ),
                                              ],
                                            )
                                          ]),
                                    ],
                                  )),

                              Column(
                                children: [
                                  CustomExpansionTile(
                                      title: Text(
                                          LanguageHelper.currentLanguageText(
                                              LanguageHelper
                                                  .categoriesTransKey),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      children: [
                                        Wrap(
                                          children: controller.categories
                                              .map(
                                                (item) => ChoiceChip(
                                                  selectedColor:
                                                      AppColors.primaryColor,
                                                  label: Text(item.name),
                                                  selected: controller
                                                          .selectedCategoryOption
                                                          .id ==
                                                      item.id,
                                                  onSelected: (selected) {
                                                    controller
                                                        .toggleCategoryOption(
                                                            item);
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        )
                                      ]),
                                ],
                              ),
                              Column(
                                children: [
                                  CustomExpansionTile(
                                      title: Text(
                                          LanguageHelper.currentLanguageText(
                                              LanguageHelper
                                                  .subCategoriesTransKey),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      children: [
                                        Wrap(
                                          children: controller.subCategories
                                              .map(
                                                (item) => ChoiceChip(
                                                  selectedColor:
                                                      AppColors.primaryColor,
                                                  label: Text(item.name),
                                                  selected: controller
                                                          .selectedSubCategoryOption
                                                          .id ==
                                                      item.id,
                                                  onSelected: (selected) {
                                                    controller
                                                        .toggleSubCategoryOption(
                                                            item);
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        )
                                      ]),
                                ],
                              ),

                              Column(
                                children: [
                                  CustomExpansionTile(
                                      title: Text(
                                          AppLanguageTranslation
                                              .priceRangeTransKey
                                              .toCurrentLanguage,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      children: [
                                        Wrap(
                                          children: [
                                            RangeSlider(
                                              values:
                                                  controller.currentRangeValues,
                                              max: 100000,
                                              divisions: 100000,
                                              labels: RangeLabels(
                                                Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .start),
                                                Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .end),
                                              ),
                                              onChanged: (RangeValues values) {
                                                controller.toggleSelectedRange(
                                                    values);
                                              },
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .start)),
                                                Text(Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .end)),
                                              ]),
                                        ),
                                      ]),
                                ],
                              ),

                              Row(
                                children: [
                                  TextButton(
                                    onPressed: controller.clearAllButtonTap,
                                    child: Text(
                                      LanguageHelper.currentLanguageText(
                                          LanguageHelper.clearAllTransKey),
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      // Get.toNamed(AppPageNames.bidAuction);
                                      Get.back(
                                          result: controller.filterOptions);
                                    },
                                    child: Text(
                                      LanguageHelper.currentLanguageText(
                                          LanguageHelper.applyFilterTransKey),
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
