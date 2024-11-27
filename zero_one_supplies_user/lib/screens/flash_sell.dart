import 'package:ecomik/controller/home_navigator_screen_controller/flash_sell_controller.dart';
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

class FlashSellScreen extends StatelessWidget {
  const FlashSellScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlashSellScreenController>(
        init: FlashSellScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: true,
                    actions: [
                      Center(
                        child: CustomIconButtonWidget(
                            onTap: () {
                              Get.toNamed(AppPageNames.productPage);
                            },
                            hasShadow: true,
                            child: SvgPicture.asset(
                              AppAssetImages.searchSVGLogoLine,
                              color: AppColors.darkColor,
                              height: 18,
                              width: 18,
                            )),
                      ),
                      AppGaps.wGap20,
                    ],
                    titleWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLanguageTranslation.flaTransKey.toCurrentLanguage,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkColor),
                        ),
                        Container(
                          width: 14,
                          height: 24,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.asset(AppAssetImages.flashIcon)
                                      .image)),
                        ),
                        Text(
                          AppLanguageTranslation
                              .hSellTransKey.toCurrentLanguage,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkColor),
                        ),
                      ],
                    )),
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.flashSellPagingController.refresh(),
                    child: CustomScrollView(
                      slivers: [
                        PagedSliverGrid(
                          pagingController:
                              controller.flashSellPagingController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: AppGaps.screenPaddingValue,
                                  mainAxisSpacing: AppGaps.screenPaddingValue,
                                  mainAxisExtent: 287,
                                  crossAxisCount: 2,
                                  childAspectRatio: 1),
                          builderDelegate: CoreWidgets
                              .pagedChildBuilderDelegate<ProductShortItem>(
                                  itemBuilder: (context, item, index) {
                            final ProductShortItem product = item;
                            return CustomGridSingleItemWidget(
                                onTap: () {
                                  Get.toNamed(AppPageNames.productDetailsScreen,
                                      arguments: product.id);
                                },
                                child: ProductGridSingleItemWidget(
                                  title: product.name,
                                  category: '',
                                  originalPrice: product.originalPrice,
                                  currentPrice: product.currentPrice,
                                  productImageURL: product.image,
                                  isAddedToCart: product.isAddedToCart,
                                  isWishListed: product.isFavorite,
                                  onAddTap: () {
                                    // setState(() {
                                    product.isAddedToCart =
                                        !product.isAddedToCart;
                                    controller.update();
                                    // });
                                  },
                                  onWishlistTap: () {
                                    controller.toggleAddToFavorite(product.id);
                                    product.isFavorite = !product.isFavorite;
                                    controller.update();
                                    // });
                                  },
                                  discount: product.discount,
                                  discountType: product.discountValue.type,
                                  discountValue: product.discountValue.amount,
                                  storeName: product.store.name,
                                  isVerified: product.store.isVerified,
                                  productCondition:
                                      product.productConditionStatus,
                                ));
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
