import 'package:ecomik/models/api_responses/saved_address_response.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreenParameter {
  final SavedAddress? savedAddress;
  final Placemark? address;
  final LatLng latLng;
  AddAddressScreenParameter({
    this.savedAddress,
    this.address,
    this.latLng = const LatLng(0, 0),
  });
}
