import 'package:ecomik/controller/productpage_controller.dart';
import 'package:ecomik/models/api_responses/mixed_product_auction_response.dart';
import 'package:ecomik/models/api_responses/products_with_tags_response.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/bid_screen_widget.dart';
import 'package:ecomik/widgets/screen_widgets/custom_expansion_tile.dart';
import 'package:ecomik/widgets/screen_widgets/product_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductPageController>(
        init: ProductPageController(),
        global: false,
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                  key: controller.productPageScaffoldKey,
                  appBar: CoreWidgets.appBarWidget(
                      hasBackButton: true,
                      screenContext: context,
                      titleWidget: Text(
                        LanguageHelper.currentLanguageText(
                            LanguageHelper.productTransKey),
                      )),
                  drawer: Drawer(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    LanguageHelper.currentLanguageText(
                                        LanguageHelper.filterTransKey),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
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
                              AppGaps.hGap12,

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
                                            padding: const EdgeInsets.only(
                                                top: 6, bottom: 12),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final category =
                                                  controller.categories[index];
                                              return FilterItemWidget(
                                                  value: category,
                                                  text: category.name,
                                                  groupValue: controller
                                                      .selectedCategoryOption,
                                                  onTap: () => controller
                                                      .toggleCategoryOption(
                                                          category),
                                                  onChanged: (p0) => controller
                                                      .toggleCategoryOption(
                                                          category));
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
/*                                         Wrap(
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
                                        ) */

                                        ListView.separated(
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                top: 6, bottom: 12),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final subcategory = controller
                                                  .subCategories[index];
                                              return FilterItemWidget(
                                                  value: subcategory,
                                                  text: subcategory.name,
                                                  groupValue: controller
                                                      .selectedSubCategoryOption,
                                                  onTap: () => controller
                                                      .toggleSubCategoryOption(
                                                          subcategory),
                                                  onChanged: (p0) => controller
                                                      .toggleSubCategoryOption(
                                                          subcategory));
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.hGap6,
                                            itemCount:
                                                controller.subCategories.length)
                                      ]),
                                ],
                              ),

                              Column(
                                children: [
                                  CustomExpansionTile(
                                      title: Text(
                                          AppLanguageTranslation
                                              .priceRangeTransKey
                                              .toCurrentLanguage,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600)),
                                      children: [
                                        Wrap(
                                          children: [
                                            RangeSlider(
                                              values:
                                                  controller.currentRangeValues,
                                              max: 100000,
                                              divisions: 100000,
                                              labels: RangeLabels(
                                                Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .start),
                                                Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .end),
                                              ),
                                              onChanged: (RangeValues values) {
                                                controller.toggleSelectedRange(
                                                    values);
                                              },
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .start)),
                                                Text(Helper
                                                    .getCurrencyFormattedAmountText(
                                                        controller
                                                            .currentRangeValues
                                                            .end)),
                                              ]),
                                        ),
                                      ]),
                                ],
                              ),
                              AppGaps.hGap24,
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
                                      // Get.toNamed(AppPageNames.popularProductAuction);
                                      // Get.back( result: controller.filterOptions);
                                      controller.applyFilters();
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
                  body: CustomScaffoldBodyWidget(
                    child: RefreshIndicator(
                      onRefresh: () async =>
                          controller.normalProductPagingController.refresh(),
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
                                        hasShadow: false,
                                        controller: controller
                                            .searchTextEditingController,
                                        onChanged: controller.onChange,
                                        hintText:
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper
                                                    .searchItemTransKey),
                                        prefixIcon: SvgPicture.asset(
                                            AppAssetImages.searchSVGLogoLine,
                                            color: AppColors.primaryColor))),
                                AppGaps.wGap8,
                                /* <---- Filter icon button ----> */
                                Builder(builder: (BuildContext context) {
                                  return CustomIconButtonWidget(
                                    fixedSize: const Size(60, 60),
                                    hasShadow: true,
                                    backgroundColor: AppColors.primaryColor,
                                    child: SvgPicture.asset(
                                        AppAssetImages.filterSVGLogoLine,
                                        color: Colors.white),
                                    onTap: () async {
/*                                       final dynamic result =
                                          await Get.bottomSheet(
                                              const ProductFilter(),
                                              // context: context,
                                              backgroundColor: Colors
                                                  .transparent
                                                  .withOpacity(0.0),
                                              // isScrollControlled: true,
                                              settings: RouteSettings(
                                                  arguments: controller
                                                      .filterOptions));
                                      if (result is AuctionpopularProductFilterParameter) {
                                        controller.setFilterOptions(result);
                                      } */
                                      controller
                                          .productPageScaffoldKey.currentState
                                          ?.openDrawer();
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap10),
                          SliverToBoxAdapter(
                            child: /* !controller.isNormalMode
                                ? AppGaps.emptyGap
                                :  */
                                SizedBox(
                              height: 35,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final tag = controller.tags[index];
                                    final isSelected = controller
                                            .searchTextEditingController.text ==
                                        tag.name;
                                    return ChoiceChip(
                                      backgroundColor:
                                          AppColors.backgroundColor,
                                      side: const BorderSide(
                                          color: AppColors.bodyTextColor),
                                      selectedColor: AppColors.primaryColor,
                                      label: Text(
                                        tag.name,
                                        style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : null),
                                      ),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        controller.toggleTag(tag, selected);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      AppGaps.wGap20,
                                  itemCount: controller.tags.length),
                            ),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap20),

                          /* <---- Product categories grid list ----> */
                          //============================================

                          // controller.isNormalMode?
                          PagedSliverGrid(
                              pagingController:
                                  controller.normalProductPagingController,
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
                                          MixedAuctionProductItem>(
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
                                        final MixedAuctionProductItem
                                            popularProduct = item;
                                        /* <---- Product category item widget ----> */
                                        return !popularProduct.isAuction
                                            ? CustomGridSingleItemWidget(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppPageNames
                                                          .productDetailsScreen,
                                                      arguments:
                                                          popularProduct.id);
                                                },
                                                child:
                                                    ProductGridSingleItemWidget(
                                                  title: popularProduct.name,
                                                  originalPrice: popularProduct
                                                      .originalPrice,
                                                  currentPrice: popularProduct
                                                      .currentPrice,
                                                  productImageURL:
                                                      popularProduct.image,
                                                  isAddedToCart: controller
                                                      .isProductAddedToCart(
                                                          popularProduct.id),
                                                  onAddTap: () {
                                                    controller.onProductAddTap(
                                                        popularProduct);
                                                  },
                                                  isWishListed:
                                                      popularProduct.isFavorite,
                                                  onWishlistTap: () {
                                                    popularProduct.isFavorite =
                                                        !popularProduct
                                                            .isFavorite;
                                                    controller
                                                        .toggleAddToFavorite(
                                                            popularProduct.id);
                                                    controller.update();
                                                  },
                                                  discount:
                                                      popularProduct.discount,
                                                  discountType: popularProduct
                                                      .discountValue.type,
                                                  discountValue: popularProduct
                                                      .discountValue.amount,
                                                  storeName:
                                                      popularProduct.store.name,
                                                  isVerified: popularProduct
                                                      .store.verified,
                                                  productCondition: popularProduct
                                                      .productConditionStatusEnum,
                                                ),
                                              )
                                            : BidWidget(
                                                onTap: () {
                                                  Get.toNamed(
                                                      AppPageNames.bidDetails,
                                                      arguments:
                                                          popularProduct.id,
                                                      preventDuplicates: false);
                                                },
                                                name:
                                                    popularProduct.product.name,
                                                // shortFrame: '',
                                                price: Helper
                                                    .getCurrencyFormattedAmountText(
                                                        popularProduct
                                                            .currentPrice),
                                                startDateTime:
                                                    popularProduct.startDate,
                                                endDateTime:
                                                    popularProduct.endDate,
                                                categoryImageUrl: popularProduct
                                                    .product.image,
                                                isWishListed:
                                                    popularProduct.isFavorite,
                                                onWishListTap: () {
                                                  controller
                                                      .toggleAddToFavorite(
                                                          popularProduct
                                                              .product.id,
                                                          true);
                                                  controller
                                                      .onAuctionItemWishListTap(
                                                          popularProduct);
                                                },
                                                storeName: popularProduct
                                                    .product.store.name,
                                                isVerified: popularProduct
                                                    .product.store.verified,
                                              );
                                      }))
                          /* : PagedSliverList.separated(
                                   pagingController: controller
                                      .productsAndTagsPagingController,
                                  builderDelegate: PagedChildBuilderDelegate<
                                      ProductsAndTags>(
                                    itemBuilder: (context, item, index) {
/*                                       final a = Get.put<
                                              ProductsAndTagsWidgetController>(
                                          ProductsAndTagsWidgetController(),
                                          tag: index.toString(),
                                          permanent: false);
                                      Get.put<String>(index.toString(),
                                          tag: 'products_and_tags',
                                          permanent: false);
                                      a.getWidgetParameter(
                                          ProductsAndTagsWidgetParameter(
                                              productsAndTagsItem: item,
                                              cartProducts:
                                                  controller.cartProducts));
                                      return ProductsAndTagsWidget(
                                          controllerTag: index.toString(),
                                          parameter:
                                              ProductsAndTagsWidgetParameter(
                                                  productsAndTagsItem: item,
                                                  cartProducts:
                                                      controller.cartProducts)); */
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  final tag = item.tags[index];
                                                  final isSelected =
                                                      item.selectedTagIndex ==
                                                          index;
                                                  return ChoiceChip(
                                                    backgroundColor: AppColors
                                                        .backgroundColor,
                                                    side: const BorderSide(
                                                        color: AppColors
                                                            .bodyTextColor),
                                                    selectedColor:
                                                        AppColors.primaryColor,
                                                    label: Text(
                                                      tag,
                                                      style: TextStyle(
                                                          color: isSelected
                                                              ? Colors.white
                                                              : null),
                                                    ),
                                                    selected: isSelected,
                                                    onSelected: (selected) {
                                                      controller.toggleInnerTag(
                                                          item,
                                                          selected,
                                                          index);
                                                    },
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        AppGaps.wGap20,
                                                itemCount: item.tags.length),
                                          ),
                                          AppGaps.hGap15,
                                          Builder(builder: (context) {
                                            List<MixedAuctionProductItem>
                                                products = item.products;
                                            if (item.selectedTagIndex != -1) {
                                              final selectedTag = item
                                                  .tags[item.selectedTagIndex];
                                              products = products
                                                  .where((product) =>
                                                      product.tags
                                                          .firstWhereOrNull(
                                                              (tag) =>
                                                                  tag ==
                                                                  selectedTag) !=
                                                      null)
                                                  .toList();
                                            }
                                            return GridView.custom(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisSpacing: AppGaps
                                                            .screenPaddingValue,
                                                        mainAxisSpacing: AppGaps
                                                            .screenPaddingValue,
                                                        mainAxisExtent: 287,
                                                        crossAxisCount: 2,
                                                        childAspectRatio: 1),
                                                childrenDelegate:
                                                    SliverChildBuilderDelegate(
                                                        (context, index) {
                                                  /// Per Category data
                                                  final MixedAuctionProductItem
                                                      popularProduct =
                                                      item.products[index];
                                                  /* <---- Product category item widget ----> */
                                                  return !popularProduct
                                                          .isAuction
                                                      ? CustomGridSingleItemWidget(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                AppPageNames
                                                                    .productDetailsScreen,
                                                                arguments:
                                                                    popularProduct
                                                                        .id,
                                                                preventDuplicates:
                                                                    false);
                                                          },
                                                          child:
                                                              ProductGridSingleItemWidget(
                                                            title:
                                                                popularProduct
                                                                    .name,
                                                            originalPrice:
                                                                popularProduct
                                                                    .originalPrice,
                                                            currentPrice:
                                                                popularProduct
                                                                    .currentPrice,
                                                            productImageURL:
                                                                popularProduct
                                                                    .image,
                                                            isAddedToCart: controller
                                                                .isProductAddedToCart(
                                                                    popularProduct
                                                                        .id),
                                                            onAddTap: () {
                                                              controller
                                                                  .onProductAddTap(
                                                                      popularProduct);
                                                            },
                                                            isWishListed:
                                                                popularProduct
                                                                    .isFavorite,
                                                            onWishlistTap: () {
                                                              popularProduct
                                                                      .isFavorite =
                                                                  !popularProduct
                                                                      .isFavorite;
                                                              controller
                                                                  .toggleAddToFavorite(
                                                                      popularProduct
                                                                          .id);
                                                              controller
                                                                  .update();
                                                            },
                                                            discount:
                                                                popularProduct
                                                                    .discount,
                                                            discountType:
                                                                popularProduct
                                                                    .discountValue
                                                                    .type,
                                                            discountValue:
                                                                popularProduct
                                                                    .discountValue
                                                                    .amount,
                                                            storeName:
                                                                popularProduct
                                                                    .store.name,
                                                            isVerified:
                                                                popularProduct
                                                                    .store
                                                                    .verified,
                                                            productCondition:
                                                                popularProduct
                                                                    .productConditionStatusEnum,
                                                          ),
                                                        )
                                                      : BidWidget(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                AppPageNames
                                                                    .bidDetails,
                                                                arguments:
                                                                    popularProduct
                                                                        .id,
                                                                preventDuplicates:
                                                                    false);
                                                          },
                                                          name: popularProduct
                                                              .product.name,
                                                          // shortFrame: '',
                                                          price: Helper
                                                              .getCurrencyFormattedAmountText(
                                                                  popularProduct
                                                                      .currentPrice),
                                                          startDateTime:
                                                              popularProduct
                                                                  .startDate,
                                                          endDateTime:
                                                              popularProduct
                                                                  .endDate,
                                                          categoryImageUrl:
                                                              popularProduct
                                                                  .product
                                                                  .image,
                                                          isWishListed:
                                                              popularProduct
                                                                  .isFavorite,
                                                          onWishListTap: () {
                                                            controller
                                                                .toggleAddToFavorite(
                                                                    popularProduct
                                                                        .product
                                                                        .id,
                                                                    true);
                                                            controller
                                                                .onAuctionItemWishListTap(
                                                                    popularProduct);
                                                          },
                                                          storeName:
                                                              popularProduct
                                                                  .product
                                                                  .store
                                                                  .name,
                                                          isVerified:
                                                              popularProduct
                                                                  .product
                                                                  .store
                                                                  .verified,
                                                        );
                                                },
                                                        childCount:
                                                            products.length));
                                          }),
                                        ],
                                      );
                                    },
                                  ),
                                  separatorBuilder: (context, index) =>
                                      AppGaps.hGap20,
                                ), */
                          //===========================================
                          /* <---- Bottom extra spaces ----> */
                          ,
                          const SliverToBoxAdapter(child: AppGaps.hGap30),
                        ],
                      ),
                    ),
                  )),
            ));
  }
}
