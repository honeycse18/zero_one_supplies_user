/* import 'dart:ui';

import 'package:ecomik/controller/Product_screen_controller.dart';
import 'package:ecomik/models/fake_data.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/product_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  /// The productCategoryName parameter required data type of String for show

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsScreenController>(
        init: ProductsScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: Image.asset(AppAssetImages.backgroundFullPng).image,
                    fit: BoxFit.fill,
                  )),
              child: Scaffold(
                key: controller.currentProductScaffoldKey,
                /* <-------- Appbar --------> */
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(controller.currentProductCategoryName)),
                /* <-------- Drawer --------> */
                drawer: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 3.05,
                        sigmaY: 3.05,
                      ),
                      child: const SizedBox.expand(),
                    ),
                    // _drawerWidget(context)

                    Drawer(
                      backgroundColor: AppColors.primaryColor,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppGaps.screenPaddingValue),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top extra spaces
                              AppGaps.hGap20,
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Filter',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  const Spacer(),
                                  /* <---- Close button ----> */
                                  CustomIconButtonWidget(
                                      onTap: () {
                                        // Tap here to close the drawer
                                        Get.back();
                                      },
                                      backgroundColor:
                                          Colors.white.withOpacity(0.1),
                                      child: SvgPicture.asset(
                                        AppAssetImages.closeSVGLogoLine,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              AppGaps.hGap20,
                              AppGaps.hGap32,
                              Expanded(
                                child: ListView(
                                  children: [
                                    /* <---- 'Price range' category ----> */
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Price range',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          AppGaps.wGap15,
                                          Expanded(
                                            child: Divider(
                                              color:
                                                  Colors.white.withOpacity(0.1),
                                            ),
                                          ),
                                        ]),
                                    AppGaps.hGap5,
                                    /* <---- Price range slider ----> */
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            sliderTheme: const SliderThemeData(
                                          showValueIndicator:
                                              ShowValueIndicator.always,
                                          activeTrackColor: Colors.white,
                                          trackHeight: 2,
                                          valueIndicatorColor:
                                              Colors.transparent,
                                          valueIndicatorTextStyle:
                                              TextStyle(color: Colors.white),
                                          overlappingShapeStrokeColor:
                                              Colors.transparent,
                                          rangeValueIndicatorShape:
                                              CustomPaddleRangeSliderValueIndicatorShape(),
                                          rangeThumbShape:
                                              CustomRoundRangeSliderThumbShape(
                                                  enabledThumbRadius: 10),
                                        )),
                                        child: RangeSlider(
                                          min: 0,
                                          max: 100,
                                          values: controller.rangeValues,
                                          labels: RangeLabels(
                                              '\$${controller.rangeValues.start.toInt() + 5}',
                                              '\$${controller.rangeValues.end.toInt() + 35}'),
                                          inactiveColor:
                                              Colors.white.withOpacity(0.20),
                                          onChanged: (value) {
                                            // setState(() {
                                            controller.rangeValues = value;
                                            // });
                                          },
                                        ),
                                      ),
                                    ),
                                    AppGaps.hGap24,
                                    /* <---- 'Availability' category ----> */
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Availability',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          AppGaps.wGap15,
                                          Expanded(
                                            child: Divider(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                            ),
                                          ),
                                        ]),
                                    AppGaps.hGap16,
                                    /* <---- 'In stock' of availability category drawer radio 
                             menu widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'In stock',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterAvailability =
                                            0;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 0,
                                      radioGroupValue:
                                          controller.currentFilterAvailability,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterAvailability =
                                            value ?? 0;
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'Pre order' of availability category drawer radio 
                             menu widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Pre order',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterAvailability =
                                            1;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 1,
                                      radioGroupValue:
                                          controller.currentFilterAvailability,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterAvailability =
                                            value ?? 1;
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'New arrival' of availability category drawer radio 
                             menu widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'New arrival',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterAvailability =
                                            2;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 2,
                                      radioGroupValue:
                                          controller.currentFilterAvailability,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterAvailability =
                                            value ?? 2;
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap24,
                                    /* <---- 'Interface' category ----> */
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Interface',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          AppGaps.wGap15,
                                          Expanded(
                                            child: Divider(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                            ),
                                          ),
                                        ]),
                                    AppGaps.hGap16,
                                    /* <---- 'Wireless' of interface category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Wireless',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterInterface = 0;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 0,
                                      radioGroupValue:
                                          controller.currentFilterInterface,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterInterface =
                                            value ?? 0;
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'Wired' of interface category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Wired',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterInterface = 1;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 1,
                                      radioGroupValue:
                                          controller.currentFilterInterface,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterInterface =
                                            value ?? 1;
                                        controller.update();
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'Bluetooth' of interface category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Bluetooth',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterInterface = 2;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 2,
                                      radioGroupValue:
                                          controller.currentFilterInterface,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterInterface =
                                            value ?? 2;
                                        controller.update();
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'USB' of interface category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'USB',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterInterface = 3;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 3,
                                      radioGroupValue:
                                          controller.currentFilterInterface,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterInterface =
                                            value ?? 3;
                                        controller.update();
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'Type-C' of interface category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Type-C',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterInterface = 4;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 4,
                                      radioGroupValue:
                                          controller.currentFilterInterface,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterInterface =
                                            value ?? 4;
                                        controller.update();
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap24,
                                    /* <---- 'Brand' category ----> */
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Brand',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          AppGaps.wGap15,
                                          Expanded(
                                            child: Divider(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                            ),
                                          ),
                                        ]),
                                    AppGaps.hGap16,
                                    /* <---- 'Beats' of brand category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Beats',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterBrand = 0;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 0,
                                      radioGroupValue:
                                          controller.currentFilterBrand,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterBrand =
                                            value ?? 0;
                                        controller.update();
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'Apple' of brand category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Apple',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterBrand = 1;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 1,
                                      radioGroupValue:
                                          controller.currentFilterBrand,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterBrand =
                                            value ?? 1;
                                        controller.update();
                                        // });
                                      },
                                    ),
                                    AppGaps.hGap16,
                                    /* <---- 'Samsung' of brand category drawer radio menu 
                             widget ----> */
                                    DrawerRadioMenuWidget(
                                      text: 'Samsung',
                                      onTap: () {
                                        // setState(() {
                                        controller.currentFilterBrand = 2;
                                        controller.update();
                                        // });
                                      },
                                      radioValue: 2,
                                      radioGroupValue:
                                          controller.currentFilterBrand,
                                      onRadioChange: (value) {
                                        // setState(() {
                                        controller.currentFilterBrand =
                                            value ?? 2;
                                        controller.update();
                                        // });
                                      },
                                    ),
                                    // Bottom extra spaces before 'Apply filter' button
                                    AppGaps.hGap16,
                                  ],
                                ),
                              ),
                              /* <---- 'Apply filter' text button ----> */
                              CustomTightTextButtonWidget(
                                  onTap: () {},
                                  child: const Text('Apply filter',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          decoration:
                                              TextDecoration.underline))),
                              // Bottom extra spaces
                              AppGaps.hGap50,
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                    /* <---- Cart item list ----> */
                    child: Column(
                  children: [
                    /* <---- Top extra spaces ----> */
                    AppGaps.hGap10,
                    /* <---- Search product name filter button row ----> */
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            /* <---- Search product name text field ----> */
                            child: CustomTextFormField(
                                hasShadow: true,
                                hintText: 'Search product name',
                                prefixIcon: SvgPicture.asset(
                                    AppAssetImages.searchSVGLogoLine,
                                    color: AppColors.primaryColor))),
                        AppGaps.wGap8,
                        /* <---- Filter icon button ----> */
                        CustomIconButtonWidget(
                          fixedSize: const Size(60, 60),
                          hasShadow: true,
                          backgroundColor: AppColors.primaryColor,
                          child: SvgPicture.asset(
                              AppAssetImages.filterSVGLogoLine,
                              color: Colors.white),
                          onTap: () {
                            if (controller.currentProductScaffoldKey
                                        .currentState !=
                                    null &&
                                !controller.currentProductScaffoldKey
                                    .currentState!.isDrawerOpen) {
                              controller.currentProductScaffoldKey.currentState
                                  ?.openDrawer();
                            }

                            controller.update();
                          },
                        ),
                      ],
                    ),
                    AppGaps.hGap24,
                    /* <---- Product grid list under a category ----> */
                   /*  Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 30),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: AppGaps.screenPaddingValue,
                                mainAxisSpacing: AppGaps.screenPaddingValue,
                                mainAxisExtent: 235,
                                crossAxisCount: 2,
                                childAspectRatio: 1),
                        itemCount: FakeData.products.length,
                        itemBuilder: (context, index) {
                          /// Per product data
                          final product = FakeData.products[index];
                          /* <---- Wishlist item widget ----> */
                          return CustomGridSingleItemWidget(
                            onTap: () {
                              Get.toNamed(AppPageNames.productDetailsScreen);
                            },
                            backgroundColor: Colors.white,
                            child: ProductGridSingleItemWidget(
                              title: product.name,
                              category: product.shortDescription,
                              originalPrice: product.originalPrice,
                              currentPrice: product.currentPrice,
                              productImageURL: product.productImage,
                              isAddedToCart: product.isAddedToCart,
                              isWishListed: product.isWishlisted,
                              onAddTap: () {
                                // // setState(() {
                                //   product.isAddedToCart = !product.isAddedToCart;
                                // // });
                              },
                              onWishlistTap: () {
                                // setState(() {
                                //   product.isWishlisted = !product.isWishlisted;
                                // });
                              },
                            ),
                          );
                        },
                      ),
                    ), */
                  ],
                )),
              ),
            ));
  }
}
 */
