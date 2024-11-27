import 'package:ecomik/models/fake_models/product_review_model.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Review widget
class ReviewDetailsWidget extends StatelessWidget {
  const ReviewDetailsWidget({
    super.key,
    required this.review,
  });

  final ProductReview review;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: review.reviewerProfileImage,
          radius: 24,
        ),
        AppGaps.wGap16,
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.reviewerName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            AppGaps.hGap5,
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 20,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => AppGaps.wGap2,
                      itemCount: 5,
                      itemBuilder: (context, index) => SvgPicture.asset(
                        AppAssetImages.starSVGLogoSolid,
                        color: review.rating >= (index + 1)
                            ? AppColors.secondaryColor
                            : AppColors.secondaryColor.withOpacity(0.5),
                      ),
                    )),
                Text(
                  review.reviewDateText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.bodyTextColor),
                ),
              ],
            ),
            AppGaps.hGap11,
            Text(
              review.reviewText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.bodyTextColor),
            ),
            AppGaps.hGap10,
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset(AppAssetImages.review1).image,
                      fit: BoxFit.cover)),
            )
          ],
        ))
      ],
    );
  }
}

/// Product size widget
class ProductSizeWidget extends StatelessWidget {
  final String availableSizeText;
  final bool isSelected;
  final void Function()? onTap;
  const ProductSizeWidget(
      {super.key,
      required this.availableSizeText,
      required this.isSelected,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Stack(
        alignment: Alignment.center,
        children: [
          CustomIconButtonWidget(
              backgroundColor: AppColors.shadeColor1,
              borderRadiusRadiusValue: const Radius.circular(12),
              onTap: onTap,
              child: Text(
                availableSizeText,
                style: const TextStyle(
                    color: AppColors.bodyTextColor,
                    fontWeight: FontWeight.w500),
              )),
          Positioned(
            top: 1,
            right: 0,
            child: SvgPicture.asset(
              AppAssetImages.tickRoundedSVGLogoSolid,
              height: 12,
              width: 12,
              color: AppColors.successColor,
            ),
          )
        ],
      );
    }
    return CustomIconButtonWidget(
        backgroundColor: AppColors.shadeColor1,
        borderRadiusRadiusValue: const Radius.circular(12),
        onTap: onTap,
        child: Text(
          availableSizeText,
          style: const TextStyle(
              color: AppColors.bodyTextColor, fontWeight: FontWeight.w500),
        ));
  }
}

class SpecificationItemWidget extends StatelessWidget {
  final String name;
  final String value;

  const SpecificationItemWidget({
    super.key,
    this.name = '',
    this.value = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 18),
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(right: 18),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
