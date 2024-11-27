import 'package:ecomik/controller/all_pickup_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/shipping_address_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AllPickupScreen extends StatelessWidget {
  const AllPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllPickupScreenController>(
        init: AllPickupScreenController(),
        builder: (controller) => DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: Image.asset(AppAssetImages.backgroundFullPng).image,
                    fit: BoxFit.fill)),
            child: Scaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleWidget: Text(AppLanguageTranslation
                      .allPickupPointTransKey.toCurrentLanguage)),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                child: Column(children: [
                  Expanded(
                      child: CustomScrollView(
                    slivers: [
/* ListView.separated(
                          itemBuilder: (context, index) {
                            final SiteSettingsPickupArea pickupArea =
                                AppSingleton
                                    .instance.settings.pickupArea[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pickupArea.location,
                                  style:
                                      AppTextStyles.bodyLargeSemiboldTextStyle,
                                ),
                                AppGaps.hGap2,
                                Text(pickupArea.address,
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.bodyTextColor)),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const CustomHorizontalDashedLineWidget(
                                  color: AppColors.lineShapeColor),
                          itemCount: AppSingleton
                              .instance.settings.pickupArea.length) */
                      SliverToBoxAdapter(
                        child: CustomTextFormField(
                            hasShadow: true,
                            onChanged: controller.onSearchChange,
                            hintText: AppLanguageTranslation
                                .searchPickupPointTransKey.toCurrentLanguage,
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.searchSVGLogoLine,
                                color: AppColors.primaryColor)),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap24),
                      SliverStack(children: [
                        SliverPositioned.fill(
                            child: Container(
                          padding: const EdgeInsets.fromLTRB(16, 26, 16, 16),
                          decoration: BoxDecoration(
                              color: Color.lerp(Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.4), 0.5),
                              border: Border.all(color: Colors.white),
                              borderRadius: AppComponents.borderRadius(18)),
                        )),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          sliver: SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            final pickupArea = controller.pickupAreas[index];
                            return SliverListItemWidget(
                                itemWidget: CustomRawListTileWidget(
                                    onTap: () {},
                                    child: PickupPointWidget(
                                        selectedPickupPointID:
                                            controller.selectedPickUpArea?.id,
                                        onTap: () => controller
                                            .onPickupAreaItemTap(pickupArea),
                                        onRadioChanged: (value) => controller
                                            .onPickupAreaItemTap(pickupArea),
                                        pickupAreaAddress: pickupArea.address,
                                        pickupAreaLocation: pickupArea.location,
                                        pickupAreaID: pickupArea.id)),
                                dividerWidget:
                                    const CustomHorizontalDashedLineWidget(
                                        color: AppColors.lineShapeColor),
                                currentIndex: index,
                                listLength: controller.pickupAreas.length);
                          }, childCount: controller.pickupAreas.length)),
                        ),
                      ]),
                    ],
                  )),
                ]),
              ),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .confirmOrderTransKey.toCurrentLanguage,
                      onTap: controller.selectedPickUpArea == null
                          ? null
                          : controller.onConfirmButtonTap)),
            )));
  }
}
