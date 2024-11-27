import 'package:ecomik/controller/bid_auction_controller.dart';
import 'package:ecomik/models/api_responses/active_auction_response.dart';
import 'package:ecomik/models/api_responses/won_auction_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../widgets/screen_widgets/bid_screen_widget.dart';
import '../widgets/screen_widgets/bid_won_screen_widget.dart';

class BidAuction extends StatelessWidget {
  const BidAuction({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BidAuctionScreenController>(
        init: BidAuctionScreenController(),
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
                    titleWidget: Text(LanguageHelper.currentLanguageText(
                        LanguageHelper.myAuctionBidTransKey))),

                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      if (controller.isActiveSelected.value) {
                        controller.activeAuctionsPagingController.refresh();
                      } else {
                        controller.wonAuctionsPagingController.refresh();
                      }
                    },
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
                                            text: LanguageHelper
                                                .currentLanguageText(
                                                    LanguageHelper
                                                        .activeAuctionTransKey),
                                            isSelected: controller
                                                .isActiveSelected.value,
                                            onTap: () =>
                                                // setState(() {
                                                controller.isActiveSelected
                                                    .value = true,
                                            // })),
                                          ))),
                                ),
                                AppGaps.wGap5,
                                /* <---- Product Won Auctions tab button ----> */
                                Obx(() => Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CustomTabToggleButtonWidget(
                                            text: LanguageHelper
                                                .currentLanguageText(
                                                    LanguageHelper
                                                        .wonAuctionTransKey),
                                            isSelected: !controller
                                                .isActiveSelected.value,
                                            onTap: () {
                                              // setState(
                                              //   () {
                                              controller.isActiveSelected
                                                  .value = false;
                                              // });
                                            }),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap24),
                        Obx(
                          () => controller.isActiveSelected.value
                              /* <---- If product review tab is selected ----> */
                              /* <---- Review list ----> */
                              ? PagedSliverGrid(
                                  pagingController:
                                      controller.activeAuctionsPagingController,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing:
                                              AppGaps.screenPaddingValue,
                                          mainAxisSpacing:
                                              AppGaps.screenPaddingValue,
                                          mainAxisExtent: 322,
                                          crossAxisCount: 2,
                                          childAspectRatio: 1),
                                  builderDelegate:
                                      CoreWidgets.pagedChildBuilderDelegate<
                                          ActiveAuctionShortItem>(
                                    noItemFoundIndicatorBuilder: (context) {
                                      return EmptyScreenWidget(
                                        localImageAssetURL:
                                            AppAssetImages.noAuctionFound,
                                        title:
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper
                                                    .noActiveAuctionTransKey),
                                        shortTitle: '',
                                      );
                                    },
                                    itemBuilder: (context, item, index) {
                                      /// Per Category data
                                      final ActiveAuctionShortItem bid = item;
                                      /* <---- Bid category item widget ----> */
                                      return BidWidget(
                                        onTap: () {
                                          Get.toNamed(AppPageNames.bidDetails,
                                              arguments: bid.id);
                                        },
                                        name: bid.product.name,
                                        // shortFrame: bid.shortFrame,
                                        price: Helper
                                            .getCurrencyFormattedAmountText(
                                                bid.currentPrice),
                                        categoryImageUrl: bid.product.image,
                                        isWishListed: bid.isFavorite,
                                        startDateTime: bid.startDate,

                                        endDateTime: bid.endDate,
                                        onWishListTap: () {
                                          controller.toggleAddToFavorite(
                                              bid.product.id, true);
                                          controller
                                              .onActiveAuctionItemWishListTap(
                                                  bid);
                                        },
                                        storeName: bid.product.store.name,
                                        isVerified:
                                            bid.product.store.isVerified,
                                      );
                                    },
                                  ))
                              /* <---- If product description tab is selected ----> */
                              /* <---- Description widget ----> */
                              : PagedSliverGrid(
                                  pagingController:
                                      controller.wonAuctionsPagingController,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing:
                                              AppGaps.screenPaddingValue,
                                          mainAxisSpacing:
                                              AppGaps.screenPaddingValue,
                                          mainAxisExtent: 252,
                                          crossAxisCount: 2,
                                          childAspectRatio: 1),
                                  builderDelegate:
                                      CoreWidgets.pagedChildBuilderDelegate<
                                          WonAuctionShortItem>(
                                    noItemFoundIndicatorBuilder: (context) {
                                      return EmptyScreenWidget(
                                        localImageAssetURL:
                                            AppAssetImages.noAuctionFound,
                                        title:
                                            LanguageHelper.currentLanguageText(
                                                LanguageHelper
                                                    .noWonAuctionTransKey),
                                        shortTitle: '',
                                      );
                                    },
                                    itemBuilder: (context, item, index) {
                                      /// Per Category data
                                      final WonAuctionShortItem bid = item;
                                      /* <---- Product category item widget ----> */
                                      return BidWonWidget(
                                        onTap: () {
                                          Get.toNamed(AppPageNames.bidDetails,
                                              arguments: bid.id);
                                        },
                                        name: bid.product.name,
                                        // shortFrame: '',
                                        startDateTime: bid.startDate,
                                        endDateTime: bid.endDate,
                                        money: Helper
                                            .getCurrencyFormattedAmountText(
                                                bid.currentPrice),
                                        categoryImageUrl: bid.product.image,
                                        isWishListed: bid.isFavorite,
                                        onWishListTap: () {
                                          controller.toggleAddToFavorite(
                                              bid.product.id, true);
                                          controller
                                              .onWonAuctionItemWishListTap(bid);
                                        },
                                      );
                                    },
                                  )),
                        ),

                        const SliverToBoxAdapter(child: AppGaps.hGap20),

                        const SliverToBoxAdapter(child: AppGaps.hGap20),
                        //===========================================
                        /* <---- Bottom extra spaces ----> */
                        const SliverToBoxAdapter(child: AppGaps.hGap30),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
