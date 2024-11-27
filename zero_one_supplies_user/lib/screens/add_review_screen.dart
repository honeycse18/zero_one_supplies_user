import 'package:ecomik/controller/add_review_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({super.key});

  /// Currently star rate value

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddReviewScreenController>(
        init: AddReviewScreenController(),
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
                    titleWidget: Text(AppLanguageTranslation
                        .reviewTransKey.toCurrentLanguage)),
                /* <-------- Content --------> */
                body: CustomScaffoldBodyWidget(
                  child: Center(
                      child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /* <---- Add review illustration ----> */
                        Image.asset(AppAssetImages.addReviewIllustration,
                            height: 170, width: 170),
                        AppGaps.hGap56,
                        Text(
                            AppLanguageTranslation
                                .pleaseLeaveAFeedBackTransKey.toCurrentLanguage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium),
                        AppGaps.hGap24,
                        /* <---- Review stars row ----> */
                        SizedBox(
                          height: 24,
                          child: RatingBar.builder(
                            initialRating:
                                controller.currentStarRate.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 24.0,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => SvgPicture.asset(
                              AppAssetImages.starSVGLogoSolid,
                              color: controller.currentStarRate >= _ + 1
                                  ? AppColors.secondaryColor
                                  : AppColors.secondaryColor.withOpacity(0.5),
                            ),
                            onRatingUpdate: (rating) {
                              controller.updateRating(rating.toInt());
                              controller.update();
                            },
                          ),
                        ),

                        AppGaps.hGap56,
                        /* <---- Review text with caption ----> */
                        CustomTextFormField(
                          controller: controller.reviewController,
                          hintText: AppLanguageTranslation
                              .tellUsSomethingTransKey.toCurrentLanguage,
                          labelText: AppLanguageTranslation
                              .tellUsSomethingTransKey.toCurrentLanguage,
                          minLines: 3,
                          maxLines: 5,
                        ),
                        // Bottom extra spaces
                        AppGaps.hGap30,
                      ],
                    ),
                  )),
                ),
                /* <-------- Bottom bar --------> */
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  child: CustomStretchedTextButtonWidget(
                      buttonText: AppLanguageTranslation
                          .submitReviewTransKey.toCurrentLanguage,
                      onTap: controller.postReview),
                ),
              ),
            ));
  }
}
