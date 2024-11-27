import 'package:ecomik/controller/single_product_review_controller.dart';
import 'package:ecomik/models/api_responses/single_product_review_response.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/review_Line_Star_screen_widget.dart';
import 'package:ecomik/widgets/star_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SingleProductReviewsScreen extends StatelessWidget {
  const SingleProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleProductReviewsScreenController>(
        init: SingleProductReviewsScreenController(),
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
                        .reviewsTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async => controller
                        .singleProductReviewPagingController
                        .refresh(),
                    child: CustomScrollView(
                      slivers: [
                        // Top extra spaces
                        const SliverToBoxAdapter(child: AppGaps.hGap15),

                        SliverToBoxAdapter(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(AppLanguageTranslation
                                    .customerReviewsTransKey.toCurrentLanguage),
                                AppGaps.hGap2,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StarWidget(
                                        review: controller.theProduct.rating),
                                    AppGaps.wGap8,
                                    Text(
                                        '${controller.theProduct.rating} out of 5')
                                  ],
                                ),
                                AppGaps.hGap30,
                                ReviewLineStarTextProgressBar(
                                  starCount: 5,
                                  starProgressValue:
                                      controller.getStarProgressValue(5),
                                  parcent: controller.getStarProgressValue(5),
                                ),
                                AppGaps.hGap8,
                                ReviewLineStarTextProgressBar(
                                  starCount: 4,
                                  starProgressValue:
                                      controller.getStarProgressValue(4),
                                  parcent: controller.getStarProgressValue(4),
                                ),
                                AppGaps.hGap8,
                                ReviewLineStarTextProgressBar(
                                  starCount: 3.5,
                                  starProgressValue:
                                      controller.getStarProgressValue(3.5),
                                  parcent: controller.getStarProgressValue(3.5),
                                ),
                                AppGaps.hGap8,
                                ReviewLineStarTextProgressBar(
                                  starCount: 3,
                                  starProgressValue:
                                      controller.getStarProgressValue(3),
                                  parcent: controller.getStarProgressValue(3),
                                ),
                                AppGaps.hGap8,
                                ReviewLineStarTextProgressBar(
                                  starCount: 2,
                                  starProgressValue:
                                      controller.getStarProgressValue(2),
                                  parcent: controller.getStarProgressValue(2),
                                ),
                                AppGaps.hGap8,
                                ReviewLineStarTextProgressBar(
                                  starCount: 1,
                                  starProgressValue:
                                      controller.getStarProgressValue(1),
                                  parcent: controller.getStarProgressValue(1),
                                ),
                              ]),
                        ),
                        // AppGaps.hGap30,
                        const SliverToBoxAdapter(child: AppGaps.hGap30),
                        SliverToBoxAdapter(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  AppLanguageTranslation
                                      .userReviewTransKey.toCurrentLanguage,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              PopupMenuButton<int>(
                                  padding: const EdgeInsets.only(right: 5),
                                  position: PopupMenuPosition.under,
                                  // icon: const Icon(Icons.more_vert_rounded, color: AppColors.darkColor),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLanguageTranslation
                                              .mostUsefulTransKey
                                              .toCurrentLanguage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500)),
                                      SvgPicture.asset(
                                          AppAssetImages.arrowDownSVGLogoLine,
                                          color: AppColors.darkColor,
                                          height: 12,
                                          width: 12),
                                    ],
                                  ),
                                  itemBuilder: (context) => [
                                        PopupMenuItem<int>(
                                          value: 0,
                                          child: Text(
                                            AppLanguageTranslation
                                                .newestTransKey
                                                .toCurrentLanguage,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: Text(
                                            AppLanguageTranslation
                                                .oldestTransKey
                                                .toCurrentLanguage,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 2,
                                          child: Text(
                                            AppLanguageTranslation
                                                .mostRelevantTransKey
                                                .toCurrentLanguage,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ])
                            ],
                          ),
                        ),
                        // Bottom extra spaces
                        const SliverToBoxAdapter(child: AppGaps.hGap16),
                        PagedSliverList.separated(
                          pagingController:
                              controller.singleProductReviewPagingController,
                          builderDelegate: PagedChildBuilderDelegate<
                              SingleProductReviewShortItem>(
                            itemBuilder: (context, item, index) {
                              final SingleProductReviewShortItem review = item;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 32),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            Image.network(review.user.image)
                                                .image,
                                        radius: 24,
                                      ),
                                      AppGaps.wGap16,
                                      Expanded(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              StarWidget(review: review.rating),
                                              Text(
                                                Helper.eeeMMMdFormattedDateTime(
                                                    review.createdAt),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .bodyTextColor),
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
                                                    color: AppColors
                                                        .bodyTextColor),
                                          )
                                        ],
                                      ))
                                    ]),
                              );
                            },
                          ),
                          separatorBuilder: (context, index) => AppGaps.hGap16,
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap30),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
