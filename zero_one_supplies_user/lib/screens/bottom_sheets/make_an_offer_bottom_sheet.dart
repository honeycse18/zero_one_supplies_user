import 'package:ecomik/controller/bottom_sheets/make_an_offer_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeAnOfferBottomSheet extends StatelessWidget {
  const MakeAnOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MakeOfferBottomSheetController>(
        init: MakeOfferBottomSheetController(),
        global: false,
        builder: (controller) => SizedBox(
              height: context.height * 0.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Scaffold(
                  backgroundColor: AppColors.backgroundColor,
                  appBar: CoreWidgets.appBarWidget(
                      screenContext: context,
                      hasBackButton: true,
                      titleWidget: Text(AppLanguageTranslation
                          .makeAnOfferTransKey.toCurrentLanguage)),
                  body: CustomScaffoldBodyWidget(
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.detailsKey,
                        child: Column(
                          children: [
                            AppGaps.hGap20,
                            CustomTextFormField(
                              validator: controller.priceValidator,
                              controller: controller.priceController,
                              labelText: AppLanguageTranslation
                                  .enterOfferAmountTransKey.toCurrentLanguage,
                              hasShadow: false,
                              hintText: r'$10000',
                            ),
                            AppGaps.hGap20,
                            Row(
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .productCountTransKey.toCurrentLanguage,
                                  style: AppTextStyles.bodyLargeMediumTextStyle,
                                )
                              ],
                            ),
                            AppGaps.hGap8,
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.lineShapeColor),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Obx(() => PlusMinusCounterRow(
                                      onRemoveTap: controller.onRemoveButtonTap,
                                      onAddTap: controller.onAddButtonTap,
                                      counterText:
                                          '${controller.productCount.value}')),
                                ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  bottomNavigationBar: CustomScaffoldBottomBarWidget(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomStretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .sendOffersTransKey.toCurrentLanguage,
                        onTap: controller.sendAnOffer,
                        isLoading: controller.isLoading,
                      ),
                      AppGaps.hGap10,
                    ],
                  )),
                ),
              ),
            ));
  }
}
