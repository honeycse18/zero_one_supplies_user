import 'package:ecomik/controller/create_delivery_request_screen_controller.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:ecomik/utils/constants/app_gaps.dart';
import 'package:ecomik/utils/constants/app_images.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/add_delivery_request_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/enums.dart';

class CreateDeliveryRequestScreen extends StatelessWidget {
  const CreateDeliveryRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateDeliveryRequestScreenController>(
        global: false,
        init: CreateDeliveryRequestScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                  appBar: CoreWidgets.appBarWidget(
                      screenContext: context,
                      hasBackButton: true,
                      titleWidget: Text('Delivery Request')),
                  body: ScaffoldBodyWidget(
                      child: Column(
                    children: [
                      Expanded(
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                                child: Obx(
                              () => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppGaps.hGap16,
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: GestureDetector(
                                          child: AddDeliveryRequestTabWidget(
                                            isLine: true,
                                            tabIndex: 1,
                                            tabName: 'Sender',
                                            myTabState:
                                                AddDeliveryRequestTabState
                                                    .step1,
                                            currentTabState: controller
                                                .addDeliveryRequestTabState
                                                .value,
                                          ),
                                          onTap: () {
                                            controller
                                                    .addDeliveryRequestTabState
                                                    .value =
                                                AddDeliveryRequestTabState
                                                    .step1;
                                          },
                                        )),
                                        Expanded(
                                            child: GestureDetector(
                                          child: AddDeliveryRequestTabWidget(
                                            isLine: true,
                                            tabIndex: 2,
                                            tabName: 'Receiver',
                                            myTabState:
                                                AddDeliveryRequestTabState
                                                    .step2,
                                            currentTabState: controller
                                                .addDeliveryRequestTabState
                                                .value,
                                          ),
                                          onTap: () {
                                            controller
                                                    .addDeliveryRequestTabState
                                                    .value =
                                                AddDeliveryRequestTabState
                                                    .step2;
                                          },
                                        )),
                                        Expanded(
                                            child: GestureDetector(
                                          child: AddDeliveryRequestTabWidget(
                                            isLine: true,
                                            tabIndex: 3,
                                            tabName: 'Parcel',
                                            myTabState:
                                                AddDeliveryRequestTabState
                                                    .step3,
                                            currentTabState: controller
                                                .addDeliveryRequestTabState
                                                .value,
                                          ),
                                          onTap: () {
                                            controller
                                                    .addDeliveryRequestTabState
                                                    .value =
                                                AddDeliveryRequestTabState
                                                    .step3;
                                          },
                                        )),
                                        Expanded(
                                            child: GestureDetector(
                                          child: AddDeliveryRequestTabWidget(
                                            tabIndex: 4,
                                            tabName: 'Details',
                                            myTabState:
                                                AddDeliveryRequestTabState
                                                    .step4,
                                            currentTabState: controller
                                                .addDeliveryRequestTabState
                                                .value,
                                          ),
                                          onTap: () {
                                            controller
                                                    .addDeliveryRequestTabState
                                                    .value =
                                                AddDeliveryRequestTabState
                                                    .step4;
                                          },
                                        )),
                                      ]),
                                  AppGaps.hGap16,
                                  ...controller
                                      .currentOrderDetailsTabContentWidgets(
                                          controller.addDeliveryRequestTabState
                                              .value),
                                ],
                              ),
                            )),
                          ],
                        ),
                      )
                    ],
                  )),
                  bottomNavigationBar: CustomScaffoldBodyWidget(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(
                          () => Container(
                              margin: const EdgeInsets.all(10),
                              child: controller
                                  .currentAddDeliveryRequestTabBottomButtonWidget(
                                      controller
                                          .addDeliveryRequestTabState.value)),
                        ),
                      ],
                    ),
                  )),
            ));
  }
}
