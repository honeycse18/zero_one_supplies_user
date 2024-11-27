import 'package:ecomik/models/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DeliverySetLocationScreenController extends GetxController {
  final PanelController panelController = PanelController();

  /// Toggle value of show bottom bar
  RxBool showBottomBar = true.obs;

  /// Show bottom slider panel
  Future<void> openBottomPanel() async {
    // setState(() {
    showBottomBar = false.obs;
    // });
    await panelController.show();
    await panelController.open();
    // setState(() {});
  }

  /// Current edit location save as
  DeliveryLocationSetAs currentDeliveryLocationSetAs =
      DeliveryLocationSetAs.none;

  @override
  void onInit() {
    showBottomBar = true.obs;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (panelController.isAttached && panelController.isPanelShown) {
        await panelController.hide();
        // setState(() {
        showBottomBar = true.obs;
        // });
      }

      if (panelController.isAttached) {
        panelController.isPanelShown
            ? showBottomBar = false.obs
            : showBottomBar = true.obs;
      }
    });
    super.onInit();
  }
}
