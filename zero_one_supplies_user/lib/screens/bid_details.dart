import 'package:dartx/dartx.dart';
import 'package:ecomik/controller/bid_details_screen_controller.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/bottom_modal_sheets_widget/product_specification_widget.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/bid_details_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BidDetailsScreen extends StatelessWidget {
  const BidDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<BidDetailsScreenController>(
        init: BidDetailsScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: CoreWidgets.appBarWidget(screenContext: context),
                body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: screenSize.height < 550 ? 220 : 330,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenSize.height < 550 ? 250 : 330,
                              child: PageView.builder(
                                  itemCount: controller
                                      .bidDetails.galleryImages.length,
                                  controller:
                                      controller.productImagePageController,
                                  itemBuilder: (context, index) {
                                    final galleryImage = controller
                                        .bidDetails.galleryImages[index];
                                    return GestureDetector(
                                      onTap: () => Get.toNamed(
                                          AppPageNames.imageScreen,
                                          arguments: controller
                                              .bidDetails.galleryImages),
                                      child: CachedNetworkImageWidget(
                                        imageURL: galleryImage,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider)),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            AppGaps.hGap16,
                            Center(
                              child: SmoothPageIndicator(
                                controller:
                                    controller.productImagePageController,
                                count:
                                    controller.bidDetails.galleryImages.isEmpty
                                        ? 1
                                        : controller
                                            .bidDetails.galleryImages.length,
                                effect: ScrollingDotsEffect(
                                    dotHeight: 10,
                                    dotWidth: 10,
                                    spacing: 8,
                                    dotColor:
                                        AppColors.darkColor.withOpacity(0.15),
                                    activeDotColor: AppColors.primaryColor),
                              ),
                            ),
                            AppGaps.hGap7,
                          ],
                        ),
                      ),
                    ),
                  ],
                  body: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(30))),
                        child: CustomScrollView(
                          slivers: [
                            const SliverToBoxAdapter(
                              child: AppGaps.hGap24,
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.bidDetails.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AppGaps.hGap10,
                                  Text(
                                      controller.bidDetails.categories
                                              .firstOrNull?.name ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.bodyTextColor)),
                                  AppGaps.hGap16,
                                  Text(
                                    LanguageHelper.currentLanguageText(
                                        LanguageHelper
                                            .productDescriptionTransKey),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AppGaps.hGap10,
                                  HtmlWidget(
                                      controller.bidDetails.description.long),
                                  AppGaps.hGap32,
                                  if (controller
                                      .bidDetails.specification.isNotEmpty)
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
                                          child: SvgPicture.asset(AppAssetImages
                                              .arrowRightSVGLogoLine),
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors
                                                  .transparent
                                                  .withOpacity(0.0),
                                              builder: (BuildContext context) {
                                                return SpecificationFilter(
                                                  specifications: controller
                                                      .bidDetails.specification
                                                      .map((e) =>
                                                          Pair(e.key, e.value))
                                                      .toList(),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  if (controller
                                      .bidDetails.specification.isNotEmpty)
                                    AppGaps.hGap15,
                                  if (controller
                                      .bidDetails.specification.isNotEmpty)
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
                                                .bidDetails
                                                .specification[index];
                                            return SpecificationWidget(
                                                title: specification.key,
                                                content: specification.value);
                                          },
                                          separatorBuilder: (context, index) =>
                                              AppGaps.wGap24,
                                          itemCount: controller
                                              .bidDetails.specification.length),
                                    )
                                ],
                              ),
                            ),
                            const SliverToBoxAdapter(child: AppGaps.hGap32),
                            SliverToBoxAdapter(
                                child: StoreShortInfoWidget(
                                    imageURL: controller
                                            .bidDetails.store.info.logo.isEmpty
                                        ? 'https://01supplies.s3.eu-north-1.amazonaws.com/live/01supplies/store/646ef58f480bea6c4415316a/logo-1707421866421.webp'
                                        : controller.bidDetails.store.info.logo,
                                    storeName:
                                        controller.bidDetails.store.info.name,
                                    isVerified: controller
                                        .bidDetails.store.info.verified,
                                    status: controller
                                        .bidDetails.store.info.storeType,
                                    showBadge: false,
                                    categoryName: controller
                                        .bidDetails.store.info.category.name,
                                    averageRating: controller
                                        .bidDetails.store.info.avgRating,
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
                                              AppPageNames
                                                  .sellerSingleScreenPage,
                                              arguments: controller
                                                  .bidDetails.store.info.id,
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
                            /* SliverToBoxAdapter(
                                child: Container(
                              height: 96,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Row(children: [
                                /* Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: Image.asset(
                                                  AppAssetImages.loveClip)
                                              .image,
                                          fit: BoxFit.fill)),
                                ), */
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CachedNetworkImageWidget(
                                      imageURL:
                                          controller.bidDetails.store.logo,
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
                                      controller.bidDetails.store.name,
                                      style: AppTextStyles.bodyBoldTextStyle,
                                    ),
                                    AppGaps.hGap10,
                                    Text(
                                      controller.bidDetails.store.category.name,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.bodyTextColor),
                                    ),
                                    AppGaps.hGap10,
                                    Row(
                                      children: [
                                        // StarWidget( rating: controller .bidDetails.store.avgRating),
                                        SvgPicture.asset(
                                          AppAssetImages.starSVGLogoSolid,
                                          color: AppColors.secondaryColor,
                                        ),
                                        /* SizedBox(
                                            height: 16,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      AppGaps.wGap2,
                                              itemCount: 5,
                                              itemBuilder: (context, index) =>
                                                  SvgPicture.asset(
                                                AppAssetImages.starSVGLogoSolid,
                                                color: AppColors.secondaryColor,
                                              ),
                                            )), */
                                        AppGaps.wGap3,
                                        Text(
                                          '(${controller.bidDetails.store.avgRating})',
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
                                        child: Center(
                                            child: CustomTightTextButtonWidget(
                                          onTap:
                                              controller.onVisitStoreButtonTap,
                                          child: Text(
                                              LanguageHelper
                                                  .currentLanguageText(
                                                      LanguageHelper
                                                          .visitStoreTransKey),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                        )),
                                      ),
                                      onTap: () {},
                                    )
                                  ],
                                )
                              ]),
                            )), */
                            const SliverToBoxAdapter(child: AppGaps.hGap24),
                            SliverToBoxAdapter(
                              child: Row(
                                children: [
                                  Text(
                                    LanguageHelper.currentLanguageText(
                                        LanguageHelper.bidHistoryTransKey),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkColor),
                                  ),
                                  AppGaps.wGap10,
                                  Image.asset(AppAssetImages.wavingHand)
                                ],
                              ),
                            ),
                            const SliverToBoxAdapter(child: AppGaps.hGap24),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final bidUser = controller.bidUsers[index];
                                return BidPersonWidget(
                                    name:
                                        '${bidUser.firstName} ${bidUser.lastName}',
                                    image: bidUser.image,
                                    dateTime: bidUser.date,
                                    bidPrice: bidUser.bidAmount);
                              },
                              childCount: controller.bidUsers.length,
                            )),
                            const SliverToBoxAdapter(
                              child: AppGaps.hGap16,
                            ),
                            SliverToBoxAdapter(
                              child:
                                  /* <---- Product price ----> */
                                  Text(
                                '${LanguageHelper.currentLanguageText(LanguageHelper.highestBidTransKey)}: ${Helper.getCurrencyFormattedAmountText(controller.bidDetails.auctionInfo.currentPrice)}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkColor),
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: AppGaps.hGap20,
                            )
                          ],
                        ),
                      ),
                      BidCountdownTimer(
                          bidEndDateTime:
                              controller.bidDetails.auctionInfo.endDate),
                    ],
                  ),
                ),
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /*  Expanded(
                      child: CustomStretchedOutlinedTextButtonWidget(
                        buttonText:
                            'Buy This (${Helper.getCurrencyFormattedAmountText(controller.bidDetails.currentPrice)})',
                        onTap: () {},
                      ),
                    ),
                    AppGaps.wGap10, */
                    Expanded(
                      child: Helper.isUserLoggedIn()
                          ? controller.bidDetails.auctionInfo.winner.isNotEmpty
                              ? controller.user.id ==
                                      controller.bidDetails.auctionInfo.winner
                                  ? controller.isProductInList
                                      ? CustomStretchedButtonWidget(
                                          onTap: null,
                                          child: Text(AppLanguageTranslation
                                              .addedToCartTransKey
                                              .toCurrentLanguage),
                                        )
                                      : CustomStretchedButtonWidget(
                                          onTap: () async =>
                                              controller.onProductBuyNowTap(
                                            controller.bidDetails.id,
                                            controller.productCount,
                                            controller.bidDetails.store.info.id,
                                            controller
                                                .bidDetails.productLocation,
                                          ),
                                          child: Text(AppLanguageTranslation
                                              .addToCartCartTransKey
                                              .toCurrentLanguage),
                                        )
                                  : CustomStretchedButtonWidget(
                                      onTap: null,
                                      child: Text(AppLanguageTranslation
                                          .wonBuySomeOneTransKey
                                          .toCurrentLanguage),
                                    )
                              : CustomStretchedButtonWidget(
                                  onTap: controller.bidDetails.auctionInfo.isEnd
                                      ? null
                                      : controller.onBidNowButtonTap,
                                  child: Text(
                                      LanguageHelper.currentLanguageText(
                                          LanguageHelper.bidNowTransKey)),
                                )
                          : CustomStretchedButtonWidget(
                              onTap: () {
                                Get.toNamed(AppPageNames.signInScreen);
                                Get.snackbar(
                                    AppLanguageTranslation.loginRequiredTransKey
                                        .toCurrentLanguage,
                                    AppLanguageTranslation
                                        .loginBidTransKey.toCurrentLanguage);
                              },
                              child: Text(LanguageHelper.currentLanguageText(
                                  LanguageHelper.signInTransKey)),
                            ),
                    )
                  ],
                )),
              ),
            ));
  }

  /*  Widget auctionBidNow(BuildContext context) {
    return const AuctionBidNow();
  } */
}
