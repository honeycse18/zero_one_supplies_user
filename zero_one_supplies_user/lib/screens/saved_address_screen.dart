import 'package:ecomik/controller/saved_address_screen_controller.dart';
import 'package:ecomik/models/api_responses/saved_address_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/saved_address_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedAddressScreenController>(
        init: SavedAddressScreenController(),
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
                        .savedAddressTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  /* <---- Saved address card list ----> */
                  child: controller.savedAddresses.isEmpty
                      ? SingleChildScrollView(
                          child: Center(
                            child: EmptyScreenWidget(
                              localImageAssetURL: AppAssetImages.emptyAddress,
                              title: AppLanguageTranslation
                                  .noAddressAddedTransKey.toCurrentLanguage,
                              shortTitle: AppLanguageTranslation
                                  .addAddressNowTransKey.toCurrentLanguage,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await controller.getSavedAddresses();
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final SavedAddress savedAddress =
                                        controller.savedAddresses[index];
                                    return SliverListItemWidget(
                                      dividerWidget: AppGaps.hGap24,
                                      currentIndex: index,
                                      listLength:
                                          controller.savedAddresses.length,
                                      itemWidget: SavedAddressCardWidget(
                                        isSelectable: controller
                                            .isFromShippingAddressScreen,
                                        isSelected:
                                            controller.isSavedAddressSelected(
                                                savedAddress),
                                        onTap: () => controller
                                            .onSavedAddressTap(savedAddress),
                                        deliveryType: SavedAddressDeliveryType
                                            .toEnumValue(savedAddress.delivery),
                                        addressText:
                                            (savedAddress.addressText()),
                                        onEditTap: () => controller
                                            .onAddressEditTap(savedAddress),
                                        onDeleteTap: () => controller
                                            .onAddressDeleteTap(savedAddress),
                                      ),
                                    );
                                  },
                                  childCount: controller.savedAddresses.length,
                                ),
                              ),
                              const SliverToBoxAdapter(child: AppGaps.hGap30),
                            ],
                          ),
                        ),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: controller.isFromShippingAddressScreen
                        ? Row(
                            children: [
                              Expanded(
                                  child: CustomStretchedTextButtonWidget(
                                onTap: controller.selectedSavedAddress == null
                                    ? null
                                    : controller.onConfirmTap,
                                buttonText: AppLanguageTranslation
                                    .confirmOrderTransKey.toCurrentLanguage,
                              )),
                              AppGaps.wGap15,
                              Expanded(
                                  child:
                                      CustomStretchedOutlinedTextButtonWidget(
                                onTap: controller.onAddNewAddressTap,
                                buttonText: AppLanguageTranslation
                                    .addNewAddressTransKey.toCurrentLanguage,
                              ))
                            ],
                          )
                        : CustomStretchedButtonWidget(
                            onTap: controller.onAddNewAddressTap,
                            child: Text(AppLanguageTranslation
                                .addNewAddressTransKey.toCurrentLanguage),
                          )),
              ),
            ));
  }
}
