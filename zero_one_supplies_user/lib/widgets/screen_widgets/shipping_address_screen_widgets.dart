import 'package:ecomik/models/api_responses/pickup_stations_with_cost_response.dart';
import 'package:ecomik/models/api_responses/saved_addresses_with_cost_response.dart';
import 'package:ecomik/models/api_responses/site_settings_response.dart';
import 'package:ecomik/models/local_models/delivery_pickup_time.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class CartProductWidget extends StatelessWidget {
  final String image;
  final String name;
  final String categoryName;
  final double price;
  final int quantity;
  final void Function()? onTap;
  const CartProductWidget({
    super.key,
    this.onTap,
    required this.image,
    required this.name,
    required this.categoryName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        paddingValue: const EdgeInsets.all(8),
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImageWidget(
                  imageURL: image,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: imageProvider),
                            borderRadius:
                                const BorderRadius.all((Radius.circular(16)))),
                      )),
            ),
            AppGaps.wGap16,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  AppGaps.hGap2,
                  Text(categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.bodyTextColor, fontSize: 12)),
                  AppGaps.hGap8,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            Helper.getCurrencyFormattedAmountText(price),
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      Text(
                        '${AppLanguageTranslation.qtyTransKey.toCurrentLanguage}: $quantity',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class EstimatedDeliveryWidget extends StatelessWidget {
  const EstimatedDeliveryWidget({
    super.key,
    required this.estimatedDeliveryDate,
  });

  final String estimatedDeliveryDate;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: AppComponents.defaultBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Estimated delivery',
                style: AppTextStyles.headLine6BoldTextStyle),
            AppGaps.hGap4,
            Text(estimatedDeliveryDate,
                style: AppTextStyles.bodyMediumTextStyle
                    .copyWith(color: AppColors.bodyTextColor)),
          ],
        ));
  }
}

class ShippingAddressTabContentWidget extends StatelessWidget {
  final bool isPickUpPointTabSelected;
  final SiteSettingsDeliveryArea? selectedArea;
  final List<SiteSettingsDeliveryArea> areas;
  final void Function(SiteSettingsDeliveryArea?)? onAreaChanged;
  final PickupStationsWithCost? selectedPickupStation;
  final List<PickupStationsWithCost> pickupStations;
  final SavedAddressWithCost? selectedSavedAddress;
  final List<SavedAddressWithCost> savedAddresses;
  final void Function(SavedAddressWithCost?)? onSavedAddressChanged;
  final void Function()? onSeeAllPickupPointButtonTap;
  final void Function()? onSeeAllSavedAddressButtonTap;
  final void Function(PickupStationsWithCost?)? onPickupStationChanged;
  final bool showHomeDeliveryEstimatedDeliveryDate;
  final String homeDeliveryEstimatedDeliveryDate;
  final bool showPickupPointEstimatedDeliveryDate;
  final String pickupPointEstimatedDeliveryDate;
  const ShippingAddressTabContentWidget({
    super.key,
    this.isPickUpPointTabSelected = false,
    this.selectedArea,
    required this.areas,
    this.onAreaChanged,
    this.onSeeAllPickupPointButtonTap,
    this.onPickupStationChanged,
    this.selectedPickupStation,
    required this.pickupStations,
    required this.showPickupPointEstimatedDeliveryDate,
    required this.pickupPointEstimatedDeliveryDate,
    required this.showHomeDeliveryEstimatedDeliveryDate,
    required this.homeDeliveryEstimatedDeliveryDate,
    this.onSeeAllSavedAddressButtonTap,
    this.selectedSavedAddress,
    required this.savedAddresses,
    this.onSavedAddressChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (isPickUpPointTabSelected) {
      // Pick up point tab content
      return Column(mainAxisSize: MainAxisSize.min, children: [
/*         DropdownButtonFormFieldWidget<PickupStation>(
          labelText: 'Select pick up point',
          hintText: 'Select location',
          isDense: false,
          items: pickupStations,
          value: selectedPickupStation,
          getItemChild: (item) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: AppTextStyles.bodyLargeSemiboldTextStyle,
              ),
              AppGaps.hGap2,
              Text(item.address,
                  style: AppTextStyles.bodyTextStyle
                      .copyWith(color: AppColors.bodyTextColor)),
            ],
          ),
          onChanged: onPickupStationChanged,
        ),
        AppGaps.hGap5,
        CustomStretchedOutlinedTextButtonWidget(
            minHeight: 48,
            borderRadiusValue: 12,
            buttonText: 'See all pickup point',
            onTap: onSeeAllPickupPointButtonTap), */
        // AppGaps.hGap24,
        if (showPickupPointEstimatedDeliveryDate)
          EstimatedDeliveryWidget(
              estimatedDeliveryDate: pickupPointEstimatedDeliveryDate),
      ]);
    }
    // Home delivery tab content
    return Column(mainAxisSize: MainAxisSize.min, children: [
      DropdownButtonFormFieldWidget<SavedAddressWithCost>(
        labelText: 'Select saved address',
        hintText: 'Select address',
        isDense: false,
        items: savedAddresses,
        value: selectedSavedAddress,
        getItemChild: (item) => Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.delivery,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ),
                  AppGaps.hGap2,
                  Text(item.address,
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(color: AppColors.bodyTextColor)),
                ],
              ),
            ),
            AppGaps.wGap5,
            Text(
              Helper.getCurrencyFormattedAmountText(item.totalCost),
              style: AppTextStyles.bodyLargeSemiboldTextStyle
                  .copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
        onChanged: onSavedAddressChanged,
      ),
      AppGaps.hGap5,
      CustomStretchedOutlinedTextButtonWidget(
          minHeight: 48,
          borderRadiusValue: 12,
          buttonText: 'See all saved address',
          onTap: onSeeAllSavedAddressButtonTap),
      AppGaps.hGap24,
/*       DropdownButtonFormFieldWidget<SiteSettingsDeliveryArea>(
        labelText: 'Select area',
        hintText: 'Select area',
        items: areas,
        value: selectedArea,
        getItemText: (item) => item.name,
        onChanged: onAreaChanged,
      ),
      AppGaps.hGap12, */
      if (showHomeDeliveryEstimatedDeliveryDate)
        EstimatedDeliveryWidget(
            estimatedDeliveryDate: homeDeliveryEstimatedDeliveryDate),
    ]);
  }
}

class PickupPointWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? selectedPickupPointID;
  final void Function(Object?) onRadioChanged;
  final String pickupAreaID;
  final String pickupAreaLocation;
  final String pickupAreaAddress;
  const PickupPointWidget({
    super.key,
    this.onTap,
    this.selectedPickupPointID,
    required this.onRadioChanged,
    required this.pickupAreaLocation,
    required this.pickupAreaAddress,
    required this.pickupAreaID,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        borderRadiusRadiusValue:
            const Radius.circular(Constants.smallBorderRadiusValue),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pickupAreaLocation,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ),
                  AppGaps.hGap2,
                  Text(pickupAreaAddress,
                      style: AppTextStyles.bodyTextStyle
                          .copyWith(color: AppColors.bodyTextColor)),
                ],
              )),
              CustomRadioWidget(
                  value: pickupAreaID,
                  groupValue: selectedPickupPointID,
                  onChanged: onRadioChanged),
            ],
          ),
        ));
  }
}

class DeliveryTimeWidget extends StatelessWidget {
  final void Function()? onTap;
  final DeliveryPickupTime? selectedDeliveryPickupTime;
  final void Function(Object?) onRadioChanged;
  const DeliveryTimeWidget({
    super.key,
    required this.deliveryPickupTime,
    this.onTap,
    this.selectedDeliveryPickupTime,
    required this.onRadioChanged,
  });

  final DeliveryPickupTime deliveryPickupTime;

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        borderRadiusRadiusValue:
            const Radius.circular(Constants.smallBorderRadiusValue),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                  child: Text(deliveryPickupTime.timeText,
                      style: AppTextStyles.bodyLargeMediumTextStyle)),
              CustomRadioWidget(
                  value: deliveryPickupTime.id,
                  groupValue: selectedDeliveryPickupTime?.id,
                  onChanged: onRadioChanged),
            ],
          ),
        ));
  }
}
