import 'package:ecomik/controller/top_brands_controller.dart';
import 'package:ecomik/models/api_responses/brands_response.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/top_brand_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopBrandsPage extends StatelessWidget {
  const TopBrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopBrandsScreenController>(
        init: TopBrandsScreenController(),
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
                    actions: [
                      /* Center(
                        child: CustomIconButtonWidget(
                            onTap: () {},
                            hasShadow: true,
                            child: SvgPicture.asset(
                              AppAssetImages.searchSVGLogoLine,
                              color: AppColors.darkColor,
                              height: 18,
                              width: 18,
                            )),
                      ), */
                      AppGaps.wGap20,
                    ],
                    titleWidget: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.topBrandsTransKey),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor),
                    )),
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        controller.topBrandPagingController.refresh(),
                    child: CustomScrollView(
                      slivers: [
                        PagedSliverGrid(
                          pagingController: controller.topBrandPagingController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing:
                                      AppGaps.screenSecondaryPaddingValue,
                                  mainAxisSpacing:
                                      AppGaps.screenSecondaryPaddingValue,
                                  mainAxisExtent: 111,
                                  crossAxisCount: 3),
                          builderDelegate: CoreWidgets
                              .pagedChildBuilderDelegate<BrandShortItem>(
                                  itemBuilder: (context, item, index) {
                            final BrandShortItem brand = item;
                            return CustomGridSingleItemWidget(
                                onTap: () {
                                  // Get.toNamed(AppPageNames.topBrandSingle);
                                  Get.toNamed(AppPageNames.topBrandSingle,
                                      arguments: item.id);
                                },
                                child: TopBrandsScreenWidget(
                                  image: brand.image,
                                ));
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
