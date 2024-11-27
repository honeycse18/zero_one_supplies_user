import 'package:collection/collection.dart';
import 'package:ecomik/controller/order_status_controller.dart';
import 'package:ecomik/models/api_responses/single_order_response.dart';
import 'package:ecomik/models/api_responses/single_product_order_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/screen_parameters/otp_screen_parameter.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/my_orders_screen_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/order_status_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderStatusScreenController>(
        init: OrderStatusScreenController(),
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
                        .orderStatusTransKey.toCurrentLanguage)),

                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: AppGaps.hGap10),

                      /* <---- Search and filter button row ----> */
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
                              Obx(() => Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomTabToggleButtonWidget(
                                        text: AppLanguageTranslation
                                            .detailsTransKey.toCurrentLanguage,
                                        isSelected:
                                            controller.isActiveSelected.value,
                                        onTap: () => controller
                                            .isActiveSelected.value = true,
                                      )))),
                              AppGaps.wGap5,
                              /* <---- Product Won Auctions tab button ----> */
                              Obx(() => Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomTabToggleButtonWidget(
                                      text: AppLanguageTranslation
                                          .trackingTransKey.toCurrentLanguage,
                                      isSelected:
                                          !controller.isActiveSelected.value,
                                      onTap: () {
                                        controller.isActiveSelected.value =
                                            false;
                                      },
                                    ),
                                  )))
                            ],
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap24),
                      Obx(() => controller.isActiveSelected.value
                          ? MultiSliver(
                              children: [
                                SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .orderInformationTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .bodyExtraLargeSemiboldTextStyle,
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                      AppGaps.hGap24,
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            padding: const EdgeInsets.all(16),
                                            height: 146,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(18))),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${AppLanguageTranslation.deliverToTransKey.toCurrentLanguage} ${controller.orderDetails.user.firstName} ${controller.orderDetails.user.lastName}',
                                                  style: AppTextStyles
                                                      .bodyWithExtraLargeSemiboldTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .darkColor),
                                                ),
                                                AppGaps.hGap8,
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 70,
                                                      width: 70,
                                                      child:
                                                          CachedNetworkImageWidget(
                                                        imageURL: controller
                                                            .orderDetails
                                                            .user
                                                            .image,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                  width: 1),
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  topLeft: AppComponents
                                                                      .defaultBorderRadius,
                                                                  topRight:
                                                                      AppComponents
                                                                          .defaultBorderRadius,
                                                                  bottomLeft:
                                                                      AppComponents
                                                                          .defaultBorderRadius,
                                                                  bottomRight:
                                                                      AppComponents
                                                                          .defaultBorderRadius),
                                                              image: DecorationImage(
                                                                  image:
                                                                      imageProvider,
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                      ),
                                                    ),
                                                    AppGaps.wGap10,
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  9, 3, 9, 3),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .shadeColor3),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          5))),
                                                          child: Text(
                                                            controller
                                                                .orderDetails
                                                                .user
                                                                .email,
                                                            style: AppTextStyles
                                                                .bodySmallMediumTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .shadeColor3),
                                                          ),
                                                        ),
                                                        AppGaps.hGap10,
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  9, 3, 9, 3),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .shadeColor3),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          5))),
                                                          child: Text(
                                                            controller
                                                                .orderDetails
                                                                .user
                                                                .phone,
                                                            style: AppTextStyles
                                                                .bodySmallMediumTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .shadeColor3),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                      AppGaps.hGap24,
                                      Text(
                                        AppLanguageTranslation
                                            .productDetailsTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles
                                            .headLine6BoldTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                SliverList.separated(
                                  itemBuilder: (context, index) {
                                    /// Single cart product
                                    final order = controller.orders[index];
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    '${AppLanguageTranslation.storeNameTransKey.toCurrentLanguage} ${order.store.name}')),
                                            Text(
                                                '${AppLanguageTranslation.subTotalTransKey.toCurrentLanguage}  ${Helper.getCurrencyFormattedAmountText(order.total)}')
                                          ],
                                        ),
                                        AppGaps.hGap12,
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            /// Single cart product
                                            final SingleProductOrderProduct
                                                orderProduct =
                                                order.products[index];
                                            return OrderWiseProductWidget(
                                                categoryName: orderProduct
                                                    .categories.name,
                                                productImage:
                                                    orderProduct.image,
                                                productName: orderProduct.name,
                                                price: orderProduct.price,
                                                quantity:
                                                    orderProduct.quantity);
                                          },
                                          separatorBuilder: (context, index) =>
                                              AppGaps.hGap16,
                                          itemCount: order.products.length,
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      AppGaps.hGap16,
                                  itemCount: controller.orders.length,
                                ),
                              ],
                            )
                          : SliverToBoxAdapter(
                              child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OrderStatusTracking(
                                orderNumber: '',
                                currentOrderStatus:
                                    controller.currentOrderStatus,
                                id: controller.orderDetails.id,
                                deliveryTime: controller
                                    .orderDetails.estimatedDeliveryHours
                                    .toString(),
                              ),
                            ))),
                    ],
                  ),
                ),
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  /* <---- Bottom button based on order status ----> */
                  child: bottomButtonWidget(
                      controller.orderDetails.id,
                      controller.orderDetails.orders.firstOrNull?.store.id,
                      context,
                      controller.currentOrderStatus),
                ),
              ),
            ));
  }

  Widget bottomButtonWidget(String? productId, String? storeId,
      BuildContext screenContext, String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypePlaced:
      case Constants.myOrderStatusTypePending:
/*         return CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.cancelOrderTransKey.toCurrentLanguage,
            onTap: () {}); */
        // TODO: Add cancel order API
        return AppGaps.emptyGap;
      case Constants.myOrderStatusTypeConfirm:
      case Constants.myOrderStatusTypeProcessing:
        return CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.cancelOrderTransKey.toCurrentLanguage,
            onTap: null);
      case Constants.myOrderStatusTypeDelivered:
        return CustomStretchedTextButtonWidget(
            buttonText: AppLanguageTranslation
                .pleaseLeaveAFeedBackTransKey.toCurrentLanguage,
            onTap: () {
              Get.toNamed(AppPageNames.addReviewScreen,
                  arguments: PasswordScreenParameter(
                    productId: productId!,
                    storeId: storeId!,
                  ));
            });
      default:
        return CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.cancelOrderTransKey.toCurrentLanguage,
            onTap: null);
    }
  }
}

class OrderWiseProductWidget extends StatelessWidget {
  final String productImage;
  final String productName;
  final String categoryName;
  final double price;
  final int quantity;
  const OrderWiseProductWidget({
    super.key,
    required this.productImage,
    required this.productName,
    required this.categoryName,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        paddingValue: const EdgeInsets.all(8),
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImageWidget(
                  imageURL: productImage,
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
                    productName,
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
                  AppGaps.hGap2,
                  Text(
                      '${AppLanguageTranslation.qtyTransKey.toCurrentLanguage}  $quantity',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.bodyTextColor, fontSize: 12)),
                  AppGaps.hGap2,
                  Text(Helper.getCurrencyFormattedAmountText(price),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: AppColors.bodyTextColor, fontSize: 12)),
                  AppGaps.hGap8,
                ],
              ),
            ),
          ],
        ));
  }
}

class OrderStatusDetails extends StatelessWidget {
  final String orderNumber;
  final String productName;
  final String phone;
  final String name;
  final String orderAddress;
  final String imageUrl;
  final String orderAddressType;
  final int quantity;
  final double price;
  final void Function()? onTap;

  const OrderStatusDetails({
    required this.orderNumber,
    required this.productName,
    required this.phone,
    this.onTap,
    super.key,
    required this.name,
    required this.orderAddress,
    required this.imageUrl,
    required this.orderAddressType,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGaps.hGap8,
        OrderStatusProductWidget(
          imageUrl: imageUrl,
          productName: productName,
          // categoryName: 'Wireless headphone',
          price: price,
          quantity: quantity,
          onTap: onTap,
        ),
        AppGaps.hGap15,
      ],
    );
  }
}

class OrderStatusTracking extends StatelessWidget {
  final String currentOrderStatus;
  final String id;
  final String orderNumber;
  final String deliveryTime;

  const OrderStatusTracking({
    super.key,
    required this.currentOrderStatus,
    required this.id,
    required this.orderNumber,
    required this.deliveryTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              AppLanguageTranslation.orderInformationTransKey.toCurrentLanguage,
              style: AppTextStyles.bodyExtraLargeSemiboldTextStyle,
            ),
            const Spacer(),
            /*  Text(
              '${AppLanguageTranslation.orderIdTransKey.toCurrentLanguage} $orderNumber',
              style: AppTextStyles.bodySmallMediumTextStyle
                  .copyWith(color: AppColors.shadeColor3),
            ) */
          ],
        ),
        AppGaps.hGap16,
        Row(
          children: [
            Expanded(
              child: (currentOrderStatus ==
                          Constants.myOrderStatusTypeCancelled ||
                      currentOrderStatus ==
                          Constants.myOrderStatusTypeDelivered)
                  ? AppGaps.hGap2
                  : Container(
                      padding: const EdgeInsets.all(18.0),
                      height: 86,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(color: Colors.white),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18))),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                  AppAssetImages.truckSVGLogoDualTone),
                            ],
                          ),
                          AppGaps.wGap16,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .estimateDeliveryTransKey.toCurrentLanguage,
                                style: AppTextStyles.headLine6BoldTextStyle
                                    .copyWith(color: AppColors.alertColor),
                              ),
                              AppGaps.hGap4,
                              Row(
                                children: [
                                  Text(
                                    '${AppLanguageTranslation.withinTransKey.toCurrentLanguage} $deliveryTime ${AppLanguageTranslation.hoursTransKey.toCurrentLanguage}',
                                    style: AppTextStyles.bodyMediumTextStyle
                                        .copyWith(color: AppColors.shadeColor3),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )),
            )
          ],
        ),
        AppGaps.hGap24,
        Container(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(18))),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  currentOrderStatus == Constants.myOrderStatusTypeCancelled
                      ? [
                          Center(
                            child: Text(AppLanguageTranslation
                                .yourOrderIsCanceledTransKey.toCurrentLanguage),
                          )
                        ]
                      : [
                          AppGaps.hGap8,
                          /* <---- Order product rating stars widget ----> */
                          AppGaps.wGap4,
                          /* <---- Order product rating number text ----> */
                          AppGaps.hGap24,
                          /* <---- Order placed status ----> */
                          orderPlacedWidget(currentOrderStatus),
                          AppGaps.hGap15,
                          /* <---- Order pending status ----> */
                          orderPendingWidget(currentOrderStatus),
                          AppGaps.hGap15,
                          /* <---- Order confirmed status ----> */
                          orderConfirmedWidget(currentOrderStatus),
                          AppGaps.hGap15,
                          /* <---- Order processing status ----> */
                          orderProcessingWidget(currentOrderStatus),
                          /* <---- Order Picked status ----> */
                          AppGaps.hGap15,
                          orderPickedWidget(currentOrderStatus),
                          /* <---- Order On way status ----> */
                          AppGaps.hGap15,
                          orderOnWayWidget(currentOrderStatus),
                          AppGaps.hGap15,
                          /* <---- Order delivered status ----> */
                          orderDeliveredWidget(currentOrderStatus),
                          // Bottom extra spaces
                          AppGaps.hGap30,
                        ]),
        ),
      ],
    );
  }

  String get deliveryTimeText {
    final deliveryTimeSlot =
        PreferredDeliveryTimeSlot.toEnumValue(deliveryTime);
    switch (deliveryTimeSlot) {
      case PreferredDeliveryTimeSlot.fullDay:
        return 'Full day 9 Am to 9 PM';
      case PreferredDeliveryTimeSlot.morning:
        return 'Morning 9 AM to 1 PM';
      case PreferredDeliveryTimeSlot.afternoon:
        return 'Afternoon 3 PM to 9 PM';
      default:
        return '';
    }
  }

  Widget orderDeliveredWidget(String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypeDelivered:
        return StepperEnabledWidget(
          // timeText: Helper.ddMMyyHHmmaFormattedDate(theOrder.updatedAt),
          statusText:
              AppLanguageTranslation.deliveredOrderTransKey.toCurrentLanguage,
          statusDescriptionText: AppLanguageTranslation
              .productIsDeliveredToDeliveryManTransKey.toCurrentLanguage,
        );
      default:
        return StepperDisabledWidget(
          statusText:
              AppLanguageTranslation.deliveredOrderTransKey.toCurrentLanguage,
          statusDescriptionText: AppLanguageTranslation
              .orderWillBeDeliveredLaterTransKey.toCurrentLanguage,
        );
    }
  }

  Widget orderOnWayWidget(String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypeOnWay:
        return StepperEnabledWidget(
            // timeText: Helper.ddMMyyHHmmaFormattedDate(theOrder.updatedAt),
            statusText:
                AppLanguageTranslation.orderOnTheWayTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderOnTheWayWillBeDeliveredSoonTransKey.toCurrentLanguage);
      case Constants.myOrderStatusTypeDelivered:
        return StepperEnabledWidget(
            // timeText: '',
            statusText:
                AppLanguageTranslation.orderOnTheWayTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderWasOnTheWayTransKey.toCurrentLanguage);
      default:
        return StepperDisabledWidget(
            statusText:
                AppLanguageTranslation.orderOnTheWayTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderWillBeOnTheWayTransKey.toCurrentLanguage);
    }
  }

  Widget orderPickedWidget(String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypePicked:
        return StepperEnabledWidget(
            // timeText: Helper.ddMMyyHHmmaFormattedDate(theOrder.updatedAt),
            statusText:
                AppLanguageTranslation.orderPickedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderPickedByDeliveryManTransKey.toCurrentLanguage);
      case Constants.myOrderStatusTypeOnWay:
      case Constants.myOrderStatusTypeDelivered:
        return StepperEnabledWidget(
            // timeText: '',
            statusText:
                AppLanguageTranslation.orderPickedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderPickedByDeliveryManTransKey.toCurrentLanguage);
      default:
        return StepperDisabledWidget(
            statusText:
                AppLanguageTranslation.orderPickedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderWillBePickedByDeliverymanTransKey.toCurrentLanguage);
    }
  }

  /// Get processing order stepper widget based on current order status
  Widget orderProcessingWidget(String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypeProcessing:
        return StepperEnabledWidget(
          // timeText: Helper.ddMMyyHHmmaFormattedDate(theOrder.updatedAt),
          statusText:
              AppLanguageTranslation.orderProcessingTransKey.toCurrentLanguage,
          statusDescriptionText: AppLanguageTranslation
              .orderProcessingToDeliverTransKey.toCurrentLanguage,
        );
      case Constants.myOrderStatusTypePicked:
      case Constants.myOrderStatusTypeOnWay:
      case Constants.myOrderStatusTypeDelivered:
        return StepperEnabledWidget(
          // timeText: '',
          statusText:
              AppLanguageTranslation.orderProcessingTransKey.toCurrentLanguage,
          statusDescriptionText:
              AppLanguageTranslation.orderIsProcessedTransKey.toCurrentLanguage,
        );
      default:
        return StepperDisabledWidget(
          statusText:
              AppLanguageTranslation.orderProcessingTransKey.toCurrentLanguage,
          statusDescriptionText: AppLanguageTranslation
              .orderWillBeProcessedLaterTransKey.toCurrentLanguage,
        );
    }
  }

  /// Get confirmed order stepper widget based on current order status
  Widget orderConfirmedWidget(String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypeConfirm:
        return StepperEnabledWidget(
            // timeText: Helper.ddMMyyHHmmaFormattedDate(theOrder.updatedAt),
            statusText:
                AppLanguageTranslation.orderConfirmedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderConfirmedProcessingStartingTransKey.toCurrentLanguage);
      case Constants.myOrderStatusTypeProcessing:
      case Constants.myOrderStatusTypePicked:
      case Constants.myOrderStatusTypeOnWay:
      case Constants.myOrderStatusTypeDelivered:
        return StepperEnabledWidget(
            // timeText: '',
            statusText:
                AppLanguageTranslation.orderConfirmedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderAlreadyConfirmedTransKey.toCurrentLanguage);
      default:
        return StepperDisabledWidget(
            statusText:
                AppLanguageTranslation.orderConfirmedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderWillBeConfirmedLaterTransKey.toCurrentLanguage);
    }
  }

  /// Get pending order stepper widget based on current order status
  Widget orderPendingWidget(String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypePending:
        return StepperEnabledWidget(
            // timeText: Helper.ddMMyyHHmmaFormattedDate(theOrder.updatedAt),
            statusText:
                AppLanguageTranslation.orderPendingTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderIsPendingForConfirmationTransKey.toCurrentLanguage);
      case Constants.myOrderStatusTypeConfirm:
      case Constants.myOrderStatusTypeProcessing:
      case Constants.myOrderStatusTypePicked:
      case Constants.myOrderStatusTypeOnWay:
      case Constants.myOrderStatusTypeDelivered:
        return StepperEnabledWidget(
            // timeText: '',
            statusText:
                AppLanguageTranslation.orderPendingTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .pendingStatusPassedTransKey.toCurrentLanguage);
      default:
        return StepperDisabledWidget(
            statusText:
                AppLanguageTranslation.orderPendingTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .orderWillBeInPendingStatusSoonTransKey.toCurrentLanguage);
    }
  }

  /// Get placed order stepper widget based on current order status
  Widget orderPlacedWidget(String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypePlaced:
        return StepperEnabledWidget(
            // timeText: Helper.ddMMyyHHmmaFormattedDate(theOrder.updatedAt),
            statusText:
                AppLanguageTranslation.orderPlacedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .yourOrderIsPlacedForDeliveryTransKey.toCurrentLanguage);
      case Constants.myOrderStatusTypePending:
      case Constants.myOrderStatusTypeConfirm:
      case Constants.myOrderStatusTypeProcessing:
      case Constants.myOrderStatusTypePicked:
      case Constants.myOrderStatusTypeOnWay:
      case Constants.myOrderStatusTypeDelivered:
        return StepperEnabledWidget(
            // timeText: '',
            statusText:
                AppLanguageTranslation.orderPlacedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .yourOrderWasPlacedForDeliveryTransKey.toCurrentLanguage);
      default:
        return StepperDisabledWidget(
            statusText:
                AppLanguageTranslation.orderPlacedTransKey.toCurrentLanguage,
            statusDescriptionText: AppLanguageTranslation
                .yourOrderIsNotPlacedTransKey.toCurrentLanguage);
    }
  }

  /// Get bottom button widget based on current order status
  Widget bottomButtonWidget(
      BuildContext screenContext, String currentOrderStatus) {
    switch (currentOrderStatus) {
      case Constants.myOrderStatusTypePlaced:
      case Constants.myOrderStatusTypePending:
        return CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.cancelOrderTransKey.toCurrentLanguage,
            onTap: () {});
      case Constants.myOrderStatusTypeConfirm:
      case Constants.myOrderStatusTypeProcessing:
        return CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.cancelOrderTransKey.toCurrentLanguage,
            onTap: null);
      case Constants.myOrderStatusTypeDelivered:
        return CustomStretchedTextButtonWidget(
            buttonText: AppLanguageTranslation
                .pleaseLeaveAFeedBackTransKey.toCurrentLanguage,
            onTap: () {
              Get.toNamed('/NextScreen');
              (AppPageNames.addReviewScreen);
            });
      default:
        return CustomStretchedTextButtonWidget(
            buttonText:
                AppLanguageTranslation.cancelOrderTransKey.toCurrentLanguage,
            onTap: null);
    }
  }
}
