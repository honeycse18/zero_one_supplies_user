import 'package:ecomik/controller/home_navigator_screen_controller/wish_list_screen_controller.dart';
import 'package:ecomik/models/api_responses/wishlist_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/product_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListScreenController>(
        init: WishListScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: true,
                    titleWidget: Text(AppLanguageTranslation
                        .wishlistTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.wishlistPagingController.refresh(),
                    child: CustomScrollView(
                      slivers: [
                        /* <---- Top extra spaces ----> */
                        const SliverToBoxAdapter(child: AppGaps.hGap10),
                        /* <---- Search and filter button row ----> */
                        SliverToBoxAdapter(
                          child: Container(
                            height: 82,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* <---- Product Active Auctions tab button ----> */
                                Obx(
                                  () => Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CustomTabToggleButtonWidget(
                                            text: AppLanguageTranslation
                                                .productsTransKey
                                                .toCurrentLanguage,
                                            isSelected: !controller
                                                .isAuctionTabSelected.value,
                                            onTap: () {
                                              controller.isAuctionTabSelected
                                                  .value = false;
                                              controller
                                                  .wishlistPagingController
                                                  .refresh();
                                            },
                                            // })),
                                          ))),
                                ),
                                AppGaps.wGap5,
                                /* <---- Product Won Auctions tab button ----> */
                                Obx(() => Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CustomTabToggleButtonWidget(
                                            text: AppLanguageTranslation
                                                .auctionTransKey
                                                .toCurrentLanguage,
                                            isSelected: controller
                                                .isAuctionTabSelected.value,
                                            onTap: () {
                                              // setState(
                                              //   () {
                                              controller.isAuctionTabSelected
                                                  .value = true;
                                              controller
                                                  .wishlistPagingController
                                                  .refresh();
                                              // });
                                            }),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap24),
                        PagedSliverGrid(
                            pagingController:
                                controller.wishlistPagingController,
                            builderDelegate: CoreWidgets.pagedChildBuilderDelegate<
                                    WishlistDocResponse>(
                                itemBuilder: (context, item, index) {
                                  final WishlistDocResponse singleProduct =
                                      item;
                                  final WishlistProductResponse product =
                                      singleProduct.product;
                                  return CustomGridSingleItemWidget(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.productDetailsScreen,
                                          arguments: product.id);
                                    },
                                    backgroundColor: Colors.white,
                                    child: ProductGridSingleItemWidget(
                                      title: product.name,
                                      // shortDescription: product.shortDescription,
                                      currentPrice: product.currentPrice,
                                      originalPrice: product.originalPrice,
                                      discount: product.discount,
                                      discountType: product.discountValue.type,
                                      discountValue:
                                          product.discountValue.amount,

                                      productImageURL: product.image,
                                      // isAddedToCart: product.isAddedToCart,
                                      // isWishListed: product.isWishlisted,
                                      // onAddTap: () {
                                      //   product.isAddedToCart =
                                      //       !product.isAddedToCart;
                                      // },

                                      onWishlistTap: () {
                                        product.isFavorite =
                                            !product.isFavorite;
                                        controller
                                            .onWishListTap(singleProduct.id);
                                        controller.update();
                                      },
                                      isAddedToCart: false,
                                      storeName: product.store.name,
                                      isVerified: product.store.isVerified,
                                      productCondition:
                                          product.productConditionStatus,
                                    ),
                                  );
                                },
                                noItemFoundIndicatorBuilder: (context) =>
                                    /*  Center(
                                    child: Text('Favorite list is empty!'),
                                  ), */
                                    EmptyScreenWidget(
                                      localImageAssetURL:
                                          AppAssetImages.emptyWishList,
                                      shortTitle: AppLanguageTranslation
                                          .pleaseHitTheHeartTransKey
                                          .toCurrentLanguage,
                                      title: AppLanguageTranslation
                                          .favoriteListEmptyTransKey
                                          .toCurrentLanguage,
                                    )),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing:
                                        AppGaps.screenPaddingValue,
                                    mainAxisSpacing: AppGaps.screenPaddingValue,
                                    mainAxisExtent: 287,
                                    crossAxisCount: 2,
                                    childAspectRatio: 1))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
