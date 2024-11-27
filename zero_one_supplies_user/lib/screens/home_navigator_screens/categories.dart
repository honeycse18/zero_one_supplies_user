import 'package:ecomik/controller/categories_controller.dart';
import 'package:ecomik/models/api_responses/categories_response.dart';
import 'package:ecomik/models/api_responses/subcategory_response.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/custom_expansion_tile.dart';
import 'package:ecomik/widgets/screen_widgets/subcategory_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<CategoriesScreenController>(
        init: CategoriesScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(AppAssetImages.backgroundFullPng),
                      fit: BoxFit.fill)),
              child: Scaffold(
                appBar: CoreWidgets.appBarWidget(
                  hasBackButton: controller.hasBackButton.value ? true : false,
                  screenContext: context,
                  titleWidget: Text(LanguageHelper.currentLanguageText(
                      LanguageHelper.categoriesTransKey)),
                  /* actions: [
                      Center(
                        child: CustomIconButtonWidget(
                          onTap: () {},
                          hasShadow: true,
                          child: SvgPicture.asset(
                            AppAssetImages.searchSVGLogoLine,
                            color: AppColors.darkColor,
                            height: 18,
                            width: 18,
                          ),
                        ),
                      ),
                      AppGaps.wGap20,
                    ] */
                ),
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.categoriesPagingController.refresh(),
                    child: Column(
                      children: [
                        AppGaps.hGap12,
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              width: 80,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        topRight: Radius.circular(12.0))),
                                child: PagedGridView(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  pagingController:
                                      controller.categoriesPagingController,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1),
                                  builderDelegate:
                                      CoreWidgets.pagedChildBuilderDelegate<
                                              CategoryDocResponse>(
                                          itemBuilder: (context, item, index) {
                                    final CategoryDocResponse category = item;
                                    return Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          boxShadow: controller.selectedIndex ==
                                                  index
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 4,
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ]
                                              : [],
                                          gradient: controller.selectedIndex ==
                                                  index
                                              ? LinearGradient(
                                                  colors: [
                                                      AppColors.primaryColor,
                                                      AppColors.primaryColor
                                                          .withOpacity(0.2)
                                                    ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight)
                                              : LinearGradient(colors: [
                                                  Colors.white.withOpacity(0),
                                                  Colors.white.withOpacity(0)
                                                ]),
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          controller.onCategoryTapped(
                                              index, category);
                                          // controller.getSubcategories(category.id);
                                          // controller.update();
                                        },
                                        child: ListTile(
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 48,
                                                width: 48,
                                                child: CachedNetworkImageWidget(
                                                    boxFit: BoxFit.contain,
                                                    imageURL: category.image),
                                              ),
                                              // Image.asset(
                                              //   category.image,
                                              //   color: controller
                                              //               .selectedIndex ==
                                              //           index
                                              //       ? Colors.white
                                              //       : AppColors.bodyTextColor,
                                              // ),
                                              Text(
                                                category.name,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: controller
                                                              .selectedIndex ==
                                                          index
                                                      ? Colors.white
                                                      : AppColors.bodyTextColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          selected:
                                              controller.selectedIndex == index,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            AppGaps.wGap10,
                            Expanded(
                              child: SizedBox(
                                  height: screenSize.height,
                                  child: PagedListView.separated(
                                      pagingController: controller
                                          .subcategoryPagingController,
                                      builderDelegate:
                                          CoreWidgets.pagedChildBuilderDelegate<
                                              SubcategoryDocResponse>(
                                        itemBuilder: (context, item, index) =>
                                            SubcategoryWidget(
                                                name: item.name,
                                                onExpansionChanged: (value) {
                                                  controller
                                                          .selectedSubcategoryID =
                                                      item.id;
                                                },
                                                products: SubcategoryContent(
                                                  subcategoryID: item.id,
                                                )),
                                        noItemFoundIndicatorBuilder:
                                            (context) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 150,
                                              child: Image.asset(AppAssetImages
                                                  .emptyProductCategoryFound),
                                            ),
                                            AppGaps.hGap10,
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    AppLanguageTranslation
                                                        .noProductFoundInThisCategoryTransKey
                                                        .toCurrentLanguage,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyles
                                                        .bodyTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        errorIndicatorBuilder: (context) {
                                          final dynamic error = controller
                                              .subcategoryPagingController
                                              .error;
                                          if (error is bool && !error) {
                                            return Center(
                                              child: Text(
                                                  LanguageHelper
                                                      .currentLanguageText(
                                                          LanguageHelper
                                                              .noSubCategoriesTransKey),
                                                  textAlign: TextAlign.center),
                                            );
                                          }
                                          return const ErrorPaginationWidget();
                                        },
                                      ),
                                      separatorBuilder: (context, index) =>
                                          AppGaps.hGap20)),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class SubcategoryWidget extends StatelessWidget {
  final String name;
  final Widget products;
  final Function(bool)? onExpansionChanged;
  const SubcategoryWidget(
      {super.key,
      required this.name,
      required this.products,
      this.onExpansionChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomExpansionTile(
            title: Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkColor),
            ),
            onExpansionChanged: onExpansionChanged,
            backgroundColor: Colors.red,
            children: [products],
          ),
        )
      ],
    );
  }
}
