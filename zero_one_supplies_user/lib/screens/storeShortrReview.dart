import 'package:ecomik/controller/SellerShortReviewScreenPage_controller.dart';
import 'package:ecomik/models/screen_parameters/message_recipient_screen_parameter.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SellerShortReviewScreenPage extends StatelessWidget {
  const SellerShortReviewScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellerShortReviewScreenPageController>(
        init: SellerShortReviewScreenPageController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: true,
                    /* actions: [
                      Center(
                        child: CustomIconButtonWidget(
                            onTap: () {},
                            hasShadow: true,
                            child: SvgPicture.asset(
                              AppAssetImages.searchSVGLogoLine,
                              color: AppColors.darkColor,
                              height: 18,
                              width: 18,
                            )),
                      ),
                      AppGaps.wGap20,
                    ], */
                    titleWidget: Text(
                      controller.theSeller.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor),
                    )),
                body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 160,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppGaps.hGap15,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppGaps.screenPaddingValue),
                              child: /* Container(
                                height: 118,
                                padding: const EdgeInsets.all(18.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: Row(children: [
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CachedNetworkImageWidget(
                                        imageURL: controller.theSeller.logo,
                                        imageBuilder: (context,
                                                imageProvider) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                ),
                                              ),
                                            )),
                                  ),
                                  AppGaps.wGap10,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            controller.theSeller.name,
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle,
                                          ),
                                          AppGaps.wGap8,
                                          SellerStatusBadgeWidget(
                                              status: controller
                                                  .theSeller.rating.status)
                                        ],
                                      ),
                                      AppGaps.hGap10,
                                      Text(
                                        controller.theSeller.category.name,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.bodyTextColor),
                                      ),
                                      AppGaps.hGap10,
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppAssetImages.starSVGLogoSolid,
                                            color: AppColors.secondaryColor,
                                          ),
                                          AppGaps.wGap3,
                                          Text(
                                            '(${controller.averageRating})',
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.bodyTextColor),
                                          )
                                        ],
                                      ),
                                      AppGaps.wGap4,
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // SvgPicture.asset(AppAssetImages
                                      //     .messageSVGLogoSolid),
                                      TightIconButtonWidget(
                                        child: SvgPicture.asset(
                                            AppAssetImages.messageSVGLogoSolid),
                                        onTap: () {
                                          Get.toNamed(
                                              AppPageNames.chatRecipientsScreen,
                                              arguments:
                                                  MessageRecipientScreenParameter(
                                                      vendorID: controller
                                                          .theSeller.vendor));
                                        },
                                      )
                                    ],
                                  )
                                ]),
                              ) */
                                  StoreShortInfoWidget(
                                imageURL: controller.theSeller.logo,
                                storeName: controller.theSeller.name,
                                isVerified: controller.theSeller.isVerified,
                                status: controller.theSeller.rating.status,
                                categoryName:
                                    controller.theSeller.category.name,
                                averageRating:
                                    controller.theSeller.rating.avgRating,
                                rightIconWidget: TightIconButtonWidget(
                                  onTap: () {
                                    Get.toNamed(
                                        AppPageNames.chatRecipientsScreen,
                                        arguments:
                                            MessageRecipientScreenParameter(
                                                vendorID: controller
                                                    .theSeller.vendor));
                                  },
                                  child: SvgPicture.asset(
                                      AppAssetImages.messageSVGLogoSolid),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                  body: CustomScaffoldBodyWidget(
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(child: AppGaps.hGap16),
                        /* <---- 'User reviews' and its category dropdown menu ----> */
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  AppLanguageTranslation
                                      .aboutUsTransKey.toCurrentLanguage,
                                  style: AppTextStyles.headLine6BoldTextStyle),
                              AppGaps.hGap8,
                              Text(controller.theSeller.description,
                                  textAlign: TextAlign.justify,
                                  style: AppTextStyles.bodyTextStyle),
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap25),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Text(
                                '${AppLanguageTranslation.reviewsTransKey.toCurrentLanguage} (${controller.theSeller.rating.sellerReviews})',
                                style: AppTextStyles.headLine6BoldTextStyle,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /* <---- Product rating stars widget ----> */
                                  SvgPicture.asset(
                                    AppAssetImages.starSVGLogoSolid,
                                    color: AppColors.secondaryColor,
                                  ),
                                  AppGaps.wGap4,
                                  /* <---- Product rating number text ----> */
                                  Text(
                                      '(${controller.theSeller.rating.avgRating})',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColors.bodyTextColor,
                                            fontWeight: FontWeight.w600,
                                          )),
                                ],
                              ),
                              AppGaps.wGap5,
                              TightIconButtonWidget(
                                child: SvgPicture.asset(
                                    AppAssetImages.arrowRightSVGLogoLine),
                                onTap: () {
                                  Get.toNamed(AppPageNames.storeReviewsScreen,
                                      arguments: controller.theSeller);
                                },
                              )
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap25),
                        SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                          final review = controller.reviews[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      Image.network(review.user.image).image,
                                  radius: 24,
                                ),
                                AppGaps.wGap16,
                                Expanded(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.user.firstName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    AppGaps.hGap5,
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StarWidget(rating: review.rating),
                                        Text(
                                          Helper.eeeMMMdFormattedDateTime(
                                              review.createdAt),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  color:
                                                      AppColors.bodyTextColor),
                                        ),
                                      ],
                                    ),
                                    AppGaps.hGap11,
                                    Text(
                                      review.review,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppColors.bodyTextColor),
                                    )
                                  ],
                                ))
                              ],
                            ),
                          );
                        }, childCount: controller.reviews.length))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

class StarWidget extends StatelessWidget {
  const StarWidget({
    super.key,
    required this.rating,
    // required this.review,
  });
  final double rating;

  // final StoreReviewsShortItem review;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 20,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => AppGaps.wGap2,
          itemCount: 5,
          itemBuilder: (context, index) => SvgPicture.asset(
            AppAssetImages.starSVGLogoSolid,
            color: rating >= (index + 1)
                ? AppColors.secondaryColor
                : AppColors.secondaryColor.withOpacity(0.5),
          ),
        ));
  }
}
