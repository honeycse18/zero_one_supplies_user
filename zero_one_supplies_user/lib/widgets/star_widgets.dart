import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({
    super.key,
    required this.review,
  });

  final double review;

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
            color: review >= (index + 1)
                ? AppColors.secondaryColor
                : AppColors.secondaryColor.withOpacity(0.5),
          ),
        ));
  }
}
