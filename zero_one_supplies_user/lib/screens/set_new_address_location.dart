import 'package:ecomik/controller/set_new_address_location_screen_controller.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/saved_address_select_location_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SetNewAddressLocationScreen extends StatelessWidget {
  const SetNewAddressLocationScreen({super.key});

  /// Bottom slider panel controller

  @override
  Widget build(BuildContext context) {
    /// Get screen size
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<SetNewAddressLocationScreenController>(
        init: SetNewAddressLocationScreenController(),
        builder: (controller) => DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Scaffold(
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                hasBackButton: true,
                titleWidget: Text(controller.screenTitle),
              ),

              /* <-------- Content --------> */
              body: SlidingUpPanel(
                controller: controller.panelController,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                backdropEnabled: true,
                backdropColor: AppColors.lineShapeColor,
                margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                backdropOpacity: 0.8,
                boxShadow: const [],
                color: Colors.transparent,
                minHeight: 50,
                maxHeight: 300,
                /* <---- Bottom slider top notch portion ----> */
                header: SizedBox(
                  width: screenSize.width - 00,
                  height: 150,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                          top: 12,
                          child: SvgPicture.asset(
                            AppAssetImages.slideUpPanelNotchSVG,
                            color: AppColors.backgroundColor,
                          )),
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
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BottomContentWidget(
                          textEditingController:
                              controller.locationAddressController,
                          isLocationSelected: controller.isLocationSelected,
                          onConfirmTap: controller.onConfirmTap,
                          onCrossButtonTap: controller.resetAddressSelection),
                    )),
                  ),
                ),
                /* <---- Actual content ----> */
                body: GoogleMap(
                  // mapType: MapType.,
                  initialCameraPosition:
                      AppSingleton.instance.defaultCameraPosition,
                  markers: controller.googleMapMarkers,
                  onMapCreated: controller.onGoogleMapCreated,
                  onTap: controller.onGoogleMapTap,
                ),
              ),
              floatingActionButton: FloatingActionButton.small(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14))),
                  onPressed: controller.onLocationButtonTap,
                  child: SvgPicture.asset(AppAssetImages.gpsSVGLogoLine,
                      color: Colors.white)),
            )));
  }
}
