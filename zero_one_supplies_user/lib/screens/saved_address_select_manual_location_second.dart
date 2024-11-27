import 'package:ecomik/controller/saved_manusal_address_second_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SaveManualAddressSecondScreen extends StatelessWidget {
  const SaveManualAddressSecondScreen({super.key});

  /// Bottom slider panel controller

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<SaveManualAddressSecondScreenController>(
        init: SaveManualAddressSecondScreenController(),
        builder: (controller) => DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Scaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleWidget: Text(AppLanguageTranslation
                    .setLocationTransKey.toCurrentLanguage),
              ),

              /* <-------- Content --------> */
              body: SlidingUpPanel(
                controller: controller.panelController,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                backdropEnabled: true,
                backdropColor: AppColors.lineShapeColor,
                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 0),
                backdropOpacity: 0.8,
                boxShadow: const [],
                color: Colors.transparent,
                minHeight: 50,
                /* <---- Bottom slider top notch portion ----> */
                header: SizedBox(
                  width: screenSize.width - 48,
                  height: 150,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                          top: 12,
                          child: SvgPicture.asset(
                              AppAssetImages.slideUpPanelNotchSVG,
                              color: const Color.fromARGB(234, 242, 228, 253)
                                  .withOpacity(0.26))),
                      Positioned(
                          top: 22,
                          child: SvgPicture.asset(
                            AppAssetImages.arrowUpSVGLogoLine,
                            color: AppColors.primaryColor.withOpacity(0.5),
                            width: 40,
                          ))
                    ],
                  ),
                ),
                /* <---- Bottom slider bottom button portion ----> */
                panelBuilder: (sc) => Container(
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image:
                            Image.asset(AppAssetImages.backgroundFullPng).image,
                        fit: BoxFit.fill),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: Image.asset(AppAssetImages.backgroundFullPng)
                                .image,
                            fit: BoxFit.fill)),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              labelText: AppLanguageTranslation
                                  .isThisYourLocationTransKey.toCurrentLanguage,
                              hintText: AppLanguageTranslation
                                  .selectLocationTransKey.toCurrentLanguage,
                              maxLines: 1,
                              hasShadow: true,
                              prefixIcon:
                                  SvgPicture.asset(AppAssetImages.location),
                              suffixIcon:
                                  SvgPicture.asset(AppAssetImages.cross),
                            ),
                            AppGaps.hGap24,
                            CustomStretchedButtonWidget(
                              onTap: () {
                                // Get.toNamed(AppPageNames.addAddressScreen);
                                // Get.toNamed(AppPageNames.saveManualAddressSecondScreen);
                              },
                              child: Text(AppLanguageTranslation
                                  .confirmOrderTransKey.toCurrentLanguage),
                            )
                          ]),
                    ),
                  ),
                ),
                /* <---- Actual content ----> */
              ),
            )));
  }
}
