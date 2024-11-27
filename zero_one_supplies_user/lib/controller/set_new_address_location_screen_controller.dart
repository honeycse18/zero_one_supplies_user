import 'dart:async';

import 'package:collection/collection.dart';
import 'package:ecomik/models/api_responses/saved_address_response.dart';
import 'package:ecomik/models/screen_parameters/add_address_screen_parameter.dart';
import 'package:ecomik/models/screen_parameters/set_new_address_location_screen_parameter.dart';
import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SetNewAddressLocationScreenController extends GetxController {
  final PanelController panelController = PanelController();
  final Set<Marker> googleMapMarkers = {};
  final TextEditingController locationAddressController =
      TextEditingController();
  Placemark? selectedAddress;
  bool isLocationSelected = false;
  SavedAddress? savedAddress;

  final Completer<GoogleMapController> googleMapControllerCompleter =
      Completer<GoogleMapController>();

  GoogleMapController? googleMapController;

  void onLocationButtonTap() async {
    final Position? location = await Helper.getGPSLocationData();
    if (location == null) {
      return;
    }
    onGoogleMapTap(LatLng(location.latitude, location.longitude));
  }

  void onConfirmTap() async {
    final Marker? mapMarker = googleMapMarkers.firstOrNull;
    if (mapMarker == null) {
      AppDialogs.showErrorDialog(
          messageText: AppLanguageTranslation
              .youMustSelectCoordinateTransKey.toCurrentLanguage);
      return;
    }
    final result = await Get.toNamed(AppPageNames.addAddressScreen,
        arguments: AddAddressScreenParameter(
            address: selectedAddress,
            latLng: mapMarker.position,
            savedAddress: savedAddress));
    if (result is bool && result) {
      Get.back();
    }
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    googleMapControllerCompleter.complete(controller);
    if (savedAddress != null) {
      onGoogleMapTap(LatLng(
          savedAddress!.position.latitude, savedAddress!.position.longitude));
    }
  }

  void _addMarker(LatLng latLng) {
    googleMapMarkers.clear();
    googleMapMarkers
        .add(Marker(markerId: MarkerId(latLng.toString()), position: latLng));
  }

  void resetAddressSelection() {
    isLocationSelected = false;
    locationAddressController.text = '';
    selectedAddress = null;
    googleMapMarkers.clear();
    update();
  }

  void _setAddress(LatLng latLng) async {
    selectedAddress =
        await Helper.getAddressDetails(latLng.latitude, latLng.longitude);
    if (selectedAddress == null) {
      return;
    }
    isLocationSelected = true;
    locationAddressController.text =
        Helper.getAddressDetailsText(selectedAddress!);
    update();
  }

  void onGoogleMapTap(LatLng latLng) async {
    if (googleMapController == null) {
      return;
    }
    _addMarker(latLng);
    final double zoomLevel = await googleMapController!.getZoomLevel();
    googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: zoomLevel)));
    AppSingleton.instance.defaultCameraPosition =
        CameraPosition(target: latLng, zoom: zoomLevel);
    _setAddress(latLng);
    update();
    panelController.open();
  }

  String get screenTitle {
    if (savedAddress == null) {
      return AppLanguageTranslation.setLocationTransKey.toCurrentLanguage;
    }
    return AppLanguageTranslation.editLocationTransKey.toCurrentLanguage;
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is SetNewAddressLocationScreenParameter) {
      savedAddress = argument.savedAddress;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }

  @override
  void onClose() {
    googleMapController?.dispose();
    locationAddressController.dispose();
    super.onClose();
  }
}
