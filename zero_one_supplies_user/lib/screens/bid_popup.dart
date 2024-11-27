import 'dart:ui';

import 'package:ecomik/controller/bid_popup_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidPopup extends StatelessWidget {
  const BidPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BidPopupScreenController>(
        init: BidPopupScreenController(),
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
                          height: 350,
                          // width: 300,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
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
                                      margin: const EdgeInsets.fromLTRB(
                                          18.0, 0.0, 12, 0.0),
                                      child: Text(
                                        AppLanguageTranslation.placeABidTransKey
                                            .toCurrentLanguage,
                                        style: const TextStyle(
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
                                          image:
                                              Image.asset(AppAssetImages.cross)
                                                  .image,
                                          //          xFit.fill
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(18),
                                      child: const Text(
                                        r'$65.00',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Text(
                                      AppLanguageTranslation
                                          .lastHighestBidTransKey
                                          .toCurrentLanguage,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 18),
                                      child: Text(
                                        AppLanguageTranslation
                                            .enterBidAmountTransKey
                                            .toCurrentLanguage,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                AppGaps.hGap10,
                                const TextField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(30),
                                    //labelText: 'Enter your name',
                                    hintText: r'Eg: $65',
                                    border: OutlineInputBorder(),
                                  ),
                                ),

                                // const Expanded(
                                //     child: CustomTextFormField(
                                //   hasShadow: false,
                                //   hintText: r'Eg: $65',
                                //   // prefixIcon: SvgPicture.asset(
                                //   //     AppAssetImages.searchSVGLogoLine,
                                //   //     color: AppColors.primaryColor)
                                // )),
                                AppGaps.hGap10,
                                // const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 320,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          // Action to be performed when the button is pressed
                                        },
                                        child: Text(
                                          AppLanguageTranslation
                                              .bidNowTransKey.toCurrentLanguage,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Action to be performed when the button is pressed
                                        Get.back();
                                      },
                                      child: Text(
                                        AppLanguageTranslation
                                            .clearAllTransKey.toCurrentLanguage,
                                        style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
