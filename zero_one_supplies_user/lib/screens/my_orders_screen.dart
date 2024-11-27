import 'package:collection/collection.dart';
import 'package:ecomik/controller/home_navigator_screen_controller/my_order_screen_controller.dart';
import 'package:ecomik/models/api_responses/my_order_response.dart';
import 'package:ecomik/models/api_responses/product_order_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/my_orders_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  /// Currently selected tab index

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyOrderScreenController>(
        init: MyOrderScreenController(),
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
                    titleWidget: Text(
                      LanguageHelper.currentLanguageText(
                          LanguageHelper.myOrderTransKey),
                    )),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top extra spaces
                      AppGaps.hGap10,
                      /* <---- Order status tabs ----> */
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: MyOrderStatusTypes.values
                                .mapIndexed((index, tabName) {
                              // final index =controller.tabNames.indexOf(tabName);
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: TextButton(
                                    onPressed: () {
                                      controller.onTabTap(index);
                                    },

                                    // }),
                                    style: TextButton.styleFrom(
                                        foregroundColor:
                                            controller.selectedTabIndex == index
                                                ? Colors.white
                                                : AppColors.darkColor,
                                        elevation: 10,
                                        shadowColor: controller.selectedTabIndex == index
                                            ? AppColors.primaryColor
                                                .withOpacity(0.25)
                                            : Colors.black.withOpacity(0.05),
                                        backgroundColor:
                                            controller.selectedTabIndex == index
                                                ? AppColors.primaryColor
                                                : Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 9,
                                            horizontal:
                                                controller.selectedTabIndex == index
                                                    ? 24
                                                    : 20),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(12)))),
                                    child: Text(
                                      LanguageHelper.currentLanguageText(
                                          tabName.stringValueForView),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      AppGaps.hGap8,
                      /* <---- Order list ----> */
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () async =>
                            controller.myOrderPagingController.refresh(),
                        child: PagedListView.separated(
                          pagingController: controller.myOrderPagingController,
                          padding: const EdgeInsets.only(top: 16, bottom: 30),
                          separatorBuilder: (context, index) => AppGaps.hGap16,
                          builderDelegate: CoreWidgets
                              .pagedChildBuilderDelegate<ProductOrderItem>(
                                  noItemFoundIndicatorBuilder: (context) {
                            return EmptyScreenWidget(
                              localImageAssetURL: AppAssetImages.noOrderFound,
                              title: LanguageHelper.currentLanguageText(
                                  LanguageHelper.haveNoOrderTransKey),
                              shortTitle: AppLanguageTranslation
                                  .checkTradingTransKey.toCurrentLanguage,
                            );
                          }, itemBuilder: (context, item, index) {
                            /// Single order
                            final myOrder = item;
                            String price = (myOrder.total).toString();

                            return MyOrderProductWidget(
                              onTap: () {
                                Get.toNamed(AppPageNames.orderStatusScreen,
                                    arguments: myOrder.id);
                              },
                              paymentMetod: Helper.snakeCaseToTitleCase(
                                  myOrder.paymentMethod),
                              productName: myOrder.orderNumber,
                              productImage:
                                  'https://01supplies.s3.eu-north-1.amazonaws.com/live/01supplies/store/6626328b320d87ce629a386d/category-1713779338570.webp',
                              priceText: Helper.getCurrencyFormattedAmountText(
                                  myOrder.total.toDouble()),
                              orderStatusText: myOrder.status,
                              dateText: myOrder.createdAt,
                            );
                          }),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ));
  }
}
