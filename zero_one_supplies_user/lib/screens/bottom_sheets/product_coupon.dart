import 'package:ecomik/controller/bottom_sheets/file_details.dart';
import 'package:ecomik/controller/bottom_sheets/product_coupon.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

class ProductCouponBottomSheet extends StatelessWidget {
  const ProductCouponBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductCouponBottomSheetController>(
      init: ProductCouponBottomSheetController(),
      global: false,
      builder: (controller) => SizedBox(
        height: 380,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BottomModalBodyWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                              AppLanguageTranslation
                                  .collectCouponFirstTransKey.toCurrentLanguage,
                              style: AppTextStyles.headLine6SemiBoldTextStyle)),
                    ],
                  ),
                  AppGaps.hGap16,
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final coupon = controller.coupons[index];
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coupon.name,
                                        style: AppTextStyles
                                            .bodyLargeSemiboldTextStyle
                                            .copyWith(
                                                color: AppColors.primaryColor),
                                      ),
                                      AppGaps.hGap5,
                                      Text(
                                        coupon.description,
                                        style: AppTextStyles.bodyTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: CustomTextButtonWidget(
                                    buttonText: AppLanguageTranslation
                                        .copyTransKey.toCurrentLanguage,
                                    onTap: () => controller.onCouponTap(coupon),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => AppGaps.hGap16,
                          itemCount: controller.coupons.length)),
                  AppGaps.hGap16,
                ],
              ),
            ),
            bottomNavigationBar: CustomScaffoldBottomBarWidget(
              child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText:
                      AppLanguageTranslation.cancelTransKey.toCurrentLanguage,
                  onTap: () {
                    Get.back();
                  }),
            )),
      ),
    );
  }
}
