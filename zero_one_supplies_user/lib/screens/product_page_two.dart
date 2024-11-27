import 'package:ecomik/controller/product_second_controller.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/product_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductPageTwo extends StatelessWidget {
  const ProductPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductSecondScreenController>(
        init: ProductSecondScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                  appBar: CoreWidgets.appBarWidget(
                      hasBackButton: true,
                      screenContext: context,
                      titleWidget: Text(controller.childrenName)),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* <---- Search text field ----> */
                            Expanded(
                                child: CustomTextFormField(
                                    hasShadow: true,
                                    controller:
                                        controller.searchTextEditingController,
                                    onChanged: controller.onChange,
                                    hintText: AppLanguageTranslation
                                        .searchTransKey.toCurrentLanguage,
                                    prefixIcon: SvgPicture.asset(
                                        AppAssetImages.searchSVGLogoLine,
                                        color: AppColors.primaryColor))),
                            // AppGaps.wGap8,
                            // /* <---- Filter icon button ----> */
                            // DecoratedBox(
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(15.0),
                            //       gradient: LinearGradient(colors: [
                            //         AppColors.primaryColor,
                            //         AppColors.primaryColor.withOpacity(0.4)
                            //       ])),
                            //   child: CustomIconButtonWidget(
                            //     fixedSize: const Size(60, 60),
                            //     hasShadow: true,
                            //     backgroundColor: Colors.transparent,
                            //     child: SvgPicture.asset(
                            //         AppAssetImages.filterSVGLogoLine,
                            //         color: Colors.white),
                            //     onTap: () {},
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      AppGaps.hGap16,
                      //=======on working==========
                      /*   Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(children: [
                          const Text(
                            'Sort By',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkColor),
                          ),
                          AppGaps.wGap10,
                          SvgPicture.asset(AppAssetImages.arrowDownSVGLogoLine),
                          const Spacer(),
                          const Text(
                            'Filter',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkColor),
                          ),
                          AppGaps.wGap10,
                          SvgPicture.asset(AppAssetImages.filterSVGLogoLine)
                        ]),
                      ), */
                      AppGaps.hGap16,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: RefreshIndicator(
                            onRefresh: () async =>
                                controller.productPagingController.refresh(),
                            child: PagedGridView(
                              pagingController:
                                  controller.productPagingController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 287,
                                      crossAxisSpacing:
                                          AppGaps.screenPaddingValue,
                                      mainAxisSpacing:
                                          AppGaps.screenPaddingValue,
                                      childAspectRatio: 1,
                                      crossAxisCount: 2),
                              builderDelegate: CoreWidgets
                                  .pagedChildBuilderDelegate<ProductShortItem>(
                                      noItemFoundIndicatorBuilder: (context) =>
                                          Center(
                                              child: Text(AppLanguageTranslation
                                                  .noItemFoundTransKey
                                                  .toCurrentLanguage)),
                                      itemBuilder: (context, item, index) {
                                        final product = item;
                                        return CustomGridSingleItemWidget(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppPageNames
                                                      .productDetailsScreen,
                                                  arguments: product.id);
                                            },
                                            child: ProductGridSingleItemWidget(
                                              title: product.name,
                                              originalPrice:
                                                  product.originalPrice,
                                              currentPrice:
                                                  product.currentPrice,
                                              productImageURL: product.image,
                                              isAddedToCart: controller
                                                  .isProductAddedToCart(
                                                      product.id),
                                              isWishListed: product.isFavorite,
                                              onAddTap: () {
                                                controller
                                                    .onProductAddTap(product);
                                              },
                                              onWishlistTap: () {
                                                product.isFavorite =
                                                    !product.isFavorite;
                                                controller.toggleAddToFavorite(
                                                    product.id);
                                                controller.update();
                                              },
                                              discount: product.discount,
                                              discountType:
                                                  product.discountValue.type,
                                              discountValue:
                                                  product.discountValue.amount,
                                              storeName: product.store.name,
                                              isVerified:
                                                  product.store.isVerified,
                                              productCondition: product
                                                  .productConditionStatus,
                                            ));
                                      }),
                              // itemBuilder: (context, index)
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ));
  }
}
