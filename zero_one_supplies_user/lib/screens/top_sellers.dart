import 'package:ecomik/controller/home_navigator_screen_controller/top_seller_controller.dart';
import 'package:ecomik/models/api_responses/seller_list_response.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/top_sellers_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopSellersScreenPage extends StatelessWidget {
  const TopSellersScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopSellerScreenController>(
        init: TopSellerScreenController(),
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
                    titleWidget: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.topSellerTransKey),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor),
                    )),
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.flashSellPagingController.refresh(),
                    child: CustomScrollView(
                      slivers: [
                        PagedSliverGrid(
                            pagingController:
                                controller.flashSellPagingController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 248,
                                    crossAxisCount: 2),
                            builderDelegate:
                                CoreWidgets.pagedChildBuilderDelegate<
                                        SellerSingleShortItem>(
                                    itemBuilder: (context, item, index) {
                              final SellerSingleShortItem seller = item;

                              return CustomGridSingleItemWidget(
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.sellerSingleScreenPage,
                                      arguments: seller.id);
                                },
                                child: TopSellerScreenWidget(
                                  name: seller.name,
                                  category: seller.category.name,
                                  image: seller.logo,
                                  product: seller.products,
                                  status: seller.sellerRating.status,
                                  isVerified: seller.isVerified,
                                  showStatus: false,
                                ),
                              );
                            })),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
