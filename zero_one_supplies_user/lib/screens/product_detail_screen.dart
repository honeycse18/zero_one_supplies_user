import 'dart:developer';

import 'package:dartx/dartx.dart';
import 'package:ecomik/controller/product_details_controller.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/local_models/selected_product_attribute.dart';
import 'package:ecomik/models/screen_parameters/send_offer_screen_parameter.dart';
import 'package:ecomik/screens/bottom_sheets/make_an_offer_bottom_sheet.dart';
import 'package:ecomik/screens/bottom_sheets/product_coupon.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/double.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/bottom_modal_sheets_widget/product_specification_widget.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/bid_details_screen_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/product_details_screen_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/product_screen_widgets.dart';
import 'package:ecomik/widgets/star_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<ProductDetailsController>(
        global: false,
        init: ProductDetailsController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: Image.asset(AppAssetImages.backgroundFullPng).image,
                    fit: BoxFit.fill,
                  )),
              child: SafeArea(
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  /* <-------- Appbar --------> */
                  appBar: CoreWidgets.appBarWidget(screenContext: context),
                  /* <-------- Content --------> */
                  body: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                            /* <---- Product images carousel ----> */
                            SliverAppBar(
                                automaticallyImplyLeading: false,
                                expandedHeight:
                                    screenSize.height < 550 ? 310 : 390,
                                flexibleSpace: FlexibleSpaceBar(
                                  collapseMode: CollapseMode.pin,
                                  background: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      /* <---- Product images carousel widget ----> */
                                      SizedBox(
                                        height:
                                            screenSize.height < 550 ? 300 : 380,
                                        child: PageView.builder(
                                          itemCount:
                                              controller.galleryImages.length,
                                          controller: controller
                                              .productImagePageController,
                                          itemBuilder: (context, index) {
                                            final imageUrl =
                                                controller.galleryImages[index];
                                            return GestureDetector(
                                              onTap: () => Get.toNamed(
                                                  AppPageNames.imageScreen,
                                                  arguments:
                                                      controller.galleryImages),
                                              child: CachedNetworkImageWidget(
                                                imageURL: imageUrl,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image:
                                                              imageProvider)),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      AppGaps.hGap24,
                                      /* <---- Products carousel indicator widget ----> */
                                      Center(
                                        child: SmoothPageIndicator(
                                            controller: controller
                                                .productImagePageController,
                                            count:
                                                controller.galleryImages.isEmpty
                                                    ? 1
                                                    : controller
                                                        .galleryImages.length,
                                            effect: ScrollingDotsEffect(
                                                dotHeight: 10,
                                                dotWidth: 10,
                                                spacing: 8,
                                                dotColor: AppColors.darkColor
                                                    .withOpacity(0.15),
                                                activeDotColor:
                                                    AppColors.primaryColor)),
                                      ),
                                      AppGaps.hGap24,
                                    ],
                                  ),
                                ))
                          ],
                      /* <---- Remaining content ----> */
                      body: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30))),
                        child: CustomScrollView(slivers: [
                          // Top extra spaces
                          const SliverToBoxAdapter(child: AppGaps.hGap24),
                          SliverToBoxAdapter(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* <---- Product name ----> */
                                Text(controller.productDetails.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                                AppGaps.hGap8,
                                /* <---- Product name, rating stars, cart count ----> */
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    /* <---- Product rating ----> */
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        /* <---- Product rating stars widget ----> */
                                        StarWidget(
                                            review: controller
                                                .productDetails.rating),
                                        AppGaps.wGap4,
                                        /* <---- Product rating number text ----> */
                                        Text(
                                            '(${controller.productDetails.rating})',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color:
                                                      AppColors.bodyTextColor,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                      ],
                                    ),
                                    /* <---- Product cart add or remove buttons with 
                                     counter text ----> */
                                    PlusMinusCounterRow(
                                        counterText:
                                            '${controller.productDetails.productCount}',
                                        onRemoveTap:
                                            controller.onMinusButtonTap,
                                        onAddTap: controller.onPlusButtonTap),
                                  ],
                                ),
                                AppGaps.hGap15,

                                /* <---- Product price ----> */
                                Row(
                                  children: [
                                    Text(
                                      Helper.getCurrencyFormattedAmountText(
                                          controller.productPrice),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(fontSize: 16),
                                    ),
                                    AppGaps.wGap5,
                                    AppGaps.wGap8,
                                    if (controller.productDetails.discount)
                                      Text(
                                        Helper.getCurrencyFormattedAmountText(
                                            controller
                                                .productDetails.originalPrice),
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.red),
                                      ),
                                    AppGaps.wGap8,
                                  ],
                                ),
                                AppGaps.hGap24,
                              ],
                            ),
                          ),
                          if (controller
                              .productDetails.quantityBasedPrices.isNotEmpty)
                            const SliverToBoxAdapter(child: AppGaps.hGap10),
                          if (controller
                              .productDetails.quantityBasedPrices.isNotEmpty)
                            SliverToBoxAdapter(
                                child: SizedBox(
                              height: 60,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final quantityBasedPrice = controller
                                        .productDetails
                                        .quantityBasedPrices[index];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            quantityBasedPrice
                                                .price.toCurrencyAmountText,
                                            style: AppTextStyles
                                                .titleBoldTextStyle),
                                        AppGaps.hGap8,
                                        Text(
                                            '${quantityBasedPrice.minimum} - ${quantityBasedPrice.maximum} pieces',
                                            style: AppTextStyles
                                                .bodyMediumTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .bodyTextColor)),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      AppGaps.wGap30,
                                  itemCount: controller.productDetails
                                      .quantityBasedPrices.length),
                            )),

                          if (controller.productDetails.coupons.isNotEmpty)
                            const SliverToBoxAdapter(child: AppGaps.hGap12),
                          if (controller.productDetails.coupons.isNotEmpty)
                            SliverToBoxAdapter(
                              child: CustomStretchedOutlinedButtonWidget(
                                child: Text(AppLanguageTranslation
                                    .getCouponTransKey.toCurrentLanguage),
                                onTap: () {
                                  Get.bottomSheet(
                                      const ProductCouponBottomSheet(),
                                      backgroundColor:
                                          AppColors.backgroundColor,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: AppComponents
                                              .bottomSheetBorderRadius),
                                      settings: RouteSettings(
                                          arguments: controller
                                              .productDetails.coupons));
                                },
                              ),
                            ),
                          const SliverToBoxAdapter(child: AppGaps.hGap12),
                          SliverToBoxAdapter(
                              child: Text(
                            // 'Color',
                            AppLanguageTranslation
                                .colorTransKey.toCurrentLanguage,
                            style: AppTextStyles.productDetailsLabel,
                          )),
                          const SliverToBoxAdapter(child: AppGaps.hGap11),
                          SliverList.separated(
                              itemBuilder: (context, index) {
                                final productAttribute =
                                    controller.productDetails.attribute[index];
                                return ProductAttributeWidget(
                                  productAttribute: productAttribute,
                                  selectedOption:
                                      productAttribute.selectedOption,
                                  onOptionSelected: controller
                                      .onProductAttributeOptionSelected,
                                  onDeleteTap: () async {
                                    productAttribute.isLoading = true;
                                    controller.update();
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    if (productAttribute.selectedOption !=
                                        null) {
                                      final isRemoved = controller
                                          .selectedProductAttributes
                                          .remove(SelectedProductAttribute(
                                              key: productAttribute.key,
                                              option: productAttribute
                                                  .selectedOption!));
                                      log(isRemoved.toString());
                                    }
                                    productAttribute.selectedOption = null;
                                    productAttribute.isLoading = false;
                                    controller.update();
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap11,
                              itemCount:
                                  controller.productDetails.attribute.length),

                          const SliverToBoxAdapter(child: AppGaps.hGap10),

                          SliverToBoxAdapter(
                              child: Text(
                            // 'Product Description',
                            LanguageHelper.currentLanguageText(
                                LanguageHelper.productDescriptionTransKey),
                            style: AppTextStyles.productDetailsLabel,
                          )),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap11,
                          ),
                          SliverToBoxAdapter(
                            child: HtmlWidget(
                                controller.productDetails.description.short),
                          ),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap11,
                          ),

                          SliverToBoxAdapter(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => HtmlWidget(!controller
                                        .isReadMoreSelected.value
                                    ? controller.productDetails.description.long
                                                .length >
                                            385
                                        ? controller
                                            .productDetails.description.long
                                            .substring(0, 385)
                                        : controller
                                            .productDetails.description.long
                                    : controller
                                        .productDetails.description.long)),
                                Obx(() => TightTextButtonWidget(
                                    child: Text(
                                        controller.isReadMoreSelected.value
                                            ? AppLanguageTranslation
                                                .readLessTransKey
                                                .toCurrentLanguage
                                            : AppLanguageTranslation
                                                .readMoreTransKey
                                                .toCurrentLanguage,
                                        style: AppTextStyles.bodySmallTextStyle
                                            .copyWith(
                                                color: AppColors.primaryColor)),
                                    onTap: () {
                                      controller.isReadMoreSelected.value =
                                          !controller.isReadMoreSelected.value;
                                    })),
                                AppGaps.hGap32,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        LanguageHelper.currentLanguageText(
                                            LanguageHelper
                                                .specificationTransKey),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.darkColor)),
                                    GestureDetector(
                                      child: SvgPicture.asset(
                                          AppAssetImages.arrowRightSVGLogoLine),
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent
                                              .withOpacity(0.0),
                                          builder: (BuildContext context) {
                                            return SpecificationFilter(
                                              specifications: controller
                                                  .specifications
                                                  .map((e) =>
                                                      Pair(e.key, e.value))
                                                  .toList(),
                                            );
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                                if (controller
                                    .productDetails.specifications.isNotEmpty)
                                  AppGaps.hGap15,
                                if (controller
                                    .productDetails.specifications.isNotEmpty)
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        itemBuilder: (context, index) {
                                          final specification = controller
                                              .productDetails
                                              .specifications[index];
                                          return SpecificationWidget(
                                              title: specification.key,
                                              content: specification.value);
                                        },
                                        separatorBuilder: (context, index) =>
                                            AppGaps.wGap24,
                                        itemCount: controller.productDetails
                                            .specifications.length),
                                  ),
                                AppGaps.hGap15,
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap20,
                          ),
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Text(
                                  '${LanguageHelper.currentLanguageText(LanguageHelper.reviewsTransKey)}(${controller.productDetails.totalReview})',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /* <---- Product rating stars widget ----> */
                                    SvgPicture.asset(
                                      AppAssetImages.starSVGLogoSolid,
                                      color: AppColors.secondaryColor,
                                    ),
                                    AppGaps.wGap4,
                                    /* <---- Product rating number text ----> */
                                    Text(
                                        '(${controller.productDetails.rating})',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.bodyTextColor,
                                              fontWeight: FontWeight.w600,
                                            )),
                                  ],
                                ),
                                AppGaps.wGap5,
                                TightIconButtonWidget(
                                  child: SvgPicture.asset(
                                      AppAssetImages.arrowRightSVGLogoLine),
                                  onTap: () {
                                    Get.toNamed(
                                        AppPageNames.singleProductReviewsScreen,
                                        arguments: controller.productDetails);
                                  },
                                )
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap11,
                          ),
                          /* SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              /// Single review
                              final review = FakeData.reviews[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 32),
                                child: ReviewDetailsWidget(review: review),
                              );
                            }, childCount: FakeData.reviews.length),
                          ), */
                          /* <---- If product description tab is selected ----> */
                          /* <---- Description widget ----> */
                          // :
                          const SliverToBoxAdapter(child: AppGaps.hGap32),
                          SliverToBoxAdapter(
                              child: StoreShortInfoWidget(
                                  imageURL:
                                      controller.productDetails.store.info.logo,
                                  storeName:
                                      controller.productDetails.store.info.name,
                                  isVerified: controller
                                      .productDetails.store.isVerified,
                                  status:
                                      controller.productDetails.store.status,
                                  showBadge: false,
                                  categoryName: controller
                                      .productDetails.store.category.name,
                                  averageRating:
                                      controller.productDetails.store.avgRating,
                                  rightIconWidget: Container(
                                    height: 28,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        gradient: LinearGradient(colors: [
                                          AppColors.primaryColor,
                                          AppColors.primaryColor
                                              .withOpacity(0.4)
                                        ])),
                                    child: CustomTightTextButtonWidget(
                                      onTap: () {
                                        Get.toNamed(
                                            AppPageNames.sellerSingleScreenPage,
                                            arguments: controller
                                                .productDetails.store.info.id,
                                            preventDuplicates: false);
                                      },
                                      child: Center(
                                          child: Text(
                                              LanguageHelper
                                                  .currentLanguageText(
                                                      LanguageHelper
                                                          .visitStoreTransKey),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white))),
                                    ),
                                  ))),
/*                           SliverToBoxAdapter(
                              child: Container(
                            height: 96,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: /* Row(children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: CachedNetworkImageWidget(
                                    imageURL:
                                        controller.productDetails.store.logo,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: imageProvider,
                                            ),
                                          ),
                                        )),
                              ),
                              AppGaps.wGap10,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.productDetails.store.name,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkColor),
                                  ),
                                  AppGaps.hGap10,
                                  /*  Text(
                                    '${}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.bodyTextColor),
                                  ), */
                                  AppGaps.hGap10,
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppAssetImages.starSVGLogoSolid,
                                        color: AppColors.secondaryColor,
                                      ),
                                      AppGaps.wGap3,
                                      Text(
                                        '(${controller.productDetails.store.avgRating})',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.bodyTextColor),
                                      )
                                    ],
                                  ),
                                  AppGaps.wGap4,
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // SvgPicture.asset(
                                  //     AppAssetImages.messageSVGLogoSolid),
                                  GestureDetector(
                                    child: Container(
                                      height: 28,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          gradient: LinearGradient(colors: [
                                            AppColors.primaryColor,
                                            AppColors.primaryColor
                                                .withOpacity(0.4)
                                          ])),
                                      child: CustomTightTextButtonWidget(
                                        child: Center(
                                            child: Text(
                                                LanguageHelper
                                                    .currentLanguageText(
                                                        LanguageHelper
                                                            .visitStoreTransKey),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white))),
                                        onTap: () {
                                          Get.toNamed(
                                              AppPageNames
                                                  .sellerSingleScreenPage,
                                              arguments: controller
                                                  .productDetails.store.id);
                                        },
                                      ),
                                    ),
                                    onTap: () {},
                                  )
                                ],
                              )
                            ]) */
                                StoreShortInfoWidget(
                                    imageURL:
                                        controller.productDetails.store.logo,
                                    storeName:
                                        controller.productDetails.store.name,
                                    isVerified: controller
                                        .productDetails.store.isVerified,
                                    status:
                                        controller.productDetails.store.status,
                                    categoryName: controller
                                        .productDetails.store.category.name,
                                    averageRating: controller
                                        .productDetails.store.avgRating,
                                    rightIconWidget: TightIconButtonWidget(
                                      onTap: () {
                                        Get.toNamed(
                                            AppPageNames.sellerSingleScreenPage,
                                            arguments: controller
                                                .productDetails.store.id);
                                      },
                                      child: Container(
                                        height: 28,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            gradient: LinearGradient(colors: [
                                              AppColors.primaryColor,
                                              AppColors.primaryColor
                                                  .withOpacity(0.4)
                                            ])),
                                        child: CustomTightTextButtonWidget(
                                          child: Center(
                                              child: Text(
                                                  LanguageHelper
                                                      .currentLanguageText(
                                                          LanguageHelper
                                                              .visitStoreTransKey),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    )),
                          )), */
                          /* StoreShortInfoWidget(
                              imageURL: controller.productDetails.store.logo,
                              storeName: controller.productDetails.store.,
                              isVerified: isVerified,
                              status: status,
                              categoryName: categoryName,
                              averageRating: averageRating,
                              rightIconWidget: rightIconWidget), */
                          const SliverToBoxAdapter(child: AppGaps.hGap32),
                          SliverToBoxAdapter(
                            child: Text(
                              LanguageHelper.currentLanguageText(
                                  LanguageHelper.similarProductTransKey),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap16),
                          /* <---- Similar few product list carousel ----> */
                          SliverToBoxAdapter(
                              child: SizedBox(
                            height: 287,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  AppGaps.wGap15,
                              itemCount: controller.relatedProducts.length,
                              itemBuilder: (context, index) {
                                // Single similar product
                                final RelatedProduct relatedProduct =
                                    controller.relatedProducts[index];
                                return SizedBox(
                                  width: 175,
                                  height: 268,
                                  child: CustomGridSingleItemWidget(
                                    backgroundColor: Colors.white,
                                    borderColor: AppColors.lineShapeColor,
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.productDetailsScreen,
                                          preventDuplicates: false,
                                          arguments: relatedProduct.id);
                                    },
                                    child: ProductGridSingleItemWidget(
                                      title: relatedProduct.name,
                                      // shortDescription: similarProduct.productCategory,
                                      originalPrice:
                                          relatedProduct.originalPrice,
                                      currentPrice: relatedProduct.currentPrice,
                                      productImageURL: relatedProduct.image,
                                      isAddedToCart:
                                          controller.isProductAddedToCart(
                                              relatedProduct.id),
                                      onAddTap: () => controller
                                          .onProductAddTap(relatedProduct),
                                      isWishListed: relatedProduct.isFavorite,
                                      onWishlistTap: () => controller
                                          .onAddProductTap(relatedProduct),
                                      discount: relatedProduct.discount,
                                      discountType:
                                          relatedProduct.discountValue.type,
                                      discountValue:
                                          relatedProduct.discountValue.amount,
                                      storeName: relatedProduct.store.name,
                                      isVerified:
                                          relatedProduct.store.isVerified,
                                      productCondition:
                                          relatedProduct.productConditionStatus,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                          const SliverToBoxAdapter(
                            child: AppGaps.hGap16,
                          ),

                          // Bottom spaces
                          const SliverToBoxAdapter(child: AppGaps.hGap30),
                        ]),
                      )),
                  /* <-------- Bottom bar --------> */
                  bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${LanguageHelper.totalTransKey.toCurrentLanguage} :  ${controller.totalAmount.toCurrencyAmountText}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        AppGaps.hGap16,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (Helper.isUserLoggedIn())
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: CustomStretchedTextButtonWidget(
                                      buttonText: AppLanguageTranslation
                                          .makeAnOfferTransKey
                                          .toCurrentLanguage,
                                      onTap: () {
                                        Get.bottomSheet(
                                          MakeAnOfferBottomSheet(),
                                          settings: RouteSettings(
                                              arguments:
                                                  SendOfferScreenParameter(
                                                      oldPrice: controller
                                                          .productDetails
                                                          .originalPrice,
                                                      productId: controller
                                                          .productDetails.id,
                                                      storeId: controller
                                                          .productDetails
                                                          .store
                                                          .info
                                                          .id)),

                                          isScrollControlled:
                                              true, // Set to true if you want to make a full screen or adjust height
                                        );
                                      }),
                                ),
                              ),
                            if (Helper.isUserLoggedIn()) AppGaps.hGap19,
                            Expanded(
                              child: Helper.isUserLoggedIn()
                                  ? Container(
                                      // margin: const EdgeInsets.all(10),
                                      child: controller.isProductAddedToCart(
                                              controller.productDetails.id)
                                          ? CustomStretchedTextButtonWidget(
                                              buttonText: LanguageHelper
                                                  .currentLanguageText(
                                                      LanguageHelper
                                                          .removeFromCartTransKey),
                                              onTap: controller
                                                  .onRemoveFromCartButtonTap)
                                          : CustomStretchedOutlinedTextButtonWidget(
                                              buttonText: LanguageHelper
                                                  .currentLanguageText(
                                                      LanguageHelper
                                                          .addToCartCartTransKey),
                                              onTap: controller
                                                  .onAddToCartButtonTap),
                                    )
                                  : CustomStretchedButtonWidget(
                                      onTap: () {
                                        Get.toNamed(AppPageNames.signInScreen);
                                        Get.snackbar(
                                            AppLanguageTranslation
                                                .loginRequiredTransKey
                                                .toCurrentLanguage,
                                            AppLanguageTranslation
                                                .loginAddCartTransKey
                                                .toCurrentLanguage);
                                      },
                                      child: Text(
                                          LanguageHelper.currentLanguageText(
                                              LanguageHelper.signInTransKey)),
                                    ),
                            ),
                            if (Helper.isUserLoggedIn()) AppGaps.hGap19,
                            if (Helper.isUserLoggedIn())
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: CustomStretchedTextButtonWidget(
                                      buttonText: AppLanguageTranslation
                                          .buyNowTransKey.toCurrentLanguage,
                                      onTap: () async =>
                                          controller.onProductBuyNowTap(
                                            controller.productDetails.id,
                                            controller
                                                .productDetails.productCount,
                                            controller
                                                .productDetails.store.info.id,
                                            controller
                                                .productDetails.productLocation,
                                          )),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  /*  Widget specificationFilter(
     ) {
    return SpecificationFilter();
  } */
}
