import 'package:ecomik/controller/splash_screen_controller.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) => Scaffold(
              /* <-------- Content --------> */
              backgroundColor: Colors.transparent,
              body: DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset(AppAssetImages.splashScreenAbstract)
                            .image,
                        fit: BoxFit.fitWidth)),
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* <----- App logo -----> */
                      // Image.asset(AppAssetImages.logoWhite, height: 92, width: 92),
                      // AppGaps.wGap10,
                      // /* <---- App name text ----> */
                      // const Text(
                      //   // Edit this app version code text as it changes
                      //   'Ecomik',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 56,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
