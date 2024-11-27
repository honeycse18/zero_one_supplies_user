import 'package:ecomik/controller/seller_single_page_controller.dart';
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

class SellerSingleScreenPage extends StatelessWidget {
  const SellerSingleScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellerSingleScreenController>(
        init: SellerSingleScreenController(),
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
                            )),
                      ),
                      AppGaps.wGap20,
                    ], */
                    titleWidget: Text(
                      controller.theSeller.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor),
                    )),
                body: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                expandedHeight: 160,
                                flexibleSpace: FlexibleSpaceBar(
                                  collapseMode: CollapseMode.pin,
                                  background: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppGaps.hGap15,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                AppGaps.screenPaddingValue),
                                        child: /* Material(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Container(
                                            height: 118,
                                            padding: const EdgeInsets.all(18.0),
                                            child: Row(children: [
                                              SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: CachedNetworkImageWidget(
                                                    imageURL: controller
                                                        .theSeller.logo,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                            ),
                                                          ),
                                                        )),
                                              ),
                                              AppGaps.wGap10,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .theSeller.name,
                                                          style: AppTextStyles
                                                              .bodyLargeSemiboldTextStyle,
                                                        ),
                                                        if (controller.theSeller
                                                            .isVerified)
                                                          AppGaps.wGap8,
                                                        VerifiedSellerTickWidget(
                                                            isVerified:
                                                                controller
                                                                    .theSeller
                                                                    .isVerified),
                                                        controller.theSeller
                                                                .isVerified
                                                            ? AppGaps.wGap4
                                                            : AppGaps.wGap8,
                                                        SellerStatusBadgeWidget(
                                                            status: controller
                                                                .theSeller
                                                                .rating
                                                                .status)
                                                      ],
                                                    ),
                                                    AppGaps.hGap10,
                                                    Text(
                                                      controller.theSeller
                                                          .category.name,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: AppColors
                                                              .bodyTextColor),
                                                    ),
                                                    AppGaps.hGap10,
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppAssetImages
                                                              .starSVGLogoSolid,
                                                          color: AppColors
                                                              .secondaryColor,
                                                        ),
                                                        AppGaps.wGap3,
                                                        Text(
                                                          '(${controller.averageRating})',
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .bodyTextColor),
                                                        )
                                                      ],
                                                    ),
                                                    AppGaps.wGap4,
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  // SvgPicture.asset(AppAssetImages
                                                  //     .messageSVGLogoSolid),
                                                  TightIconButtonWidget(
                                                    child: SvgPicture.asset(
                                                        AppAssetImages
                                                            .arrowRightSVGLogoLine),
                                                    onTap: () {
                                                      Get.toNamed(
                                                          AppPageNames
                                                              .sellerShortReviewScreenPage,
                                                          arguments: controller
                                                              .theSeller);
                                                    },
                                                  )
                                                ],
                                              )
                                            ]),
                                          ),
                                        ) */
                                            StoreShortInfoWidget(
                                          imageURL: controller.theSeller.logo,
                                          storeName: controller.theSeller.name,
                                          isVerified:
                                              controller.theSeller.isVerified,
                                          status: controller
                                              .theSeller.rating.status,
                                          categoryName: controller
                                              .theSeller.category.name,
                                          averageRating: controller
                                              .theSeller.rating.avgRating,
                                          rightIconWidget:
                                              TightIconButtonWidget(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppPageNames
                                                      .sellerShortReviewScreenPage,
                                                  arguments:
                                                      controller.theSeller);
                                            },
                                            child: SvgPicture.asset(
                                                AppAssetImages
                                                    .arrowRightSVGLogoLine),
                                          ),
                                        ),
                                      ),
                                      AppGaps.hGap24,
                                    ],
                                  ),
                                ),
                              )
                            ],
                        body: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: const BorderRadius.only(
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
                                                  fontWeight: FontWeight.w500)),
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
                              CustomTightTextButtonWidget(
                                child: Row(
                                  children: [
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
                                        color: AppColors.primaryColor)
                                  ],
                                ),
                                onTap: () {
                                  Get.bottomSheet(
                                    SellerFilter(
                                        onChanged: (val) {
                                          controller.value = val;
                                          controller.update();
                                        },
                                        source: controller.options,
                                        value: controller.value),
                                    // context: context,
                                    backgroundColor:
                                        Colors.transparent.withOpacity(0.0),
                                    // isScrollControlled: true,
                                  );
                                },
                              ),
                            ]), */
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async => controller
                                    .productsOfSellerPagingController
                                    .refresh(),
                                child: PagedGridView(
                                  pagingController: controller
                                      .productsOfSellerPagingController,
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
                                              .noItemFoundInTheStoreTransKey
                                              .toCurrentLanguage,
                                          shortTitle: ''),
                                    ),
                                    itemBuilder: (context, item, index) {
                                      final product = item;
                                      return CustomGridSingleItemWidget(
                                        onTap: () {
                                          Get.toNamed(
                                              AppPageNames.productDetailsScreen,
                                              arguments: product.id);
                                        },
                                        child: ProductGridSingleItemWidget(
                                          title: product.name,
                                          // category: 'category',
                                          originalPrice: product.originalPrice,
                                          currentPrice: product.currentPrice,
                                          productImageURL: product.image,
                                          isAddedToCart: controller
                                              .isProductAddedToCart(product.id),
                                          isWishListed: product.isFavorite,
                                          onAddTap: () {
                                            // product.isAddedToCart =
                                            //     !product.isAddedToCart;
                                            // controller.update();
                                            controller.onProductAddTap(product);
                                          },
                                          onWishlistTap: () {
                                            controller.toggleAddToFavorite(
                                                product.id);
                                            product.isFavorite =
                                                !product.isFavorite;
                                            controller.update();
                                          },
                                          storeName: product.store.name,
                                          isVerified: product.store.isVerified,

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
                        ))),
              ),
            ));
  }

  /* ClipRRect sellerFilter(
      {required void Function(int) onChanged,
      required int value,
      required }) {
    return SellerFilter();
  } */
}

class StarWidget extends StatelessWidget {
  const StarWidget({
    super.key,
    required this.rating,
    // required this.review,
  });
  final double rating;

  // final StoreReviewsShortItem review;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => AppGaps.wGap2,
          itemCount: 5,
          itemBuilder: (context, index) => SvgPicture.asset(
            AppAssetImages.starSVGLogoSolid,
            color: rating >= (index + 1)
                ? AppColors.secondaryColor
                : AppColors.secondaryColor.withOpacity(0.5),
          ),
        ));
  }
}
