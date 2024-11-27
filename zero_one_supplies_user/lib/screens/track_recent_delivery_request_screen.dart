import 'package:ecomik/controller/track_recent_delivery_request_screen_controller.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class TrackRecentDeliveryRequestScreen extends StatelessWidget {
  const TrackRecentDeliveryRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackRecentDeliveryRequestScreenController>(
      init: TrackRecentDeliveryRequestScreenController(),
      builder: (controller) => DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: Image.asset(AppAssetImages.backgroundFullPng).image,
                fit: BoxFit.fill)),
        child: Scaffold(
          /* <-------- Empty appbar with back button --------> */
          /* <-------- Appbar --------> */
          appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleWidget: Text('Track Recent Delivery Request')),
          body: ScaffoldBodyWidget(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppGaps.hGap20,
                  Text(
                    'Delivery Summary',
                    style: AppTextStyles.headLine6MediumTextStyle,
                  ),
                  AppGaps.hGap10,
                  Text(
                    'Delivery Request Id: 01S-50',
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  AppGaps.hGap30,
                  Text(
                    'Receiver Name: dfgsdg',
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  Text(
                    'Receiver Phone: 01581837792',
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  Text(
                    'Receiver Address: Botiaghata, Khulna',
                    style: AppTextStyles.bodyLargeTextStyle,
                  ),
                  AppGaps.hGap20,
                  Text(
                    'Total Price & Vat :',
                    style: AppTextStyles.bodyLargeTextStyle
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  AppGaps.hGap10,
                  Text(
                    '15 524,00 F CFA',
                    style: AppTextStyles.headLine6MediumTextStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  AppGaps.hGap40,
                  Text('Product Dimension:',
                      style: AppTextStyles.headLine6MediumTextStyle),
                  AppGaps.hGap20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Length:',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '12',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        'Width:',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '102',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Height:',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '105',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        'Weight:',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '10',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  AppGaps.hGap40,
                  Text('Delivery Charge',
                      style: AppTextStyles.headLine6MediumTextStyle),
                  AppGaps.hGap20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Charge',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '1st KM: 100,00 & Rest: 50,00',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  AppGaps.hGap5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Distance',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '223.79 KM',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  AppGaps.hGap5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Delivery Charge',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '11 239,50 F CFA',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  AppGaps.hGap40,
                  Text('Package Charge',
                      style: AppTextStyles.headLine6MediumTextStyle),
                  AppGaps.hGap20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weight Charge(per KG)',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '100,00 F CFA',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  AppGaps.hGap5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weight',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '42.84 KG',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  AppGaps.hGap5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Package Charge',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                      Text(
                        '4 284,00 F CFA',
                        style: AppTextStyles.bodyLargeTextStyle,
                      ),
                    ],
                  ),
                  AppGaps.hGap40,
                  Text('Product Images',
                      style: AppTextStyles.headLine6MediumTextStyle),
                  AppGaps.hGap20,
                  Image.asset('assets/images/surprised-curly-woman.png'),
                  AppGaps.hGap50,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
