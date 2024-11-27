import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class BidPersonWidget extends StatelessWidget {
  final String name;
  final String image;
  final DateTime dateTime;
  final double bidPrice;

  const BidPersonWidget({
    super.key,
    this.name = '',
    this.image = '',
    required this.dateTime,
    this.bidPrice = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(children: [
        SizedBox(
          height: 80,
          width: 80,
          child: CachedNetworkImageWidget(
            imageURL: image,
            loadingAssetImageLocation: AppAssetImages.profileAvatar,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  borderRadius: AppComponents.imageBorder,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ),
        ),
        AppGaps.wGap10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkColor),
              ),
              AppGaps.hGap10,
              Text(
                Helper.ddMMMyyyyHHmmFormattedDateTime(dateTime),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: AppColors.bodyTextColor),
              ),
              AppGaps.hGap10,
              Text(
                Helper.getCurrencyFormattedAmountText(bidPrice),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkColor),
              ),
              AppGaps.wGap4,
            ],
          ),
        ),
      ]),
    );
  }

  String getDateTimeText() {
    return '';
  }
}

class SpecificationWidget extends StatelessWidget {
  final String title;
  final String content;
  const SpecificationWidget({
    super.key,
    this.title = '',
    this.content = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SvgPicture.asset(AppAssetImages.tickTruck),
        // AppGaps.hGap5,
        Text(
          title,
          style: AppTextStyles.bodyLargeSemiboldTextStyle,
        ),
        AppGaps.hGap5,
        Text(
          content,
          style: AppTextStyles.bodyMediumTextStyle
              .copyWith(color: AppColors.bodyTextColor),
        )
      ],
    );
  }
}

class BidCountdownTimer extends StatelessWidget {
  final DateTime bidEndDateTime;
  const BidCountdownTimer({
    super.key,
    required this.bidEndDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 21),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: AppComponents.borderRadius(12)),
      child: BidCountdownTimerWidget(
        bidEndDateTime: bidEndDateTime,
        builder: (controller) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.remainingDaysText,
                    style: AppTextStyles.bidCounterNumberTextStyle),
                Text(AppLanguageTranslation.daysTransKey.toCurrentLanguage,
                    style: AppTextStyles.bidCounterTextTextStyle),
              ],
            ),
            AppGaps.wGap10,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.remainingHoursText,
                    style: AppTextStyles.bidCounterNumberTextStyle),
                Text(AppLanguageTranslation.hoursTransKey.toCurrentLanguage,
                    style: AppTextStyles.bidCounterTextTextStyle),
              ],
            ),
            AppGaps.wGap10,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.remainingMinutesText,
                    style: AppTextStyles.bidCounterNumberTextStyle),
                Text(AppLanguageTranslation.minutesTransKey.toCurrentLanguage,
                    style: AppTextStyles.bidCounterTextTextStyle),
              ],
            ),
            AppGaps.wGap10,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.remainingSecondsText,
                    style: AppTextStyles.bidCounterNumberTextStyle),
                Text(AppLanguageTranslation.secondsTransKey.toCurrentLanguage,
                    style: AppTextStyles.bidCounterTextTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
