import 'package:ecomik/controller/delivery_info_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliveryInfoScreen extends StatelessWidget {
  const DeliveryInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<DeliveryInfoScreenController>(
        init: DeliveryInfoScreenController(),
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
                    titleWidget: Text(AppLanguageTranslation
                        .deliveryInfoTransKey.toCurrentLanguage),
                    /* <---- Appbar right side widgets ----> */
                    actions: [
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
                    ]),
                /* <-------- Content --------> */
                body: SlidingUpPanel(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  backdropEnabled: true,
                  backdropColor: AppColors.lineShapeColor,
                  margin:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 15),
                  backdropOpacity: 0.8,
                  boxShadow: const [],
                  color: Colors.transparent,
                  maxHeight: screenSize.height * 0.70,
                  minHeight: 110,
                  /* <---- Top part of bottom slider ----> */
                  header: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: screenSize.width - 48,
                        height: 100,
                        margin: const EdgeInsets.only(top: 14),
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /* <---- Delivery man profile picture ----> */
                              CircleAvatar(
                                radius: 24,
                                backgroundImage:
                                    Image.asset(AppAssetImages.reviewer1Image)
                                        .image,
                              ),
                              AppGaps.wGap16,
                              /* <---- Delivery man name and designation column ----> */
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'George Anderson',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    AppGaps.hGap8,
                                    Text(
                                      AppLanguageTranslation
                                          .deliveryPartnerTransKey
                                          .toCurrentLanguage,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                              /* <---- Delivery man message and call icon button 
                               row ----> */
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /* <---- Message icon button ----> */
                                  IconButton(
                                      onPressed: () {
                                        Get.toNamed(AppPageNames
                                            .chatWithDeliverymanScreen);
                                      },
                                      icon: SvgPicture.asset(
                                        AppAssetImages.messageSVGLogoLine,
                                        color: Colors.white,
                                      )),
                                  /* <---- Call icon button ----> */
                                  IconButton(
                                      onPressed: () {
                                        Get.toNamed(AppPageNames.callScreen);
                                      },
                                      icon: SvgPicture.asset(
                                        AppAssetImages.callingSVGLogoLine,
                                        color: Colors.white,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 2,
                          child: SvgPicture.asset(
                              AppAssetImages.slideUpPanelNotchSVG,
                              color: AppColors.primaryColor)),
                      Positioned(
                          top: 12,
                          child: SvgPicture.asset(
                            AppAssetImages.arrowUpSVGLogoLine,
                            color: Colors.white.withOpacity(0.3),
                            width: 40,
                          ))
                    ],
                  ),
                  /* <---- Body content of bottom slider panel ----> */
                  panelBuilder: (sc) => Container(
                    margin: const EdgeInsets.only(top: 90),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: CustomScrollView(controller: sc, slivers: [
                        // Top extra spaces
                        const SliverToBoxAdapter(child: AppGaps.hGap24),
                        /* <---- Time icon circle widget and 'delivery time' text 
                         row ----> */
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 34,
                                width: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 6),
                                          color: AppColors.primaryColor
                                              .withOpacity(0.35),
                                          blurRadius: 15)
                                    ]),
                                child: SvgPicture.asset(
                                    AppAssetImages.clockCircleSVGLogoLine,
                                    height: 18,
                                    width: 18,
                                    color: Colors.white),
                              ),
                              AppGaps.wGap16,
                              Expanded(
                                  child: Text(
                                'Delivery time: 12:52',
                                style: Theme.of(context).textTheme.labelLarge,
                              ))
                            ],
                          ),
                        )),
                        /* <---- Vertical line and Address, distance, pickup is arranged 
                         text column row ----> */
                        SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.only(left: 40),
                            padding: const EdgeInsets.only(left: 34),
                            decoration: const BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: AppColors.primaryColor))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              /* <---- 'Address, distance from you, pickup arranged' text 
                               column ----> */
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Dumbo Street, New York, USA',
                                    style: TextStyle(
                                        color: AppColors.bodyTextColor),
                                  ),
                                  AppGaps.hGap8,
                                  Row(
                                    children: [
                                      Text(
                                        AppLanguageTranslation
                                            .distanceFromYouTransKey
                                            .toCurrentLanguage,
                                        style: const TextStyle(
                                            color: AppColors.bodyTextColor),
                                      ),
                                      const Text(
                                        '238m',
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  AppGaps.hGap8,
                                  Text(
                                    AppLanguageTranslation
                                        .pickupArrangedTransKey
                                        .toCurrentLanguage,
                                    style: const TextStyle(
                                        color: AppColors.bodyTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        /* <---- Location icon and customer address text row ----> */
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 34,
                                width: 34,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 6),
                                          color: AppColors.primaryColor
                                              .withOpacity(0.35),
                                          blurRadius: 15)
                                    ]),
                                child: SvgPicture.asset(
                                    AppAssetImages.locationSVGLogoLine,
                                    height: 18,
                                    width: 18,
                                    color: Colors.white),
                              ),
                              AppGaps.wGap16,
                              Expanded(
                                  child: Text(
                                'Central Residence',
                                style: Theme.of(context).textTheme.labelLarge,
                              ))
                            ],
                          ),
                        )),
                        /* <---- Delivering product list ----> */
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 74, bottom: 16, right: 24),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      image: DecorationImage(
                                          image: Image.asset(
                                                  'assets/images/demo_images/recent_payment/image1.png')
                                              .image)),
                                ),
                                AppGaps.wGap8,
                                const Expanded(child: Text('Beat Solo 48Jk')),
                                const Text(
                                  r'$36.00',
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          );
                        }, childCount: 10)),
                        const SliverToBoxAdapter(child: AppGaps.hGap24),
                        /* <---- 'Sub total' and it's price row ----> */
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .subTotalTransKey.toCurrentLanguage,
                                style:
                                    const TextStyle(color: AppColors.darkColor),
                              ),
                              const Text(r'$67.00'),
                            ],
                          ),
                        )),
                        const SliverToBoxAdapter(child: AppGaps.hGap18),
                        /* <---- Horizontal dashed line ----> */
                        const SliverToBoxAdapter(
                            child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: CustomHorizontalDashedLineWidget(
                              color: AppColors.lineShapeColor),
                        )),
                        const SliverToBoxAdapter(child: AppGaps.hGap16),
                        /* <---- 'Service fee' and it's price row ----> */
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .serviceFeeTransKey.toCurrentLanguage,
                                style:
                                    const TextStyle(color: AppColors.darkColor),
                              ),
                              const Text(r'$2.00'),
                            ],
                          ),
                        )),
                        const SliverToBoxAdapter(child: AppGaps.hGap18),
                        /* <---- Horizontal dashed line ----> */
                        const SliverToBoxAdapter(
                            child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: CustomHorizontalDashedLineWidget(
                              color: AppColors.lineShapeColor),
                        )),
                        const SliverToBoxAdapter(child: AppGaps.hGap16),
                        /* <---- 'Amount to pay' and it's price row ----> */
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .amountToPayTransKey.toCurrentLanguage,
                                style:
                                    const TextStyle(color: AppColors.darkColor),
                              ),
                              const Text(r'$69.00'),
                            ],
                          ),
                        )),
                        // Bottom extra spaces
                        const SliverToBoxAdapter(child: AppGaps.hGap30),
                      ]),
                    ),
                  ),
                  /* <---- Content behind the bottom slider panel ----> */
                  body: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                            /* <---- Demo map location background image ----> */
                            image: Image.asset(AppAssetImages
                                    .deliveryInfoBackgroundDemoImage)
                                .image)),
                  ),
                ),
              ),
            ));
  }
}
