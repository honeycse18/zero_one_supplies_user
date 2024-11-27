import 'dart:ui';

import 'package:ecomik/controller/product_controller.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFilter extends StatelessWidget {
  const ProductFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductFilterScreenController>(
        init: ProductFilterScreenController(),
        builder: (controller) => Container(
              margin: const EdgeInsets.all(18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
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
                                                  label: Text(
                                                    LanguageHelper
                                                        .currentLanguageText(
                                                            LanguageHelper
                                                                .lowToHighTransKey),
                                                  ),
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
                                        /* Wrap(
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
                                        ) */
                                        ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final category =
                                                  controller.categories[index];
                                              return CustomListTileWidget(
                                                  borderRadius: AppComponents
                                                      .borderRadius(8),
                                                  paddingValue: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 14,
                                                      vertical: 10),
                                                  onTap: () => controller
                                                      .toggleCategoryOption(
                                                          category),
                                                  child: Row(
                                                    children: [
                                                      RadioTextWidget(
                                                          value: category,
                                                          text: category.name,
                                                          onChanged: (p0) =>
                                                              controller
                                                                  .toggleCategoryOption(
                                                                      category),
                                                          groupValue: controller
                                                              .selectedCategoryOption)
                                                    ],
                                                  ));
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.hGap6,
                                            itemCount:
                                                controller.categories.length)
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
