import 'package:ecomik/controller/add_address_controller.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressScreenController>(
        init: AddAddressScreenController(),
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
                    titleWidget: Text(controller.screenTitle)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top extra spaces
                        AppGaps.hGap15,
                        /* <---- Edit your home address ----> */
                        CustomTextFormField(
                            controller: controller.nameController,
                            labelText: AppLanguageTranslation
                                .nameTransKey.toCurrentLanguage,
                            hintText: AppLanguageTranslation
                                .enterAddressNameTransKey.toCurrentLanguage,
                            prefixIcon: AppGaps.emptyGap),
                        AppGaps.hGap24,
                        /* <---- Edit your email address ----> */
                        CustomTextFormField(
                          controller: controller.phoneController,
                          labelText: AppLanguageTranslation
                              .phoneTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .enterPhoneNumberTransKey.toCurrentLanguage,
                          prefixIcon: AppGaps.emptyGap,
                        ),
                        AppGaps.hGap24,
                        /* <---- Edit your date of birth ----> */
                        CustomTextFormField(
                          controller: controller.provinceController,
                          labelText: AppLanguageTranslation
                              .provinceTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .enterProvinceTransKey.toCurrentLanguage,
                          prefixIcon: AppGaps.emptyGap,
                        ),
                        AppGaps.hGap24,
                        CustomTextFormField(
                          controller: controller.cityController,
                          labelText: AppLanguageTranslation
                              .cityTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .enterCityTransKey.toCurrentLanguage,
                          prefixIcon: AppGaps.emptyGap,
                        ),
                        AppGaps.hGap24,
                        CustomTextFormField(
                          controller: controller.areaController,
                          labelText: AppLanguageTranslation
                              .areaTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .enterAreaTransKey.toCurrentLanguage,
                          prefixIcon: AppGaps.emptyGap,
                        ),
                        AppGaps.hGap24,
                        CustomTextFormField(
                          controller: controller.addressController,
                          labelText: AppLanguageTranslation
                              .addressTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .enterAddressNameTransKey.toCurrentLanguage,
                          minLines: 2,
                          maxLines: 3,
                          prefixIcon: AppGaps.emptyGap,
                        ),
                        AppGaps.hGap24,
                        Text(
                            AppLanguageTranslation
                                .addressTypeTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle),
                        AppGaps.hGap12,
                        Row(
                          children: [
                            RadioTextWidget(
                              text: AppLanguageTranslation
                                  .homeTransKey.toCurrentLanguage,
                              value: SavedAddressDeliveryType.home,
                              groupValue: controller.addressType,
                              onChanged: (value) {
                                if (value is SavedAddressDeliveryType) {
                                  controller.addressType = value;
                                  controller.update();
                                }
                              },
                              onTextTap: () {
                                controller.addressType =
                                    SavedAddressDeliveryType.home;
                                controller.update();
                              },
                            ),
                            AppGaps.wGap50,
                            RadioTextWidget(
                              text: AppLanguageTranslation
                                  .officeTransKey.toCurrentLanguage,
                              value: SavedAddressDeliveryType.office,
                              groupValue: controller.addressType,
                              onChanged: (value) {
                                if (value is SavedAddressDeliveryType) {
                                  controller.addressType = value;
                                  controller.update();
                                }
                              },
                              onTextTap: () {
                                controller.addressType =
                                    SavedAddressDeliveryType.office;
                                controller.update();
                              },
                            )
                          ],
                        ),
                        AppGaps.hGap24,
                        Text(
                            AppLanguageTranslation
                                .shippingAndBillingTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle),
                        AppGaps.hGap12,
                        Obx(() => CheckboxTextWidget(
                              text: AppLanguageTranslation
                                  .defaultShippingAddressTransKey
                                  .toCurrentLanguage,
                              value: controller.isDefaultShippingAddress.value,
                              onChanged: (value) {
                                if (value is bool) {
                                  controller.isDefaultShippingAddress.value =
                                      value;
                                }
                              },
                              onTextTap: () {
                                controller.isDefaultShippingAddress.value =
                                    !controller.isDefaultShippingAddress.value;
                              },
                            )),
                        AppGaps.hGap12,
                        Obx(() => CheckboxTextWidget(
                              text: AppLanguageTranslation
                                  .defaultBillingAddressTransKey
                                  .toCurrentLanguage,
                              value: controller.isDefaultBillingAddress.value,
                              onChanged: (value) {
                                if (value is bool) {
                                  controller.isDefaultBillingAddress.value =
                                      value;
                                }
                              },
                              onTextTap: () {
                                controller.isDefaultBillingAddress.value =
                                    !controller.isDefaultBillingAddress.value;
                              },
                            )),
                        AppGaps.hGap24,
                        CustomTextFormField(
                          controller: controller.landmarkController,
                          labelText: AppLanguageTranslation
                              .landMarkTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .enterLandMarkTransKey.toCurrentLanguage,
                          prefixIcon: AppGaps.emptyGap,
                        ),
                        AppGaps.hGap24,
                        CustomTextFormField(
                          controller: controller.countryController,
                          labelText: AppLanguageTranslation
                              .countryTransKey.toCurrentLanguage,
                          hintText: AppLanguageTranslation
                              .enterCountryTransKey.toCurrentLanguage,
                          prefixIcon: AppGaps.emptyGap,
                        ),
                        AppGaps.hGap24,
                        Obx(() => CheckboxTextWidget(
                              text: AppLanguageTranslation
                                  .setPrimaryAddressTransKey.toCurrentLanguage,
                              value: controller.isAddressPrimary.value,
                              onChanged: (value) {
                                if (value is bool) {
                                  controller.isAddressPrimary.value = value;
                                }
                              },
                              onTextTap: () {
                                controller.isAddressPrimary.value =
                                    !controller.isAddressPrimary.value;
                              },
                            )),

                        AppGaps.hGap30,
                      ],
                    ),
                  ),
                ),
                /* <-------- Bottom button column of 'save changes' and 'cancel' --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomStretchedButtonWidget(
                      onTap: controller.onSaveAddressTap,
                      isLoading: controller.isLoading,
                      child: Text(controller.bottomButtonText),
                    ),
                    AppGaps.hGap3,
                    CustomStretchedOnlyTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .cancelTransKey.toCurrentLanguage,
                      onTap: controller.onCancelTap,
                    ),
                  ],
                )),
              ),
            ));
  }
}
