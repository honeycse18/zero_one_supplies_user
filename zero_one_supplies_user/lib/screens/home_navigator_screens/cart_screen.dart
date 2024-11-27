import 'package:ecomik/controller/home_navigator_screen_controller/cart_screen_controller.dart';
import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/cart_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartScreenController>(
        init: CartScreenController(),
        global: false,
        builder: (controller) => Scaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: false,
                  titleWidget: Text(
                      AppLanguageTranslation.myCartTransKey.toCurrentLanguage)),
              /* <-------- Content --------> */
              body: CustomScaffoldBodyWidget(
                /* <---- Cart item list ----> */
                child: controller.isCartEmpty
                    ? RefreshIndicator(
                        onRefresh: () async => await controller.getCarts(),
                        child: ListView(children: [
                          CartEmptyScreenWidget(
                            image: AppAssetImages.emptyCart,
                            title: LanguageHelper.currentLanguageText(
                                LanguageHelper.shoppingCartTransKey),
                            shortTitle: LanguageHelper.currentLanguageText(
                                LanguageHelper.checkTradingTransKey),
                            onTap: () async {
                              await Get.toNamed(AppPageNames.productPage);
                              controller.getCarts();
                            },
                          )
                        ]),
                      )
                    : RefreshIndicator(
                        onRefresh: () async => await controller.getCarts(),
                        child: CustomScrollView(
                          slivers: [
                            SliverList.separated(
                              itemBuilder: (context, index) {
                                TextEditingController? couponController;
                                try {
                                  couponController =
                                      controller.couponControllers[index];
                                } catch (e) {
                                  couponController = null;
                                }

                                /// Single cart product
                                final cart = controller.cartsData.carts[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '${AppLanguageTranslation.storeNameTransKey.toCurrentLanguage} ${cart.store.name}')),
                                        Text(
                                            '${AppLanguageTranslation.subTotalTransKey.toCurrentLanguage} ${Helper.getCurrencyFormattedAmountText(cart.total)}')
                                      ],
                                    ),
                                    AppGaps.hGap12,
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        /// Single cart product
                                        final StoreWiseCartProduct cartProduct =
                                            cart.products[index];
                                        return CartItemWidget(
                                          index: index,
                                          image: cartProduct.image,
                                          categoryName:
                                              cartProduct.categories.name,
                                          name: cartProduct.name,
                                          price: cartProduct.price,
                                          quantity: cartProduct.quantity,
                                          onTap: () => controller
                                              .onCartItemTap(cartProduct),
                                          onDeleteTap: () => controller
                                              .onCartItemDeleteTap(cartProduct),
                                          onAddTap: () => controller
                                              .onCartItemPlusTap(cartProduct),
                                          onRemoveTap: () => controller
                                              .onCartItemMinusTap(cartProduct),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          AppGaps.hGap16,
                                      itemCount: cart.products.length,
                                    ),
                                    AppGaps.hGap12,
                                    CustomTextFormField(
                                        labelText: AppLanguageTranslation
                                            .couponCodeTransKey
                                            .toCurrentLanguage,
                                        hintText: 'Enter coupon code here',
                                        controller: couponController,
                                        suffixIcon: TightIconButtonWidget(
                                            isLoading: index ==
                                                controller.loadingCouponIndex,
                                            onTap: () => controller
                                                .onStoreApplyCouponIconButtonTap(
                                                    couponController?.text,
                                                    cart.store.id,
                                                    index),
                                            child: SvgPicture.asset(
                                                AppAssetImages
                                                    .sendSVGLogoDualTone))),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                              itemCount: controller.cartsData.carts.length,
                            ),
                            const SliverToBoxAdapter(child: AppGaps.hGap17),
                            SliverToBoxAdapter(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 13),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: AppComponents.defaultBorder),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppGaps.hGap6,
                                    CartAmountWidget(
                                        name: AppLanguageTranslation
                                            .subTotalTransKey.toCurrentLanguage,
                                        amount: controller.netPriceAmount),
                                    AppGaps.hGap8,
                                    CartAmountWidget(
                                        name: AppLanguageTranslation
                                            .discountTransKey.toCurrentLanguage,
                                        amount: controller.discountAmount),
                                    AppGaps.hGap8,
                                    // CartAmountWidget(
                                    //     name: 'Delivery charge',
                                    //     amount: controller.deliveryChargeAmount),
                                    // AppGaps.hGap4,
                                    CartAmountWidget(
                                        name: AppLanguageTranslation
                                            .vatTransKey.toCurrentLanguage,
                                        amount: controller.vatAmount),
                                    AppGaps.hGap16,
                                    Row(
                                      children: [
                                        Text(
                                            AppLanguageTranslation.totalTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .headLine6BoldTextStyle),
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              Helper
                                                  .getCurrencyFormattedAmountText(
                                                      controller.totalAmount),
                                              style: AppTextStyles
                                                  .headLine6BoldTextStyle),
                                        ))
                                      ],
                                    ),
                                    AppGaps.hGap16,
                                    CustomStretchedTextButtonWidget(
                                      buttonText: AppLanguageTranslation
                                          .checkoutTransKey.toCurrentLanguage,
                                      onTap: controller.onCheckoutButtonTap,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SliverToBoxAdapter(child: AppGaps.hGap30),
                          ],
                        ),
                      ),
              ),
            ));
  }
}
