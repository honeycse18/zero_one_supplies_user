import 'package:ecomik/controller/auction_screen_controller.dart';
import 'package:ecomik/models/api_responses/auctions_response.dart';
import 'package:ecomik/models/bottom_sheet_parameters/auction_bid_filter_parameter.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/bottom_modal_sheets_widget/auction_bid_filtre.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../widgets/screen_widgets/bid_screen_widget.dart';

class AuctionProduct extends StatelessWidget {
  const AuctionProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuctionScreenController>(
        init: AuctionScreenController(),
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
                        LanguageHelper.auctionProductTransKey))),

                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.auctionsPagingController.refresh(),
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
                              //===========Auction Filter==================
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
                                    /* showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return bidFilter();
                                      },
                                    ); */

                                    final dynamic result =
                                        await Get.bottomSheet(
                                      // buildBottomSheet(controller),
                                      AuctionBidFilter(),
                                      backgroundColor:
                                          Colors.transparent.withOpacity(0.0),
                                      // isScrollControlled: true,
                                    );
                                    if (result is AuctionBidFilterParameter) {
                                      controller.setFilterOptions(result);
                                    }
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap10),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 35,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tag = controller.tags[index];
                                  final isSelected = controller
                                          .searchTextEditingController.text ==
                                      tag.name;
                                  return ChoiceChip(
                                    selectedColor: AppColors.primaryColor,
                                    label: Text(
                                      tag.name,
                                      style: TextStyle(
                                          color:
                                              isSelected ? Colors.white : null),
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
                        PagedSliverGrid(
                            pagingController:
                                controller.auctionsPagingController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: AppGaps.screenPaddingValue,
                                    mainAxisExtent: 278,
                                    crossAxisCount: 2,
                                    childAspectRatio: 1),
                            builderDelegate: CoreWidgets
                                .pagedChildBuilderDelegate<AuctionShortItem>(
                                    noItemFoundIndicatorBuilder: (context) =>
                                        Center(
                                            child: Text(LanguageHelper
                                                .currentLanguageText(
                                                    LanguageHelper
                                                        .noItemFoundTransKey))),
                                    itemBuilder: (context, item, index) {
                                      /// Per Category data
                                      final AuctionShortItem bid = item;
                                      /* <---- Product category item widget ----> */
                                      return BidWidget(
                                        onTap: () {
                                          Get.toNamed(AppPageNames.bidDetails,
                                              arguments: bid.id,
                                              preventDuplicates: false);
                                        },
                                        name: bid.name,
                                        // shortFrame: '',
                                        price: Helper
                                            .getCurrencyFormattedAmountText(
                                                bid.currentPrice),
                                        startDateTime: bid.startDate,
                                        endDateTime: bid.endDate,
                                        categoryImageUrl: bid.image,
                                        isWishListed: bid.isWishListed,
                                        onWishListTap: () {
                                          controller.toggleAddToFavorite(
                                              bid.id, true);
                                          controller
                                              .onAuctionItemWishListTap(bid);
                                        },
                                        storeName: bid.store.name,
                                        isVerified: bid.store.isVerified,
                                      );
                                    })),
                        //===========================================
                        /* <---- Bottom extra spaces ----> */
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  /* Widget buildBottomSheet(AuctionScreenController controller) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Text('Choose Options'),
          Wrap(
            children: [
              ChoiceChip(
                selectedColor: Colors.red,
                label: Text('Option 1'),
                selected: controller.selectedOptions.contains('Option 1'),
                onSelected: (selected) {
                  controller.toggleOption('Option 1');
                  controller.update();
                },
              ),
              AppGaps.wGap10,
              ChoiceChip(
                selectedColor: Colors.red,
                label: Text('Option 2'),
                selected: controller.selectedOptions.contains('Option 2'),
                onSelected: (selected) {
                  controller.toggleOption('Option 2');
                  controller.update();
                },
              ),
              AppGaps.wGap10,
              ChoiceChip(
                selectedColor: Colors.red,
                label: Text('Option 3'),
                selected: controller.selectedOptions.contains('Option 3'),
                onSelected: (selected) {
                  controller.toggleOption('Option 3');
                  controller.update();
                },
              ),
              // Add more ChoiceChips for additional options
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Handle the selected options
              print(controller.selectedOptions);
              Get.back();
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  } */
}
