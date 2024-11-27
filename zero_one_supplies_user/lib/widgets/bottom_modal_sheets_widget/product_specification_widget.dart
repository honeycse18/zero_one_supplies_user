import 'dart:ui';

import 'package:dartx/dartx.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/screen_widgets/product_detail_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecificationFilter extends StatelessWidget {
  final List<Pair<String, String>> specifications;
  const SpecificationFilter({
    super.key,
    required this.specifications,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                height: 300,
                alignment: Alignment.topLeft,
                // margin: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.9),
                    )),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      )),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.fromLTRB(18.0, 0.0, 12, 0.0),
                              child: Text(
                                LanguageHelper.currentLanguageText(
                                    LanguageHelper.specificationTransKey),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.all(18),
                                height: 13,
                                width: 13,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        Image.asset(AppAssetImages.cross).image,
                                    //          xFit.fill
                                  ),
                                ),
                              ),
                              onTap: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                        AppGaps.hGap15,
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final specification = specifications[index];
                              return SpecificationItemWidget(
                                  name: specification.first,
                                  value: specification.second);
                            },
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap15,
                            itemCount: specifications.length),
                        // const Spacer(),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
