import 'package:ecomik/models/api_responses/site_settings_response.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:get/get.dart';

class AllPickupScreenController extends GetxController {
  SiteSettingsPickupArea? selectedPickUpArea;
  List<SiteSettingsPickupArea> _pickupAreas =
      AppSingleton.instance.settings.pickupArea;

  List<SiteSettingsPickupArea> get pickupAreas {
    return _pickupAreas;
  }

  void onPickupAreaItemTap(SiteSettingsPickupArea pickupArea) {
    selectedPickUpArea = pickupArea;
    update();
  }

  void onPickupAreaRadioChanged(Object? value) {}

  void onConfirmButtonTap() {
    if (selectedPickUpArea != null) {
      Get.back(result: selectedPickUpArea);
    }
  }

  void onSearchChange(String? searchText) {
    if (searchText != null) {
      selectedPickUpArea = null;
      if (searchText.isEmpty) {
        _pickupAreas = AppSingleton.instance.settings.pickupArea;
        update();
        return;
      }
      _pickupAreas = _pickupAreas
          .where((element) =>
              element.location.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
