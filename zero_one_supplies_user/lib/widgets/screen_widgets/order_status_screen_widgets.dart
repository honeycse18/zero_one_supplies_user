import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:flutter/material.dart';

/// Stepper disabled widget from order status widget
class StepperDisabledWidget extends StatelessWidget {
  final String statusText;
  final String statusDescriptionText;
  const StepperDisabledWidget({
    super.key,
    required this.statusText,
    required this.statusDescriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppGaps.wGap55,
            AppGaps.wGap16,
            Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Container(
                height: 10,
                width: 10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkColor.withOpacity(0.2)),
              ),
            ),
            AppGaps.wGap16,
            Text(
              statusText,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        AppGaps.hGap10,
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppGaps.wGap55,
            AppGaps.wGap16,
            AppGaps.wGap16,
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: AppColors.primaryColor.withOpacity(0.15)))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.wGap16,
                    AppGaps.wGap16,
                    Expanded(
                      child: Text(
                        statusDescriptionText,
                        style: const TextStyle(
                            color: AppColors.bodyTextColor, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

/// Stepper enabled widget from order status widget
class StepperEnabledWidget extends StatelessWidget {
  // final String timeText;
  final String statusText;
  final String statusDescriptionText;
  const StepperEnabledWidget({
    super.key,
    /* 
    required this.timeText, */
    required this.statusText,
    required this.statusDescriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* SizedBox(
              width: 55,
              child: Text(timeText,
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.bodyTextColor)),
            ), */
            AppGaps.wGap16,
            Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.2)),
              child: Container(
                height: 16,
                width: 16,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    color: AppColors.primaryColor),
              ),
            ),
            AppGaps.wGap16,
            Text(
              statusText,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
        AppGaps.hGap10,
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppGaps.wGap55,
            AppGaps.wGap16,
            AppGaps.wGap16,
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: AppColors.primaryColor.withOpacity(0.15)))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.wGap16,
                    AppGaps.wGap16,
                    Expanded(
                      child: Text(
                        statusDescriptionText,
                        style: const TextStyle(
                            color: AppColors.bodyTextColor, fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
