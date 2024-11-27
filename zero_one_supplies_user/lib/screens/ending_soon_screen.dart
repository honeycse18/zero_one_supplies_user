import 'package:ecomik/controller/ending_soon_controller.dart';
import 'package:ecomik/models/api_responses/ending_soon_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../widgets/screen_widgets/bid_screen_widget.dart';

class EndingSoonScreen extends StatelessWidget {
  const EndingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EndingSoonScreenController>(
        init: EndingSoonScreenController(),
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
                        LanguageHelper.endingSoonTransKey))),

                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.endingSoonPagingController.refresh(),
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
                                      controller: controller
                                          .searchTextEditingController,
                                      onChanged: controller.onChange,
                                      hasShadow: false,
                                      hintText:
                                          LanguageHelper.currentLanguageText(
                                              LanguageHelper
                                                  .searchItemTransKey),
                                      prefixIcon: SvgPicture.asset(
                                          AppAssetImages.searchSVGLogoLine,
                                          color: AppColors.primaryColor))),
                              AppGaps.wGap8,
                              /* <---- Filter icon button ----> */
                              /*   Builder(builder: (BuildContext context) {
                                return CustomIconButtonWidget(
                                  fixedSize: const Size(60, 60),
                                  hasShadow: true,
                                  backgroundColor: AppColors.primaryColor,
                                  child: SvgPicture.asset(
                                      AppAssetImages.filterSVGLogoLine,
                                      color: Colors.white),
                                  onTap: () {},
                                );
                              }), */
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap20),

                        /* <---- Product categories grid list ----> */
                        //============================================
                        PagedSliverGrid(
                            pagingController:
                                controller.endingSoonPagingController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing:
                                        AppGaps.screenPaddingValue,
                                    mainAxisSpacing: AppGaps.screenPaddingValue,
                                    mainAxisExtent: 310,
                                    crossAxisCount: 2,
                                    childAspectRatio: 1),
                            builderDelegate: CoreWidgets
                                .pagedChildBuilderDelegate<EndingSoonShortItem>(
                                    itemBuilder: (context, item, index) {
                              /// Per Category data
                              final EndingSoonShortItem endingSoon = item;
                              /* <---- Product category item widget ----> */
                              return BidWidget(
                                onTap: () {
                                  Get.toNamed(AppPageNames.bidDetails,
                                      arguments: endingSoon.id);
                                },
                                name: endingSoon.product.name,
                                // shortFrame: '',
                                price: Helper.getCurrencyFormattedAmountText(
                                    endingSoon.currentPrice),
                                startDateTime: endingSoon.startDate,
                                endDateTime: endingSoon.endDate,
                                categoryImageUrl: endingSoon.product.image,
                                isWishListed: endingSoon.isFavorite,
                                onWishListTap: () {
                                  controller.toggleAddToFavorite(
                                      endingSoon.product.id, true);
                                  controller
                                      .onEndingSoonItemWishListTap(endingSoon);
                                },
                                storeName: endingSoon.product.store.name,
                                isVerified: endingSoon.product.store.isVerified,
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
}
