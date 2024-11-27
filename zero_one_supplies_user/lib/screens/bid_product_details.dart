import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BidProductDetailsScreen extends StatelessWidget {
  const BidProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: Image.asset(AppAssetImages.backgroundFullPng).image,
              fit: BoxFit.fill)),
      child: Scaffold(
          /* <-------- Appbar --------> */
          // appBar: CoreWidgets.appBarWidget(
          //     screenContext: context,
          //     titleWidget: const Text('Auction Product')),
          appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            hasBackButton: true,
            /* <---- Appbar left side widgets ----> */
            titleWidget: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppGaps.wGap20,
                  /* <---- heart icon ----> */
                  const Spacer(),
                  CustomIconButtonWidget(
                      hasShadow: false,
                      child: SvgPicture.asset(AppAssetImages.heartSVGLogoSolid,
                          color: AppColors.primaryColor)),
                ]),
          ),
          /* <-------- Content --------> */
          body: CustomScaffoldBodyWidget(
            child: CustomScrollView(
              slivers: [
                /* <---- Top extra spaces ----> */
                const SliverToBoxAdapter(child: AppGaps.hGap10),
                SliverToBoxAdapter(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 366,
                          height: 253,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppAssetImages.bidproduct),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          )),
    );
  }
}
