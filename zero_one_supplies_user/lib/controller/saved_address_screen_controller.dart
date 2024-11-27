import 'dart:developer';

import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/saved_address_response.dart';
import 'package:ecomik/models/screen_parameters/set_new_address_location_screen_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';

class SavedAddressScreenController extends GetxController {
  List<SavedAddress> savedAddresses = [];
  bool isFromShippingAddressScreen = false;
  SavedAddress? selectedSavedAddress;

  bool isSavedAddressSelected(SavedAddress savedAddress) =>
      selectedSavedAddress?.id == savedAddress.id;

  void onAddNewAddressTap() async {
    await Get.toNamed(AppPageNames.setNewAddressLocationScreen);
    getSavedAddresses();
  }

  void onConfirmTap() async {
    Get.back(result: selectedSavedAddress);
  }

  void onSavedAddressTap(SavedAddress address) {
    selectedSavedAddress = address;
    update();
  }

  void onAddressEditTap(SavedAddress address) async {
    await Get.toNamed(AppPageNames.setNewAddressLocationScreen,
        arguments: SetNewAddressLocationScreenParameter(savedAddress: address));
    selectedSavedAddress = null;
    getSavedAddresses();
  }

  void onAddressDeleteTap(SavedAddress address) {
    AppDialogs.showConfirmDialog(
      messageText: AppLanguageTranslation
          .areYouSureToDeleteThisTransKey.toCurrentLanguage,
      onYesTap: () async {
        removeSavedAddress(address.id);
      },
    );
  }

  void _onSuccessGetSavedAddresses(SavedAddressResponse response) {
    savedAddresses = response.data;
    update();
  }

  Future<void> removeSavedAddress(String addressID) async {
    RawAPIResponse? response = await APIRepo.removeSavedAddress(addressID);
    selectedSavedAddress = null;
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessRemoveSavedAddress(response);
  }

  void onSuccessRemoveSavedAddress(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
    getSavedAddresses();
  }

/*   String addressText(SavedAddress savedAddress) {
    return '${savedAddress.phone} \n${savedAddress.address}, ${savedAddress.area}, ${savedAddress.city}, ${savedAddress.country}, ${savedAddress.zipCode}';
  } */
  Future<void> getSavedAddresses() async {
    SavedAddressResponse? response = await APIRepo.getSavedAddress();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetSavedAddresses(response);
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is bool) {
      isFromShippingAddressScreen = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    getSavedAddresses();
    super.onInit();
  }
}
