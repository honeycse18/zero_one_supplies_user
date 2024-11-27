import 'package:ecomik/controller/subcategory_screen_widget_controller.dart';
import 'package:ecomik/models/api_responses/subcategory_children_response.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SubcategoryContent extends StatelessWidget {
  final String subcategoryID;
  const SubcategoryContent({
    super.key,
    this.subcategoryID = '',
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubcategoryChildrenScreenWidgetController>(
        init: SubcategoryChildrenScreenWidgetController(),
        global: false,
        initState: (state) {
          Get.create<String>(() => subcategoryID,
              tag: 'product_subcategory', permanent: false);
        },
        builder: (controller) => SizedBox(
              height: 125,
              child: PagedListView.separated(
                pagingController:
                    controller.subcategoryChildrenPagingController,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return AppGaps.wGap10;
                },
                builderDelegate: CoreWidgets.pagedChildBuilderDelegate<
                        SubsChildrenDocResponse>(
                    noItemFoundIndicatorBuilder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                  AppAssetImages.emptyProductCategoryFound),
                            ),
                            AppGaps.hGap10,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .noProductFoundInThisCategoryTransKey
                                        .toCurrentLanguage,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.bodyTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    itemBuilder: (context, item, index) {
                      final child = item;
                      Map<String, String> childrenItems = {
                        'id': item.id,
                        'name': item.name
                      };
                      return RawButtonWidget(
                        backgroundColor: Colors.white,
                        borderRadiusValue: 12,
                        onTap: () {
                          Get.toNamed(AppPageNames.productPageTwo,
                              arguments: childrenItems);
                        },
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 64,
                                  child: CachedNetworkImageWidget(
                                    // cacheHeight: 65,
                                    // cacheWidth: 75,
                                    boxFit: BoxFit.cover,
                                    imageURL: child.image,
                                  ),
                                ),
                                AppGaps.hGap12,
                                Text(
                                  child.name,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkColor),
                                ),
                                AppGaps.hGap8,
                                Text(
                                  child.totalProducts.isEmpty
                                      ? '0 items'
                                      : '${child.totalProducts[0].count.toString()} items',
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.bodyTextColor),
                                )
                              ]),
                        ),
                      );
                    }),

                // ((context, index) {
                //   final item = FakeData.categoryItems[index];
                //   return GestureDetector(
                //     onTap: () {
                //       Get.toNamed(AppPageNames.productPageTwo);
                //     },
                //     child: Container(
                //       width: 80,
                //       decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(12.0)),
                //       child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Image.asset(item.image),
                //             ),
                //             AppGaps.hGap12,
                //             Text(
                //               item.name,
                //               style: const TextStyle(
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500,
                //                   color: AppColors.darkColor),
                //             ),
                //             AppGaps.hGap8,
                //             Text(
                //               '${item.totalCount} Items',
                //               style: const TextStyle(
                //                   fontSize: 10,
                //                   fontWeight: FontWeight.w300,
                //                   color: AppColors.bodyTextColor),
                //             )
                //           ]),
                //     ),
                //   );
                // }),
              ),
            ));
  }
}
