import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// Review star progress bar with text inside review screen.
class ReviewStarTextProgressBar extends StatelessWidget {
  final double starCount;
  final double starProgressValue;
  const ReviewStarTextProgressBar({
    super.key,
    required this.starCount,
    required this.starProgressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            '$starCount ${AppLanguageTranslation.starTransKey.toCurrentLanguage}',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.bodyTextColor)),
        AppGaps.wGap8,
        Expanded(
          child: LinearPercentIndicator(
            barRadius: const Radius.circular(4),
            lineHeight: 8,
            percent: starProgressValue,
            backgroundColor: AppColors.darkColor.withOpacity(0.05),
            progressColor: AppColors.secondaryColor,
          ),
        ),
      ],
    );
  }
}
