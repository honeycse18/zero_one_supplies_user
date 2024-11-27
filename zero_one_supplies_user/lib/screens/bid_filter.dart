import 'dart:ui';

import 'package:ecomik/controller/bid_filter_controller.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/screen_widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants/app_images.dart';

class BidFilter extends StatelessWidget {
  const BidFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BidFilterScreenController>(
        init: BidFilterScreenController(),
        builder: (controller) => Scaffold(
              body: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset(AppAssetImages.backbg).image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: DecoratedBox(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 24,
                        spreadRadius: 16,
                        color: Colors.black.withOpacity(0.2),
                      )
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.all(18),
                          height: 300,
                          // width: 300,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
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
                                  // const Spacer(),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(18),
                                        child: Text(
                                          AppLanguageTranslation
                                              .filterTransKey.toCurrentLanguage,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        margin: const EdgeInsets.all(18),
                                        height: 13,
                                        width: 13,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: Image.asset(
                                                    AppAssetImages.cross)
                                                .image,
                                            //          xFit.fill
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  // const Spacer(),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        child: CustomExpansionTile(
                                          title: Text(
                                              AppLanguageTranslation
                                                  .shortByTransKey
                                                  .toCurrentLanguage,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                          children: <Widget>[
                                            Wrap(
                                              spacing:
                                                  8.0, // set the spacing between the widgets
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  //color: Colors.white,
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .recentlyStartedTransKey
                                                          .toCurrentLanguage),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  //color: Colors.white,
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .endingSoonTransKey
                                                          .toCurrentLanguage),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  //color: Colors.white,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .priceLowToHighTransKey
                                                          .toCurrentLanguage),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  //color: Colors.white,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .priceHighToLowTransKey
                                                          .toCurrentLanguage),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        child: CustomExpansionTile(
                                          title: Text(
                                              AppLanguageTranslation
                                                  .categoriesTransKey
                                                  .toCurrentLanguage,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                          children: <Widget>[
                                            Wrap(
                                              // set the spacing between the widgets
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  //color: Colors.white,
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .handMadeTransKey
                                                          .toCurrentLanguage),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  //color: Colors.white,
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .africanArtTransKey
                                                          .toCurrentLanguage),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  //color: Colors.white,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .frameArtTransKey
                                                          .toCurrentLanguage),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(5),
                                        child: CustomExpansionTile(
                                          title: Text(
                                              AppLanguageTranslation
                                                  .subCategoriesTransKey
                                                  .toCurrentLanguage,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                          children: <Widget>[
                                            Wrap(
                                              // set the spacing between the widgets
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  //color: Colors.white,
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .handMadeTransKey
                                                          .toCurrentLanguage),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  //color: Colors.white,
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .africanArtTransKey
                                                          .toCurrentLanguage),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  //width: 50,
                                                  height: 30,
                                                  //color: Colors.white,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                      border: Border.all(
                                                        width: 1.5,
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                      )),
                                                  child: Text(
                                                      AppLanguageTranslation
                                                          .frameArtTransKey
                                                          .toCurrentLanguage),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  Row(
                                    children: [
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     // Action to be performed when the button is pressed
                                      //   },
                                      //   child: Text('Click me!'),
                                      // ),
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          AppLanguageTranslation
                                              .clearAllTransKey
                                              .toCurrentLanguage,
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          Get.toNamed(AppPageNames.bidAuction);
                                          // Action to be performed when the button is pressed
                                        },
                                        child: Text(
                                          AppLanguageTranslation
                                              .applyFilterTransKey
                                              .toCurrentLanguage,
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
