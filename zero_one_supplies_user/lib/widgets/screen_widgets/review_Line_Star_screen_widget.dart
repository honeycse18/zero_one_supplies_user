import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

/// Review star progress bar with text inside review screen.
class ReviewLineStarTextProgressBar extends StatelessWidget {
  final double starCount;
  final double parcent;
  final double starProgressValue;
  const ReviewLineStarTextProgressBar({
    super.key,
    required this.starCount,
    required this.parcent,
    required this.starProgressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          child: Text(
              '$starCount ${AppLanguageTranslation.starTransKey.toCurrentLanguage}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.bodyTextColor)),
        ),
        AppGaps.wGap8,
        Expanded(
          child: LinearPercentIndicator(
            barRadius: const Radius.circular(4),
            // width: 200,
            lineHeight: 8,
            percent: starProgressValue,
            backgroundColor: AppColors.darkColor.withOpacity(0.05),
            progressColor: AppColors.secondaryColor,
          ),
        ),
        AppGaps.wGap8,
        SizedBox(
          width: 50,
          child: Text('${parcent * 100} %',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.bodyTextColor)),
        ),
      ],
    );
  }
}
