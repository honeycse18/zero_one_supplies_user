import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

class TopBrandsScreenWidget extends StatelessWidget {
  final String image;

  const TopBrandsScreenWidget({
    super.key,
    this.image = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 111,
      width: 111,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 63,
          // width: 60,
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
      ]),
    );
  }

  String getDateTimeText() {
    return '';
  }
}
