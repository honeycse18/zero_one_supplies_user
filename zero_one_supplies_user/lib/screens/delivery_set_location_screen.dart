import 'package:ecomik/controller/delivery_set_location_controller.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/delivery_set_location_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliverySetLocationScreen extends StatelessWidget {
  const DeliverySetLocationScreen({super.key});

  /// Bottom slider panel controller

  /* <-------- Initial state --------> */

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    // Hide bottom bar if bottom slider panel shows

    return GetBuilder<DeliverySetLocationScreenController>(
        init: DeliverySetLocationScreenController(),
        builder: (controller) {
          if (controller.panelController.isAttached) {
            controller.panelController.isPanelShown
                ? controller.showBottomBar.value = false
                : controller.showBottomBar.value = true;
          }
          return Scaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.panelController.isAttached &&
                          controller.panelController.isPanelShown
                      ? AppLanguageTranslation
                          .editLocationTransKey.toCurrentLanguage
                      : AppLanguageTranslation
                          .setLocationTransKey.toCurrentLanguage),
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
                controller: controller.panelController,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                backdropEnabled: true,
                backdropColor: AppColors.lineShapeColor,
                backdropOpacity: 0.8,
                boxShadow: const [],
                color: Colors.transparent,
                maxHeight: screenSize.height * 0.70,
                minHeight: 110,
                /* <---- Top part of bottom slider ----> */
                header: SizedBox(
                  height: 30,
                  width: screenSize.width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                          top: 12,
                          child: SvgPicture.asset(
                              AppAssetImages.slideUpPanelNotchSVG,
                              color: Colors.white)),
                      Positioned(
                          top: 22,
                          child: SvgPicture.asset(
                            AppAssetImages.arrowUpSVGLogoLine,
                            color: AppColors.primaryColor.withOpacity(0.5),
                            width: 40,
                          ))
                    ],
                  ),
                ),
                /* <---- Body content of bottom slider panel ----> */
                panelBuilder: (sc) => Container(
                  margin: const EdgeInsets.only(top: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomScrollView(controller: sc, slivers: [
                      /* <---- 'Details address' text and gps button row ----> */
                      SliverToBoxAdapter(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .detailsAddressTransKey.toCurrentLanguage,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Obx(() => CustomIconButtonWidget(
                              onTap: () async {
                                // setState(() {
                                controller.showBottomBar.value = false;
                                // });
                                await controller.panelController.show();
                                await controller.panelController.open();
                                // setState(() {});
                                controller.update();
                              },
                              hasShadow: true,
                              backgroundColor: AppColors.primaryColor,
                              child: SvgPicture.asset(
                                  AppAssetImages.gpsSVGLogoLine,
                                  color: Colors.white)))
                        ],
                      )),
                      const SliverToBoxAdapter(child: AppGaps.hGap16),
                      /* <---- Home address row ----> */
                      SliverToBoxAdapter(
                          child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssetImages.locationSVGLogoLine,
                              height: 32,
                              width: 32,
                              color: AppColors.primaryColor),
                          AppGaps.wGap16,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .detailsAddressTransKey.toCurrentLanguage,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              AppGaps.hGap8,
                              const Text('238 Green summit, Australia',
                                  style:
                                      TextStyle(color: AppColors.bodyTextColor))
                            ],
                          )),
                          CustomIconButtonWidget(
                              onTap: () {},
                              child: SvgPicture.asset(
                                AppAssetImages.editSVGLogoLine,
                                height: 24,
                                width: 24,
                                color: AppColors.bodyTextColor,
                              ))
                        ],
                      )),
                      const SliverToBoxAdapter(child: AppGaps.hGap16),
                      /* <---- Horizontal dashed line ----> */
                      const SliverToBoxAdapter(
                        child: CustomHorizontalDashedLineWidget(
                            color: AppColors.lineShapeColor),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap16),
                      /* <---- Other address row ----> */
                      SliverToBoxAdapter(
                          child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssetImages.locationSVGLogoLine,
                              height: 32,
                              width: 32,
                              color: AppColors.primaryColor),
                          AppGaps.wGap16,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .otherTransKey.toCurrentLanguage,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              AppGaps.hGap8,
                              const Text('238 Green summit, Australia',
                                  style:
                                      TextStyle(color: AppColors.bodyTextColor))
                            ],
                          )),
                          CustomIconButtonWidget(
                              onTap: () {},
                              child: SvgPicture.asset(
                                AppAssetImages.editSVGLogoLine,
                                height: 24,
                                width: 24,
                                color: AppColors.bodyTextColor,
                              ))
                        ],
                      )),
                      const SliverToBoxAdapter(child: AppGaps.hGap16),
                      SliverToBoxAdapter(
                          child: Text(
                              AppLanguageTranslation
                                  .saveAddressAsTransKey.toCurrentLanguage,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: AppColors.primaryColor,
                                  ))),
                      const SliverToBoxAdapter(child: AppGaps.hGap16),
                      /* <---- Save address of 3 type (home, office, other) as toggle
                         buttons ----> */
                      SliverToBoxAdapter(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SaveAddressSelectionWidget(
                                onTap: () {
                                  // setState(() {
                                  controller.currentDeliveryLocationSetAs =
                                      DeliveryLocationSetAs.home;
                                  controller.update();
                                  // });
                                },
                                isSelected:
                                    controller.currentDeliveryLocationSetAs ==
                                        DeliveryLocationSetAs.home,
                                localSVGIconAssetName:
                                    AppAssetImages.homeSVGLogoSolid,
                                text: AppLanguageTranslation
                                    .homeTransKey.toCurrentLanguage),
                          ),
                          AppGaps.wGap18,
                          Expanded(
                            child: SaveAddressSelectionWidget(
                                onTap: () {
                                  // setState(() {
                                  controller.currentDeliveryLocationSetAs =
                                      DeliveryLocationSetAs.office;
                                  controller.update();
                                  // });
                                },
                                isSelected:
                                    controller.currentDeliveryLocationSetAs ==
                                        DeliveryLocationSetAs.office,
                                localSVGIconAssetName:
                                    AppAssetImages.building2SVGLogoLine,
                                text: AppLanguageTranslation
                                    .officeTransKey.toCurrentLanguage),
                          ),
                          AppGaps.wGap18,
                          Expanded(
                            child: SaveAddressSelectionWidget(
                                onTap: () {
                                  // setState(() {
                                  controller.currentDeliveryLocationSetAs =
                                      DeliveryLocationSetAs.other;
                                  controller.update();
                                  // });
                                },
                                isSelected:
                                    controller.currentDeliveryLocationSetAs ==
                                        DeliveryLocationSetAs.other,
                                localSVGIconAssetName:
                                    AppAssetImages.buildingsSVGLogoSolid,
                                text: AppLanguageTranslation
                                    .othersTransKey.toCurrentLanguage),
                          ),
                        ],
                      )),
                      // Bottom extra spaces
                      const SliverToBoxAdapter(child: AppGaps.hGap30),
                    ]),
                  ),
                ),
                /* <---- Content behind the bottom slider panel ----> */
                body: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                          /* <---- Background demo image ----> */
                          image: Image.asset(AppAssetImages
                                  .deliverySetLocationBackgroundDemoImage)
                              .image)),
                  child: GestureDetector(onTap: () async {
                    await controller.panelController.hide();
                    // setState(() {});
                  }),
                ),
              ),
              /* <-------- Floating right button --------> */
              floatingActionButton: controller.showBottomBar.value
                  ? CustomIconButtonWidget(
                      onTap: () async {
                        // setState(() {
                        controller.showBottomBar.value = false;
                        // });
                        await controller.panelController.show();
                        await controller.panelController.open();
                        controller.update();
                        // setState(() {});
                      },
                      hasShadow: true,
                      backgroundColor: AppColors.primaryColor,
                      child: SvgPicture.asset(AppAssetImages.gpsSVGLogoLine,
                          color: Colors.white))
                  : null,
              /* <-------- Bottom bar --------> */
              bottomNavigationBar: controller.showBottomBar.value
                  ? CustomScaffoldBottomBarWidget(
                      backgroundColor: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap15,
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppAssetImages.mapSVGLogoLine,
                                    color: AppColors.primaryColor,
                                    height: 20,
                                    width: 20),
                                AppGaps.wGap8,
                                const Text('Paris, Franch'),
                              ]),
                          AppGaps.hGap24,
                          CustomStretchedTextButtonWidget(
                              buttonText: AppLanguageTranslation
                                  .addLocationTransKey.toCurrentLanguage,
                              onTap: () {
                                controller.openBottomPanel();
                                controller.update();
                              }),
                        ],
                      ),
                    )
                  : null);
        });
  }
}
