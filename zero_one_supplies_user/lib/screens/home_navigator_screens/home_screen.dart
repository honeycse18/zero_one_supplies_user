import 'package:ecomik/controller/home_navigator_screen_controller/home_screen_controller.dart';
import 'package:ecomik/models/api_responses/dash_board_response.dart';
import 'package:ecomik/models/api_responses/home_auction_response.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/models/categories_rout_parameters/categories_rout_parameters.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/Auction_Loading_List_widget.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/loading_List_item_widget.dart';
import 'package:ecomik/widgets/product_item_loading_widget.dart';
import 'package:ecomik/widgets/screen_widgets/bid_screen_widget.dart';
import 'package:ecomik/widgets/screen_widgets/dashboardslider_widget.dart';
import 'package:ecomik/widgets/screen_widgets/product_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        global: false,
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                extendBody: true,
                /* <-------- Content --------> */
                body: SafeArea(
                  child: CustomScaffoldBodyWidget(
                    child: RefreshIndicator(
                      onRefresh: controller.onRefresh,
                      child: CustomScrollView(
                        slivers: [
                          /* <---- Top extra spaces ----> */
                          const SliverToBoxAdapter(child: AppGaps.hGap10),
                          /* <---- Search and filter button row ----> */
                          SliverToBoxAdapter(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /* <---- Search text field ----> */
                                Expanded(
                                    child: CustomTextFormField(
                                        isReadOnly: true,
                                        hasShadow: true,
                                        onTap: () {
                                          Get.toNamed(AppPageNames.productPage);
                                        },
                                        hintText: AppLanguageTranslation
                                            .searchItemTransKey
                                            .toCurrentLanguage,
                                        // controller: controller.sear,
                                        prefixIcon: CustomTightTextButtonWidget(
                                          child: SvgPicture.asset(
                                              AppAssetImages.searchSVGLogoLine,
                                              color: AppColors.primaryColor),
                                          onTap: () {
                                            Get.toNamed(
                                                AppPageNames.productPage);
                                          },
                                        ))),
                                AppGaps.wGap8,
                                /* <---- Filter icon button ----> */
                                // CustomTightTextButtonWidget(
                                //   child: DecoratedBox(
                                //     decoration: BoxDecoration(
                                //         borderRadius:
                                //             BorderRadius.circular(15.0),
                                //         gradient: LinearGradient(colors: [
                                //           AppColors.primaryColor,
                                //           AppColors.primaryColor
                                //               .withOpacity(0.4)
                                //         ])),
                                //     child: CustomIconButtonWidget(
                                //       fixedSize: const Size(60, 60),
                                //       hasShadow: true,
                                //       backgroundColor: Colors.transparent,
                                //       child: SvgPicture.asset(
                                //           AppAssetImages.filterSVGLogoLine,
                                //           color: Colors.white),
                                //       onTap: () {
                                //         Get.toNamed(AppPageNames.productPage);
                                //       },
                                //     ),
                                //   ),
                                // ),
                                AppGaps.wGap8,
                                if (Helper.isUserLoggedIn())
                                  CustomTightTextButtonWidget(
                                    child: CustomIconButtonWidget(
                                        fixedSize: const Size(60, 60),
                                        backgroundColor: Colors.white,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: SvgPicture.asset(
                                                AppAssetImages
                                                    .notificationSVGLogoLine,
                                                color: AppColors.darkColor,
                                              ),
                                            ),
                                            /* Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                height: 8,
                                                width: 8,
                                                decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle),
                                              )) */
                                          ],
                                        )),
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.notificationScreen,
                                          arguments: true);

                                      // setState(() {
                                      //   // Toggle light when tapped.
                                      //   _lightIsOn = !_lightIsOn;
                                      // }
                                      // );
                                    },
                                  )
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          if (controller.sliders.isNotEmpty)
                            SliverToBoxAdapter(
                              child: Obx(() => controller.isLoading.value
                                  ? const LoadingImageSliderWidget()
                                  : SizedBox(
                                      height: 200,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        children: [
                                          PageView.builder(
                                              controller:
                                                  controller.pageController,
                                              itemCount:
                                                  controller.sliders.length,
                                              itemBuilder: (context, index) {
                                                final DashboardSlider slider =
                                                    controller.sliders[index];
                                                return DashboardSliderWidget(
                                                  onTap: () => controller
                                                      .onDashboardSliderItemTap(
                                                          slider),
                                                  imageURL: slider.image,
                                                );
                                              }),
                                          Positioned(
                                            bottom: 10,
                                            // height: 1,
                                            child: SmoothPageIndicator(
                                              controller:
                                                  controller.pageController,
                                              count: controller.sliders.isEmpty
                                                  ? 1
                                                  : controller.sliders.length,
                                              axisDirection: Axis.horizontal,
                                              effect: ExpandingDotsEffect(
                                                  dotHeight: 8,
                                                  dotWidth: 8,
                                                  spacing: 2,
                                                  expansionFactor: 3,
                                                  activeDotColor:
                                                      AppColors.primaryColor,
                                                  dotColor: AppColors
                                                      .shadeColor1
                                                      .withOpacity(0.9)),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                            ),
                          const SliverToBoxAdapter(child: AppGaps.hGap16),
                          if (controller.coupons.isNotEmpty)
                            SliverToBoxAdapter(
                              child: Obx(() => controller.isLoading.value
                                  ? const LoadingImageSliderWidget()
                                  : SizedBox(
                                      height: 128,
                                      child: PageView.builder(
                                        controller:
                                            controller.couponPageController,
                                        itemCount: controller.coupons.length,
                                        itemBuilder: (context, index) {
                                          final coupon =
                                              controller.coupons[index];
                                          return CustomTightTextButtonWidget(
                                            onTap: () => controller
                                                .copyToClipBoard(coupon.code),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 28.0),
                                                  child: Container(
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/cuponCode.png'),
                                                            fit: BoxFit.cover),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Row(
                                                      children: [
                                                        AppGaps.wGap75,
                                                        AppGaps.wGap5,
                                                        Expanded(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Center(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        coupon.discountType ==
                                                                                'percentage'
                                                                            ? '${AppLanguageTranslation.upToTransKey.toCurrentLanguage} ${coupon.value.toInt()}% ${AppLanguageTranslation.offTransKey.toCurrentLanguage}'
                                                                            : '${AppLanguageTranslation.upToTransKey.toCurrentLanguage} ${Helper.getCurrencyFormattedAmountText(coupon.value)} ${AppLanguageTranslation.offTransKey.toCurrentLanguage}',
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: AppColors.secondaryColor),
                                                                      ),
                                                                      AppGaps
                                                                          .hGap7,
                                                                      Text(
                                                                          AppLanguageTranslation
                                                                              .collectCouponFirstTransKey
                                                                              .toCurrentLanguage,
                                                                          style: const TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: AppColors.darkColor)),
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          BidCountdownTimerWidget(
                                                                              bidEndDateTime: coupon.endDate,
                                                                              builder: (controller) => timeUnit(controller.remainingDaysText, AppLanguageTranslation.daysTransKey.toCurrentLanguage)),
                                                                          AppGaps
                                                                              .wGap8,
                                                                          BidCountdownTimerWidget(
                                                                              bidEndDateTime: coupon.endDate,
                                                                              builder: (controller) => timeUnit(controller.remainingHoursText, AppLanguageTranslation.hoursTransKey.toCurrentLanguage)),
                                                                          AppGaps
                                                                              .wGap8,
                                                                          BidCountdownTimerWidget(
                                                                              bidEndDateTime: coupon.endDate,
                                                                              builder: (controller) => timeUnit(controller.remainingMinutesText, AppLanguageTranslation.minutesTransKey.toCurrentLanguage)),
                                                                          AppGaps
                                                                              .wGap8,
                                                                          BidCountdownTimerWidget(
                                                                              bidEndDateTime: coupon.endDate,
                                                                              builder: (controller) => timeUnit(controller.remainingSecondsText, AppLanguageTranslation.secondsTransKey.toCurrentLanguage)),
                                                                          // timeUnit('52', 'Days'),
                                                                          // timeUnit('42', 'Hours'),
                                                                          // timeUnit('52', 'Minute'),
                                                                          // timeUnit('12', 'Seconds'),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    left: 0,
                                                    bottom: 0,
                                                    child: SizedBox(
                                                      width: 75,
                                                      child:
                                                          CachedNetworkImageWidget(
                                                              imageURL:
                                                                  coupon.image),
                                                    )
                                                    // Image.asset(
                                                    //     AppAssetImages.surprisedWoman)
                                                    )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                            ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Row(children: [
                              Text(
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.auctionProductTransKey),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkColor),
                              ),
                              const Spacer(),
                              CustomTightTextButtonWidget(
                                child: Text(
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.viewAllTransKey),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryColor),
                                ),
                                onTap: () {
                                  Get.toNamed(AppPageNames.auctionPage);
                                },
                              )
                            ]),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          Obx(() => SliverToBoxAdapter(
                                child: controller.isLoading.value
                                    ? const AuctionLoadingListWidget()
                                    : SizedBox(
                                        height: 298,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              controller.auctionList.length > 5
                                                  ? 5
                                                  : controller
                                                      .auctionList.length,
                                          separatorBuilder: (context, index) =>
                                              AppGaps.wGap16,
                                          itemBuilder: (context, index) {
                                            final HomeAuctionShortItem bid =
                                                controller.auctionList[index];
                                            return SizedBox(
                                              // height: 275,
                                              width: 175,
                                              child: BidWidget(
                                                onTap: () =>
                                                    controller.onBidTap(bid),
                                                name: bid.product.name,
                                                categoryName: bid.product.name,
                                                price: Helper
                                                    .getCurrencyFormattedAmountText(
                                                        bid.currentPrice),
                                                categoryImageUrl:
                                                    bid.product.image,
                                                isWishListed: bid.isWishListed,
                                                startDateTime: bid.startDate,
                                                endDateTime: bid.endDate,
                                                onWishListTap: () => controller
                                                    .onBidFavoriteButtonTap(
                                                        bid),
                                                storeName:
                                                    bid.product.store.name,
                                                isVerified: bid
                                                    .product.store.isVerified,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              )),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Row(children: [
                              Text(
                                // 'Popular Categories',
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.popularCategoriesTransKey),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkColor),
                              ),
                              const Spacer(),
                              CustomTightTextButtonWidget(
                                child: Text(
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.viewAllTransKey),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryColor),
                                ),
                                onTap: () {
                                  CategoriesRoutParameters parameter =
                                      CategoriesRoutParameters(
                                          hasBackButton: true);
                                  Get.toNamed(AppPageNames.categoryScreen,
                                      arguments: parameter);
                                },
                              )
                            ]),
                          ),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap16,
                          ),
                          Obx(() => SliverToBoxAdapter(
                              child: controller.isLoading.value
                                  ? const PopularCategoriesLoadingWidget()
                                  : SizedBox(
                                      height: 110,
                                      child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: ((context, index) {
                                            final Category category =
                                                controller.categories[index];
                                            return CategoryWidget(
                                              onTap: () {
                                                CategoriesRoutParameters
                                                    params =
                                                    CategoriesRoutParameters(
                                                        categoryId: category.id,
                                                        hasBackButton: true);
                                                Get.toNamed(
                                                    AppPageNames.categoryScreen,
                                                    arguments: params);
                                              },
                                              imageUrl: category.image,
                                              text: category.name,
                                              color: category.color,
                                            );
                                          }),
                                          separatorBuilder: (context, index) =>
                                              AppGaps.wGap10,
                                          itemCount:
                                              controller.categories.length),
                                    ))),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Row(children: [
                              Text(
                                AppLanguageTranslation
                                    .flaTransKey.toCurrentLanguage,
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
                                        image: Image.asset(
                                                AppAssetImages.flashIcon)
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
                              const Spacer(),
                              CustomTightTextButtonWidget(
                                child: Text(
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.viewAllTransKey),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryColor),
                                ),
                                onTap: () {
                                  Get.toNamed(AppPageNames.flashSellScreen);
                                },
                              )
                            ]),
                          ),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap10,
                          ),
                          Obx(() => SliverToBoxAdapter(
                                child: controller.isLoading.value
                                    ? const ProductItemLoadingWidget()
                                    : SizedBox(
                                        height: 287,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              /// Per product data
                                              final FlashSell product =
                                                  controller.flashSell[index];
                                              /* <---- Wishlist item widget ----> */
                                              return CustomGridSingleItemWidget(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppPageNames
                                                          .productDetailsScreen,
                                                      arguments: product.id);
                                                },
                                                backgroundColor: Colors.white,
                                                child: SizedBox(
                                                  width: 175,
                                                  child:
                                                      ProductGridSingleItemWidget(
                                                    title: product.name,
                                                    category: '',
                                                    originalPrice:
                                                        product.originalPrice,
                                                    currentPrice:
                                                        product.currentPrice,
                                                    productImageURL:
                                                        product.image,
                                                    isAddedToCart: controller
                                                        .isProductAddedToCart(
                                                            product.id),
                                                    onAddTap: () {
                                                      controller
                                                          .onFlashSellProductAddTap(
                                                              product);
                                                    },
                                                    isWishListed:
                                                        product.isWishListed,
                                                    onWishlistTap: () {
                                                      controller
                                                          .toggleAddToFavorite(
                                                              product.id);
                                                      controller
                                                          .onFlashProductWishListTap(
                                                              product);
                                                    },
                                                    discount: product.discount,
                                                    discountType: product
                                                        .discountValue.type,
                                                    discountValue: product
                                                        .discountValue.amount,
                                                    storeName:
                                                        product.store.name,
                                                    isVerified: product
                                                        .store.isVerified,
                                                    productCondition: product
                                                        .productConditionStatus,
                                                    // onWishlistTap:
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.wGap16,
                                            itemCount:
                                                controller.flashSell.length),
                                      ),
                              )),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Text(
                                  // 'Ending Soon',
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.endingSoonTransKey),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkColor),
                                ),
                                const Spacer(),
                                CustomTightTextButtonWidget(
                                  child: Text(
                                    LanguageHelper.currentLanguageText(
                                        LanguageHelper.viewAllTransKey),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.primaryColor),
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames.endingSoonScreen);
                                  },
                                )
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          Obx(() => SliverToBoxAdapter(
                                child: controller.isLoading.value
                                    ? const AuctionLoadingListWidget()
                                    : SizedBox(
                                        height: 295,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              controller.endAuctionList.length >
                                                      5
                                                  ? 5
                                                  : controller
                                                      .endAuctionList.length,
                                          separatorBuilder: (context, index) =>
                                              AppGaps.wGap16,
                                          itemBuilder: (context, index) {
                                            final HomeAuctionShortItem bid =
                                                controller
                                                    .endAuctionList[index];
                                            return CustomTightTextButtonWidget(
                                              child: SizedBox(
                                                // height: 275,
                                                width: 159,
                                                child: BidWidget(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        AppPageNames.bidDetails,
                                                        arguments: bid.id);
                                                  },
                                                  name: bid.product.name,
                                                  categoryName:
                                                      bid.product.name,
                                                  price: Helper
                                                      .getCurrencyFormattedAmountText(
                                                          bid.currentPrice),
                                                  startDateTime: bid.startDate,
                                                  endDateTime: bid.endDate,
                                                  categoryImageUrl:
                                                      bid.product.image,
                                                  isWishListed:
                                                      bid.isWishListed,
                                                  onWishListTap: () => controller
                                                      .onBidFavoriteButtonTap(
                                                          bid),
                                                  /* () {.
                                                    controller
                                                        .toggleAddToFavorite(
                                                            bid.id, true);
                                                    controller
                                                        .onAuctionProductWishListTap(
                                                            bid);
                                                  }, */
                                                  storeName:
                                                      bid.product.store.name,
                                                  isVerified: bid
                                                      .product.store.isVerified,
                                                ),
                                              ),
                                              onTap: () {
                                                Get.toNamed(AppPageNames
                                                    .endingSoonScreen);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                              )),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap16,
                          ),
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Text(
                                  // 'Top Brands',
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.topBrandsTransKey),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkColor),
                                ),
                                const Spacer(),
                                CustomTightTextButtonWidget(
                                  child: Text(
                                    LanguageHelper.currentLanguageText(
                                        LanguageHelper.viewAllTransKey),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.primaryColor),
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppPageNames.topBrandsPage);
                                  },
                                )
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          Obx(() => SliverToBoxAdapter(
                              child: controller.isLoading.value
                                  ? const TopBrandLoadingListWidget()
                                  : SizedBox(
                                      height: 110,
                                      child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final TopBrand brand =
                                                controller.topBrands[index];
                                            return GestureDetector(
                                              child: SizedBox(
                                                  width: 110,
                                                  height: 110,
                                                  child: Center(
                                                    child:
                                                        CachedNetworkImageWidget(
                                                            imageURL:
                                                                brand.image,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18.0),
                                                                    color: Colors
                                                                        .white,
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                    ),
                                                                  ),
                                                                )),
                                                  )),
                                              onTap: () {
                                                Get.toNamed(
                                                    AppPageNames.topBrandSingle,
                                                    arguments: brand.id);
                                              },
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              AppGaps.wGap16,
                                          itemCount:
                                              controller.topBrands.length)))),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Row(children: [
                              Text(
                                // 'Popular Product',
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.popularProductTransKey),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkColor),
                              ),
                              const Spacer(),
                              CustomTightTextButtonWidget(
                                child: Text(
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.viewAllTransKey),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryColor),
                                ),
                                onTap: () {
                                  Get.toNamed(AppPageNames.productPage);
                                },
                              )
                            ]),
                          ),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap10,
                          ),
                          Obx(() => SliverToBoxAdapter(
                                child: controller.isLoading.value
                                    ? const ProductItemLoadingWidget()
                                    : SizedBox(
                                        height: 287,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              /// Per product data
                                              final PopularProduct product =
                                                  controller
                                                      .popularProducts[index];
                                              /* <---- Wishlist item widget ----> */
                                              return CustomGridSingleItemWidget(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppPageNames
                                                          .productDetailsScreen,
                                                      arguments: product.id);
                                                },
                                                backgroundColor: Colors.white,
                                                child: SizedBox(
                                                  width: 175,
                                                  child:
                                                      ProductGridSingleItemWidget(
                                                    title: product.name,
                                                    // shortDescription:
                                                    //     product.shortDescription,
                                                    currentPrice:
                                                        product.currentPrice,
                                                    originalPrice:
                                                        product.originalPrice,
                                                    productImageURL:
                                                        product.image,
                                                    isAddedToCart: controller
                                                        .isProductAddedToCart(
                                                            product.id),
                                                    onAddTap: () => controller
                                                        .onPopularProductAddTap(
                                                            product),
                                                    isWishListed:
                                                        product.isWishListed,
                                                    onWishlistTap: () {
                                                      controller
                                                          .toggleAddToFavorite(
                                                              product.id);
                                                      controller
                                                          .onPopularProductWishListTap(
                                                              product);
                                                    },
                                                    discount: product.discount,
                                                    discountType: product
                                                        .discountValue.type,
                                                    discountValue: product
                                                        .discountValue.amount,
                                                    storeName:
                                                        product.store.name,
                                                    isVerified: product
                                                        .store.isVerified,
                                                    productCondition: product
                                                        .productConditionStatus,
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.wGap16,
                                            itemCount: controller
                                                .popularProducts.length),
                                      ),
                              )),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Row(children: [
                              Text(
                                // 'Top Seller',
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.topSellerTransKey),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkColor),
                              ),
                              const Spacer(),
                              GestureDetector(
                                child: Text(
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.viewAllTransKey),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryColor),
                                ),
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.topSellersScreenPage);
                                },
                              )
                            ]),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap10),
                          Obx(() => SliverToBoxAdapter(
                                child: controller.isLoading.value
                                    ? const TopSellerLoadingListWidget()
                                    : SizedBox(
                                        height: 242,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final TopSeller seller =
                                                  controller.topSeller[index];
                                              return SizedBox(
                                                width: 175,
                                                child: TopSellerWidget(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        AppPageNames
                                                            .sellerSingleScreenPage,
                                                        arguments: seller.id);
                                                  },
                                                  name: seller.name,
                                                  status: seller
                                                      .sellerRating.status,
                                                  showStatus: false,
                                                  isVerified: seller.isVerified,
                                                  imageUrl: seller.logo,
                                                  category: seller.category,
                                                  itemCount: seller.products,
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.wGap16,
                                            itemCount:
                                                controller.topSeller.length)),
                              )),
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Row(children: [
                              Text(
                                // 'All Products',
                                AppLanguageTranslation
                                    .allProductsTransKey.toCurrentLanguage,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkColor),
                              ),
                              const Spacer(),
                              CustomTightTextButtonWidget(
                                child: Text(
                                  LanguageHelper.currentLanguageText(
                                      LanguageHelper.viewAllTransKey),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryColor),
                                ),
                                onTap: () {
                                  Get.toNamed(AppPageNames.productPage);
                                },
                              )
                            ]),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap16),
                          /* <---- Product categories grid list ----> */
                          //============================================
                          PagedSliverGrid(
                              pagingController:
                                  controller.productPagingController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing:
                                          AppGaps.screenPaddingValue,
                                      mainAxisSpacing:
                                          AppGaps.screenPaddingValue,
                                      mainAxisExtent: 287,
                                      crossAxisCount: 2,
                                      childAspectRatio: 1),
                              builderDelegate: CoreWidgets
                                  .pagedChildBuilderDelegate<ProductShortItem>(
                                      noItemFoundIndicatorBuilder: (context) =>
                                          Center(
                                            child: Text(
                                              LanguageHelper
                                                  .currentLanguageText(
                                                      LanguageHelper
                                                          .noItemFoundTransKey),
                                            ),
                                          ),
                                      itemBuilder: (context, item, index) {
                                        /// Per Category data
                                        final ProductShortItem popularProduct =
                                            item;
                                        /* <---- Product category item widget ----> */
                                        return CustomGridSingleItemWidget(
                                          onTap: () {
                                            Get.toNamed(
                                                AppPageNames
                                                    .productDetailsScreen,
                                                arguments: popularProduct.id);
                                          },
                                          child: ProductGridSingleItemWidget(
                                            title: popularProduct.name,
                                            originalPrice:
                                                popularProduct.originalPrice,
                                            currentPrice:
                                                popularProduct.currentPrice,
                                            productImageURL:
                                                popularProduct.image,
                                            isAddedToCart:
                                                controller.isProductAddedToCart(
                                                    popularProduct.id),
                                            onAddTap: () =>
                                                controller.onProductAddTap(
                                                    popularProduct),
                                            isWishListed:
                                                popularProduct.isFavorite,
                                            onWishlistTap: () {
                                              popularProduct.isFavorite =
                                                  !popularProduct.isFavorite;
                                              controller.toggleAddToFavorite(
                                                  popularProduct.id);
                                              controller.update();
                                            },
                                            discount: popularProduct.discount,
                                            discountType: popularProduct
                                                .discountValue.type,
                                            discountValue: popularProduct
                                                .discountValue.amount,
                                            storeName:
                                                popularProduct.store.name,
                                            isVerified:
                                                popularProduct.store.isVerified,
                                            productCondition: popularProduct
                                                .productConditionStatus,
                                          ),
                                        );
                                      })),

                          const SliverToBoxAdapter(child: AppGaps.hGap8),

                          /* <---- Bottom extra spaces ----> */
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget popularCategories(String imageUrl, String text, Color color) {
    return const CategoryWidget();
  }

  Widget timeUnit(String time, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                border: Border.all(width: 1.4, color: Colors.white),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white.withOpacity(0.5)),
            child: Center(
                child: Text(
              time,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkColor),
            )),
          ),
          AppGaps.hGap5,
          Text(
            type,
            style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: AppColors.bodyTextColor),
          )
        ],
      ),
    );
  }
}

class TopSellerLoadingListWidget extends StatelessWidget {
  const TopSellerLoadingListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 248,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (context, index) => AppGaps.wGap16,
        itemBuilder: (context, index) {
          return const SizedBox(
            // height: 275,
            width: 175,
            child: TopSellerLoadingWidget(),
          );
        },
      ),
    );
  }
}

class TopBrandLoadingListWidget extends StatelessWidget {
  const TopBrandLoadingListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (context, index) => AppGaps.wGap16,
        itemBuilder: (context, index) {
          return const SizedBox(
            // height: 275,
            width: 110,
            child: TopBrandLoadingWidget(),
          );
        },
      ),
    );
  }
}

class PopularCategoriesLoadingWidget extends StatelessWidget {
  const PopularCategoriesLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        separatorBuilder: (context, index) => AppGaps.wGap16,
        itemBuilder: (context, index) {
          return const SizedBox(
            // height: 275,
            width: 110,
            child: PopularCategoryLoadingWidget(),
          );
        },
      ),
    );
  }
}

class TopSellerWidget extends StatelessWidget {
  final String name;
  final String category;
  final String imageUrl;
  final int itemCount;
  final SellerStatus status;
  final bool showStatus;
  final bool isVerified;
  final void Function()? onTap;

  const TopSellerWidget({
    super.key,
    this.name = '',
    this.category = '',
    this.imageUrl = '',
    this.itemCount = 0,
    this.onTap,
    this.showStatus = true,
    this.isVerified = false,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
      borderRadiusRadiusValue: const Radius.circular(10.0),
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 139,
                child: CachedNetworkImageWidget(
                  imageURL: imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: AppComponents.imageBorderRadius,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                  /* imageBuilder: (context, imageProvider)=>(
          
              ), */
                ),
              ),
              AppGaps.hGap8,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ),
                  if (isVerified) AppGaps.wGap6,
                  VerifiedSellerTickWidget(isVerified: isVerified),
                  if (showStatus) AppGaps.wGap6,
                  if (showStatus) SellerStatusBadgeWidget(status: status),
                ],
              ),
              AppGaps.hGap2,
              Center(
                child: Text(
                  category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: AppColors.bodyTextColor),
                ),
              ),
              AppGaps.hGap8,
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  decoration: BoxDecoration(
                      color: AppColors.shadeColor1,
                      borderRadius: AppComponents.borderRadius(6)),
                  child: Text(
                    '$itemCount ${AppLanguageTranslation.itemsTransKey.toCurrentLanguage}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.bodyTextColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/* class SellerStatusBadgeWidget extends StatelessWidget {
  final SellerStatus status;
  const SellerStatusBadgeWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case SellerStatus.best:
        return SvgPicture.asset(AppAssetImages.medalSVGLogo,
            height: 24, width: 24);
      case SellerStatus.top:
        return SvgPicture.asset(AppAssetImages.oneBadgeSVGLogo,
            height: 24, width: 24);
      case SellerStatus.newSeller:
        return SvgPicture.asset(AppAssetImages.newTextSVGLogo,
            height: 24, width: 24);
      case SellerStatus.unknown:
        return AppGaps.emptyGap;
      default:
        return AppGaps.emptyGap;
    }
  }
} */

class CategoryWidget extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String color;
  final void Function()? onTap;

  const CategoryWidget({
    super.key,
    this.imageUrl = '',
    this.onTap,
    this.text = '',
    this.color = '',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
            color:
                Helper.getColorFromHexCode(color, defaultColor: Colors.white),
            borderRadius: BorderRadius.circular(18.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(children: [
            SizedBox(
              height: 40,
              width: 40,
              child: CachedNetworkImageWidget(
                imageURL: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.imageBorderRadius,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.contain)),
                ),
              ),
            ),
            Text(
              text,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.darkColor),
            )

            /* Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                     Container(
                            height: 40,
                            decoration: BoxDecoration(
                                image:
                                    DecorationImage(image: Image.asset(imageUrl).image)),
                          ),
                    AppGaps.hGap10,
                    Text(
                      text,
                      style: TextStyle(color: color),
                    )
                  ],
                ),
              ),
            ), */
          ]),
        ),
      ),
    );
  }
}

class LoadingImageSliderWidget extends StatelessWidget {
  const LoadingImageSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
              controller: controller,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const LoadingPlaceholderWidget(
                    child: LoadingBoxWidget());
              }),
          Positioned(
            bottom: 10,
            // height: 1,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 2,
                  expansionFactor: 3,
                  activeDotColor: AppColors.primaryColor,
                  dotColor: AppColors.shadeColor1.withOpacity(0.9)),
            ),
          )
        ],
      ),
    );
  }
}
