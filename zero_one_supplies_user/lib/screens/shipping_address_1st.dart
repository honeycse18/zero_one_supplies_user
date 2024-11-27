import 'package:ecomik/controller/shipping_address_1st_screen_controller.dart';
import 'package:ecomik/models/api_responses/pickup_stations_with_cost_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/local_models/delivery_pickup_time.dart';
import 'package:ecomik/models/local_models/local_data.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/cart_screen_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/shipping_address_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ShippingAddress1stScreen extends StatelessWidget {
  const ShippingAddress1stScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShippingAddress1stScreenController>(
        global: false,
        init: ShippingAddress1stScreenController(),
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
                    hasBackButton: true,
                    titleWidget: Text(LanguageHelper.currentLanguageText(
                        LanguageHelper.shippingAddressTransKey))),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: AppGaps.hGap15),
                      /* <---- Product picture ----> */
                      SliverToBoxAdapter(
                        child: Container(
                          height: 68,
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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomTabToggleButtonWidget(
                                      text: LanguageHelper.currentLanguageText(
                                          LanguageHelper.homeDeliveryTransKey),
                                      isSelected:
                                          !controller.isPickUpPointTabSelected,
                                      onTap: controller.onHomeDeliveryTabTap),
                                ),
                              ),
                              AppGaps.wGap5,
                              /* <---- Product Won Auctions tab button ----> */
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomTabToggleButtonWidget(
                                      text: LanguageHelper.currentLanguageText(
                                          LanguageHelper.pickUpPointTransKey),
                                      isSelected:
                                          controller.isPickUpPointTabSelected,
                                      onTap: controller.onPickupPointTabTap),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap24),
                      if (controller.isPickUpPointTabSelected)
                        SliverToBoxAdapter(
                          child: DropdownButtonFormFieldWidget<
                              PickupStationsWithCost>(
                            labelText: LanguageHelper.currentLanguageText(
                                LanguageHelper.selectPickUpPointTransKey),
                            hintText: LanguageHelper.currentLanguageText(
                                LanguageHelper.selectPointTransKey),
                            items: controller.pickupStations,
                            value: controller.selectedPickupStation,
                            // getItemText: (item) => item.name,
                            getItemChild: (item) => Row(
                              children: [
                                Expanded(
                                    child: Text(item.name,
                                        style: AppTextStyles
                                            .bodySemiboldTextStyle)),
                                AppGaps.wGap5,
                                Text(
                                    Helper.getCurrencyFormattedAmountText(
                                        item.totalCost),
                                    style: AppTextStyles.bodySemiboldTextStyle
                                        .copyWith(
                                            color: AppColors.primaryColor))
                              ],
                            ),
                            onChanged: controller.onPickupStationChanged,
                          ),
                        ),
                      if (controller.isPickUpPointTabSelected)
                        const SliverToBoxAdapter(child: AppGaps.hGap12),

                      SliverToBoxAdapter(
                          child: ShippingAddressTabContentWidget(
                        isPickUpPointTabSelected:
                            controller.isPickUpPointTabSelected,
                        areas: controller.areas,
                        onAreaChanged: controller.onAreaChanged,
                        selectedArea: controller.selectedArea,
                        selectedPickupStation: controller.selectedPickupStation,
                        pickupStations: controller.pickupStations,
                        onPickupStationChanged: controller.onPickupAreaChanged,
                        showHomeDeliveryEstimatedDeliveryDate:
                            controller.showHomeDeliveryEstimatedDelivery,
                        selectedSavedAddress: controller.selectedSavedAddress,
                        savedAddresses: controller.savedAddresses,
                        onSavedAddressChanged: controller.onSavedAddressChanged,
                        homeDeliveryEstimatedDeliveryDate: controller
                            .homeDeliveryEstimatedDeliveryDateTimeForView,
                        showPickupPointEstimatedDeliveryDate:
                            controller.showPickupPointEstimatedDelivery,
                        pickupPointEstimatedDeliveryDate: controller
                            .pickupPointEstimatedDeliveryDateTimeForView,
                        onSeeAllPickupPointButtonTap:
                            controller.onSeeAllPickupPointButtonTap,
                        onSeeAllSavedAddressButtonTap:
                            controller.onSeeAllSavedAddressesButtonTap,
                      )),
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
                        MultiSliver(children: [
                          const SliverToBoxAdapter(child: AppGaps.hGap26),
                          SliverToBoxAdapter(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper
                                        .preferredDeliveryTimeTransKey),
                                style: AppTextStyles.headLine6BoldTextStyle),
                          )),
                          const SliverToBoxAdapter(child: AppGaps.hGap10),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                              /// Single cart product
                              final DeliveryPickupTime deliveryPickupTime =
                                  LocalData.localDeliveryPickupTimes[index];
                              return SliverListItemWidget(
                                currentIndex: index,
                                dividerWidget:
                                    const CustomHorizontalDashedLineWidget(
                                        color: AppColors.lineShapeColor),
                                listLength:
                                    LocalData.localDeliveryPickupTimes.length,
                                itemWidget: DeliveryTimeWidget(
                                  deliveryPickupTime: deliveryPickupTime,
                                  selectedDeliveryPickupTime:
                                      controller.selectedDeliveryPickupTime,
                                  onTap: () =>
                                      controller.onDeliveryPickUpItemTap(
                                          deliveryPickupTime),
                                  onRadioChanged: (value) =>
                                      controller.onDeliveryPickUpItemTap(
                                          deliveryPickupTime),
                                ),
                              );
                            },
                                    childCount: LocalData
                                        .localDeliveryPickupTimes.length)),
                          ),
                          const SliverToBoxAdapter(child: AppGaps.hGap6)
                        ]),
                      ]),
                      const SliverToBoxAdapter(child: AppGaps.hGap24),
                      SliverToBoxAdapter(
                          child: Text(
                              LanguageHelper.currentLanguageText(
                                  LanguageHelper.productDetailsTransKey),
                              style: AppTextStyles.headLine6BoldTextStyle)),
                      const SliverToBoxAdapter(child: AppGaps.hGap8),
/*                       SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) {
                        /// Single cart product
                        final cartProduct =
                            controller.cartsData.cart.products[index];
                        return SliverListItemWidget(
                          currentIndex: index,
                          dividerWidget: AppGaps.hGap16,
                          listLength: controller.cartsData.cart.products.length,
                          itemWidget: CartProductWidget(
                            categoryName: cartProduct.categories.name,
                            image: cartProduct.image,
                            name: cartProduct.name,
                            price: cartProduct.subtotal,
                            quantity: cartProduct.quantity,
                          ),
                        );
                      },
                              childCount:
                                  controller.cartsData.cart.products.length)), */
                      SliverList.separated(
                        itemBuilder: (context, index) {
                          /// Single cart product
                          final cart = controller.cartsData.carts[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                          '${AppLanguageTranslation.storeNameTransKey.toCurrentLanguage}: ${cart.store.name}')),
                                  Text(
                                      '${AppLanguageTranslation.subTotalTransKey.toCurrentLanguage}: ${Helper.getCurrencyFormattedAmountText(cart.total)}')
                                ],
                              ),
                              AppGaps.hGap12,
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  /// Single cart product
                                  final StoreWiseCartProduct cartProduct =
                                      cart.products[index];
                                  return CartNoInteractableItemWidget(
                                    index: index,
                                    image: cartProduct.image,
                                    categoryName: cartProduct.categories.name,
                                    name: cartProduct.name,
                                    price: cartProduct.price,
                                    quantity: cartProduct.quantity,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                                itemCount: cart.products.length,
                              ),
                              AppGaps.hGap12,
                              if (cart.couponInfo.saveMoney != 0)
                                Text(
                                    '${AppLanguageTranslation.savedCouponAmountTransKey.toCurrentLanguage} ${Helper.getCurrencyFormattedAmountText(cart.couponInfo.saveMoney)}',
                                    style: AppTextStyles.bodyTextStyle),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap16,
                        itemCount: controller.cartsData.carts.length,
                      ),

                      const SliverToBoxAdapter(child: AppGaps.hGap24),
                      SliverToBoxAdapter(
                        child: CartAmountsAndButtonWidget(
                            subtotalAmount: controller.netPriceAmountForView,
                            discountAmount: controller.discountAmountForView,
                            vatAmount: controller.vatAmountForView,
                            totalAmount:
                                controller.totalAmountForView.toDouble(),
                            showDeliveryCharge:
                                controller.showDeliveryChargeSectionForView,
                            deliveryChargeAmount:
                                controller.deliveryChargeAmountForView,
                            additionalCartAmountWidgets: [
                              CartAmountWidget(
                                  name: LanguageHelper.currentLanguageText(
                                      LanguageHelper.shippingChargeTransKey),
                                  amount: controller.shippingChargeForView),
                              AppGaps.hGap8,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '${LanguageHelper.currentLanguageText(LanguageHelper.distanceFareTransKey)}: ${controller.distanceFareForView}',
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.bodyTextColor),
                                  ),
                                  AppGaps.hGap8,
                                  Text(
                                    '${LanguageHelper.currentLanguageText(LanguageHelper.deliveryDistanceTransKey)}: ${controller.deliveryDistanceForView}',
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.bodyTextColor),
                                  ),
                                  AppGaps.hGap8,
                                  Text(
                                    '${LanguageHelper.currentLanguageText(LanguageHelper.transactionFeeTransKey)}: ${controller.transactionFeeForView}',
                                    style: AppTextStyles.bodyTextStyle.copyWith(
                                        color: AppColors.bodyTextColor),
                                  ),
                                ],
                              ),
                              AppGaps.hGap8,
                            ],
                            isLoading: controller.isLoading,
                            buttonText: LanguageHelper.currentLanguageText(
                                LanguageHelper.proceedToPaymentTransKey),
                            onButtonTap:
                                controller.onProceedToPaymentButtonTap),
                      ),
                      // Bottom extra spaces
                      const SliverToBoxAdapter(child: AppGaps.hGap30),
                    ],
                  ),
                ),
              ),
            ));
  }
}
