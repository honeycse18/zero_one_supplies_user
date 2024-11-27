import 'package:ecomik/controller/add_new_card_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  /// Toggle value card text obscure

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewCardScreenController>(
        init: AddNewCardScreenController(),
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
                        .addNewCardTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppGaps.hGap15,
                      /* <---- Name on card text field ----> */
                      CustomTextFormField(
                        labelText: AppLanguageTranslation
                            .nameOnCardTransKey.toCurrentLanguage,
                        prefixIcon:
                            SvgPicture.asset(AppAssetImages.cardSVGLogoLine),
                        hintText: AppLanguageTranslation
                            .cardNameTransKey.toCurrentLanguage,
                      ),
                      AppGaps.hGap24,
                      /* <---- Card number text field ----> */
                      Obx(() => CustomTextFormField(
                            labelText: AppLanguageTranslation
                                .cardNumberTransKey.toCurrentLanguage,
                            isPasswordTextField:
                                controller.isCardTextObscure.value,
                            prefixIcon: SvgPicture.asset(
                                AppAssetImages.cardEditSVGLogoLine),
                            hintText: '**** **** **** ****',
                            textInputType: TextInputType.number,
                            suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                    AppAssetImages.hideSVGLogoLine,
                                    color: controller.isCardTextObscure.value
                                        ? AppColors.bodyTextColor
                                        : AppColors.primaryColor),
                                onPressed: () {
                                  // setState(() {
                                  controller.isCardTextObscure.value =
                                      !controller.isCardTextObscure.value;
                                  controller.update();
                                  // });
                                }),
                          )),
                      AppGaps.hGap24,
                      /* <---- Expiration and CVV text field row ----> */
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              /* <---- Expiration date text field ----> */
                              child: CustomTextFormField(
                                labelText: AppLanguageTranslation
                                    .expirationTransKey.toCurrentLanguage,
                                prefixIcon: SvgPicture.asset(
                                    AppAssetImages.cardSVGLogoLine),
                                hintText: '02/11/21',
                                textInputType: TextInputType.datetime,
                              ),
                            ),
                            AppGaps.wGap16,
                            Expanded(
                              /* <---- CVV text field ----> */
                              child: CustomTextFormField(
                                labelText: 'Cvv',
                                prefixIcon: SvgPicture.asset(
                                    AppAssetImages.editSVGLogoLine),
                                hintText: '399',
                                textInputType: TextInputType.number,
                              ),
                            )
                          ]),
                      AppGaps.hGap24,
                      /* <---- Postal code text field ----> */
                      CustomTextFormField(
                        labelText: AppLanguageTranslation
                            .postalCodeTransKey.toCurrentLanguage,
                        prefixIcon: SvgPicture.asset(
                            AppAssetImages.routeSquareSVGLogoLine),
                        hintText: '6350',
                        textInputType: TextInputType.number,
                      ),
                      // Bottom extra spaces
                      AppGaps.hGap30,
                    ],
                  )),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .addNewCardTransKey.toCurrentLanguage,
                      onTap: () {
                        Get.toNamed(AppPageNames.orderSuccessScreen);
                      }),
                ),
              ),
            ));
  }
}
