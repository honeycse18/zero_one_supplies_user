import 'package:ecomik/controller/send_offer_list_screen_controller.dart';
import 'package:ecomik/models/api_responses/send_an_offer_list_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/send_offer_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SendOfferListScreen extends StatelessWidget {
  const SendOfferListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SendOfferListScreenScreenController>(
        init: SendOfferListScreenScreenController(),
        global: false,
        builder: (controller) => DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: Image.asset(AppAssetImages.backgroundFullPng).image,
                    fit: BoxFit.fill)),
            child: Scaffold(
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  hasBackButton: true,
                  titleWidget: Text(AppLanguageTranslation
                      .sendOffersTransKey.toCurrentLanguage)),
              body: CustomScaffoldBodyWidget(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.sendOffersPagingController.refresh(),
                  child: CustomScrollView(
                    slivers: [
                      /* <---- Top extra spaces ----> */
                      const SliverToBoxAdapter(
                        child: AppGaps.hGap10,
                      ),
                      SliverToBoxAdapter(
                          child: Text(
                        AppLanguageTranslation
                            .allOffersTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      )),
                      const SliverToBoxAdapter(
                        child: AppGaps.hGap20,
                      ),
                      PagedSliverList.separated(
                        pagingController: controller.sendOffersPagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<SendOfferListItem>(
                                noItemsFoundIndicatorBuilder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              EmptyScreenWidget(
                                  //-----------------------
                                  height: 150,
                                  isSVGImage: true,
                                  localImageAssetURL: AppAssetImages.noOfferSvg,
                                  title: AppLanguageTranslation
                                      .youHaveNotSendAnyOffersYetTransKey
                                      .toCurrentLanguage,
                                  shortTitle: '')
                            ],
                          );
                        }, itemBuilder: (context, item, index) {
                          final SendOfferListItem sendOfferList = item;
                          return SendOfferListWidget(
                            onTap: () async => controller.onBuyNowTap(
                                sendOfferList.id,
                                sendOfferList.product.id,
                                sendOfferList.quantity,
                                sendOfferList.store.id,
                                sendOfferList.product.productLocation),
                            isCancelled: sendOfferList.status == 'Cancelled'
                                ? true
                                : false,
                            status: sendOfferList.status,
                            productImageUrl: sendOfferList.product.productImage,
                            productName: sendOfferList.product.name,
                            sellerName: sendOfferList.store.name,
                            originalPrice: sendOfferList.product.price,
                            offeringPrice: sendOfferList.price,
                            quantity: sendOfferList.quantity,
                            date: sendOfferList.createdAt,
                          );
                        }),
                        separatorBuilder: (context, index) => AppGaps.hGap16,
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
