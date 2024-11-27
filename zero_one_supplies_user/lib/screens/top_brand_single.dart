import 'package:ecomik/controller/top_brand_controller.dart';
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
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopBrandSingle extends StatelessWidget {
  const TopBrandSingle({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopBrandScreenController>(
        init: TopBrandScreenController(),
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
                      titleWidget: Text(
                        controller.theBrand.name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkColor),
                      )),
                  body: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppGaps.screenPaddingValue),
                      child: NestedScrollView(
                          headerSliverBuilder: (context, innerBoxIsScrolled) =>
                              [
                                SliverAppBar(
                                  automaticallyImplyLeading: false,
                                  expandedHeight: 140,
                                  flexibleSpace: FlexibleSpaceBar(
                                    collapseMode: CollapseMode.pin,
                                    background: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          child: Container(
                                            height: 118,
                                            padding: const EdgeInsets.all(18.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 80,
                                                    width: 80,
                                                    child:
                                                        CachedNetworkImageWidget(
                                                            imageURL: controller
                                                                .theBrand.image,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18.0),
                                                                    color: Colors
                                                                        .transparent,
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                    ),
                                                                  ),
                                                                )),
                                                  ),
                                                  AppGaps.wGap12,
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .theBrand.name,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .darkColor),
                                                        ),
                                                        AppGaps.hGap4,
                                                        Expanded(
                                                          child: Text(
                                                            controller.theBrand
                                                                .description,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: AppColors
                                                                    .bodyTextColor),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                          body: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40))),
                            child: Column(children: [
                              AppGaps.hGap16,
                              /* Row(children: [
                                PopupMenuButton<int>(
                                    padding: const EdgeInsets.only(right: 5),
                                    position: PopupMenuPosition.under,
                                    // icon: const Icon(Icons.more_vert_rounded, color: AppColors.darkColor),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Sort By',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                        SvgPicture.asset(
                                            AppAssetImages.arrowDownSVGLogoLine,
                                            color: AppColors.primaryColor,
                                            height: 24,
                                            width: 24),
                                      ],
                                    ),
                                    itemBuilder: (context) => [
                                          const PopupMenuItem<int>(
                                            value: 0,
                                            child: Text(
                                              'Best Match',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const PopupMenuItem<int>(
                                            value: 1,
                                            child: Text(
                                              'Price: High - Low',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const PopupMenuItem<int>(
                                            value: 2,
                                            child: Text(
                                              'Price: Low - High',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ]),
                                const Spacer(),
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkColor),
                                ),
                                AppGaps.wGap10,
                                SvgPicture.asset(
                                  AppAssetImages.filterSVGLogoLine,
                                  color: AppColors.primaryColor,
                                )
                              ]), */
                              Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () async =>
                                      controller.refreshData(),
                                  child: PagedGridView(
                                    pagingController:
                                        controller.productsPagingController,
                                    padding: const EdgeInsets.only(bottom: 20),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing:
                                                AppGaps.screenPaddingValue,
                                            mainAxisSpacing:
                                                AppGaps.screenPaddingValue,
                                            mainAxisExtent: 287,
                                            crossAxisCount: 2,
                                            childAspectRatio: 1),
                                    builderDelegate:
                                        CoreWidgets.pagedChildBuilderDelegate<
                                            ProductShortItem>(
                                      noItemFoundIndicatorBuilder: (context) =>
                                          Center(
                                        child: EmptyScreenWidget(
                                            localImageAssetURL:
                                                AppAssetImages.emptyCart,
                                            title: AppLanguageTranslation
                                                .noItemFoundForThisBrandTransKey
                                                .toCurrentLanguage,
                                            shortTitle: ''),
                                      ),
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
                                            // category: 'category',
                                            originalPrice:
                                                product.originalPrice,
                                            currentPrice: product.currentPrice,
                                            productImageURL: product.image,
                                            isAddedToCart:
                                                controller.isProductAddedToCart(
                                                    product.id),
                                            isWishListed: product.isFavorite,
                                            onAddTap: () {
                                              controller
                                                  .onProductAddTap(product);
                                            },
                                            onWishlistTap: () {
                                              controller.toggleAddToFavorite(
                                                  product.id);
                                              product.isFavorite =
                                                  !product.isFavorite;
                                              controller.update();
                                            },
                                            storeName: product.store.name,
                                            isVerified:
                                                product.store.isVerified,

                                            productCondition:
                                                product.productConditionStatus,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          )))),
            ));
  }
}

//     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//     decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.7),
//         borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(30))),
//     child: CustomScrollView(slivers: [
//       const SliverToBoxAdapter(
//         child: AppGaps.hGap24,
//       ),
//       SliverToBoxAdapter(
//         child: Row(children: [
//           const Text(
//             'Sort By',
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.darkColor),
//           ),
//           AppGaps.wGap10,
//           SvgPicture.asset(AppAssetImages.arrowDownSVGLogoLine),
//           const Spacer(),
//           const Text(
//             'Filter',
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.darkColor),
//           ),
//           AppGaps.wGap10,
//           SvgPicture.asset(AppAssetImages.filterSVGLogoLine)
//         ]),
//       ),
//       const SliverToBoxAdapter(
//         child: AppGaps.hGap16,
//       ),
//       // SliverToBoxAdapter(
//       //   child: GridView.builder(
//       //       gridDelegate:
//       //           const SliverGridDelegateWithFixedCrossAxisCount(
//       //               crossAxisCount: 2),
//       //       itemBuilder: (context, index) {
//       //         return Text('Hello');
//       //       }),
//       // )
//     ]),
//   ),
// ),
