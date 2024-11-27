import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerFilter extends StatelessWidget {
  final int value;
  final List<String> source;
  final void Function(int) onChanged;

  const SellerFilter({
    super.key,
    required this.value,
    required this.source,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.9),
            )),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16.0, 24, 16, 24),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              )),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        AppLanguageTranslation.filterTransKey.toCurrentLanguage,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      CustomTightTextButtonWidget(
                        child: Container(
                          margin: const EdgeInsets.all(18),
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.asset(AppAssetImages.cross).image,
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
                  // AppGaps.hGap12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomExpansionTile(
                        title: Text(
                            AppLanguageTranslation
                                .priceTransKey.toCurrentLanguage,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        children: <Widget>[
                          Wrap(
                            spacing: 8.0, // set the spacing between the widgets
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Min.',
                                    ),
                                  ),
                                  AppGaps.wGap12,
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Max',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(AppLanguageTranslation
                          .helloTransKey.toCurrentLanguage),
                      // CustomExpansionTile(
                      //     title: Text('Categories',
                      //         style: TextStyle(
                      //             fontSize: 20, fontWeight: FontWeight.w600)),
                      //     children: [
                      //       ChipsChoice<int>.single(
                      //         value: value,
                      //         onChanged: onChanged,
                      //         choiceItems: C2Choice.listFrom<int, String>(
                      //           source: source,
                      //           value: (i, v) => i,
                      //           label: (i, v) => v,
                      //         ),
                      //         choiceStyle:
                      //             C2ChoiceStyle(color: AppColors.primaryColor),
                      //       ),
                      //     ]),
                    ],
                  ),
                  Column(
                    children: [
                      CustomExpansionTile(
                        title: Text(
                            AppLanguageTranslation
                                .brandTransKey.toCurrentLanguage,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        children: <Widget>[
                          Wrap(
                            spacing: 8.0, // set the spacing between the widgets
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Min.',
                                    ),
                                  ),
                                  AppGaps.wGap12,
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Max',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomExpansionTile(
                        title: Text(
                            AppLanguageTranslation
                                .reviewTransKey.toCurrentLanguage,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600)),
                        children: <Widget>[
                          Wrap(
                            spacing: 8.0, // set the spacing between the widgets
                            children: <Widget>[
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Min.',
                                    ),
                                  ),
                                  AppGaps.wGap12,
                                  Expanded(
                                    child: CustomTextFormField(
                                      hintText: 'Max',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  /*  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final specification = specifications[index];
                        return SpecificationItemWidget(
                            name: specification.first,
                            value: specification.second);
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap12,
                      itemCount: specifications.length), */
                  // const Spacer(),
                ]),
          ),
        ),
      ),
    );
  }
}
