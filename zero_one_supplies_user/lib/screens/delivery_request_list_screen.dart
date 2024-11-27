import 'dart:developer';

import 'package:ecomik/controller/delivery_request_list_screen_controller.dart';
import 'package:ecomik/models/api_responses/delivery_requests_response.dart';
import 'package:ecomik/utils/app_pages.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DeliveryRequestListScreen extends StatelessWidget {
  const DeliveryRequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryRequestListScreenController>(
        init: DeliveryRequestListScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    titleWidget: Text(AppLanguageTranslation
                        .deliveryRequestListTransKey.toCurrentLanguage)),
                body: CustomScaffoldBodyWidget(
                    child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.deliveryRequestPagingController.refresh(),
                  child: CustomScrollView(slivers: [
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap10,
                    ),
                    PagedSliverList.separated(
                      pagingController:
                          controller.deliveryRequestPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<DeliveryRequestItem>(
                              noItemsFoundIndicatorBuilder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppGaps.hGap10,
                            Text('No delivery requests found'),
                          ],
                        );
                      }, itemBuilder: (context, item, index) {
                        final DeliveryRequestItem deliveryRequestList = item;
                        return DeliveryRequestScreenWidget(
                          onTap: () {},
                          trackingId: deliveryRequestList.deliveryNumber,
                          date: deliveryRequestList.createdAt,
                          image:
                              deliveryRequestList.productImages.firstOrNull ??
                                  '',
                          receiverName: deliveryRequestList.receiver.name,
                          receiverNumber: deliveryRequestList.receiver.phone,
                          receiverEmail: deliveryRequestList.receiver.email,
                          totalAmount: deliveryRequestList.total,
                          status: deliveryRequestList.status,
                        );
                      }),
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    )
                  ]),
                )),
              ),
            ));
  }
}

class DeliveryRequestScreenWidget extends StatelessWidget {
  final String image;
  final String trackingId;
  final String receiverName;
  final String receiverNumber;
  final String receiverEmail;
  final double totalAmount;
  final String status;
  final DateTime date;
  final void Function()? onTap;
  const DeliveryRequestScreenWidget({
    this.onTap,
    required this.image,
    required this.trackingId,
    required this.receiverName,
    required this.receiverNumber,
    required this.receiverEmail,
    required this.totalAmount,
    required this.status,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: AppColors.darkColor, width: 0.5),
                  color: AppColors.lineShapeColor),
              child: Row(
                children: [
                  SizedBox(
                    height: 90,
                    width: 80,
                    child: CachedNetworkImageWidget(
                        imageURL: image,
                        imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fitHeight),
                              ),
                            )),
                  ),
                  AppGaps.wGap10,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Receiver Details :',
                        style: AppTextStyles.bodySemiboldTextStyle,
                      ),
                      AppGaps.hGap5,
                      Text(receiverName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle),
                      AppGaps.hGap5,
                      Text(receiverNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle),
                      AppGaps.hGap5,
                      Text(receiverEmail,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle),
                    ],
                  )),
                  AppGaps.wGap10,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ' $trackingId',
                        style: AppTextStyles.bodySemiboldTextStyle
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                      AppGaps.hGap5,
                      Text(Helper.getCurrencyFormattedAmountText(totalAmount),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyTextStyle),
                      AppGaps.hGap5,
                      Text(Helper.ddMMMyyyyFormattedDateTime(date),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodySmallTextStyle),
                      AppGaps.hGap5,
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: status != 'delivered'
                                ? AppColors.secondaryColor.withOpacity(0.1)
                                : AppColors.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(status.toUpperCase(),
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySmallSemiboldTextStyle
                                .copyWith(
                                    color: status != 'delivered'
                                        ? AppColors.secondaryColor
                                        : AppColors.successColor)),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
