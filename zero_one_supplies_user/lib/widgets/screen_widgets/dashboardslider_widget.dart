import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class DashboardSliderWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;

  const DashboardSliderWidget({
    super.key,
    this.onTap,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      child: CachedNetworkImageWidget(
        imageURL: imageURL,
        imageBuilder: (context, imageProvider) => Container(
          // height: 121,
          // width: 70,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
