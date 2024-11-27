import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SavedAddressesWithCostResponse {
  bool error;
  String msg;
  List<SavedAddressWithCost> data;

  SavedAddressesWithCostResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory SavedAddressesWithCostResponse.fromJson(Map<String, dynamic> json) {
    return SavedAddressesWithCostResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => SavedAddressWithCost.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  factory SavedAddressesWithCostResponse.empty() =>
      SavedAddressesWithCostResponse();

  static SavedAddressesWithCostResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddressesWithCostResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedAddressesWithCostResponse();
}

class SavedAddressWithCost {
  String id;
  String delivery;
  String address;
  SavedAddressWithCostPosition position;
  int estimatedDeliveryHours;
  double totalDistanceInKm;
  double totalCost;

  SavedAddressWithCost({
    this.id = '',
    this.delivery = '',
    this.address = '',
    required this.position,
    this.estimatedDeliveryHours = 0,
    this.totalDistanceInKm = 0,
    this.totalCost = 0,
  });

  factory SavedAddressWithCost.fromJson(Map<String, dynamic> json) {
    return SavedAddressWithCost(
      id: APIHelper.getSafeStringValue(json['_id']),
      delivery: APIHelper.getSafeStringValue(json['delivery']),
      address: APIHelper.getSafeStringValue(json['address']),
      position: SavedAddressWithCostPosition.getAPIResponseObjectSafeValue(
          json['position']),
      estimatedDeliveryHours:
          APIHelper.getSafeIntValue(json['estimated_delivery_hours']),
      totalDistanceInKm:
          APIHelper.getSafeDoubleValue(json['totalDistanceInKm']),
      totalCost: APIHelper.getSafeDoubleValue(json['totalCost']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'delivery': delivery,
        'address': address,
        'position': position.toJson(),
        'estimated_delivery_hours': estimatedDeliveryHours,
        'totalDistanceInKm': totalDistanceInKm == 0 ? null : totalDistanceInKm,
        'totalCost': totalCost,
      };

  factory SavedAddressWithCost.empty() =>
      SavedAddressWithCost(position: SavedAddressWithCostPosition());

  static SavedAddressWithCost getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddressWithCost.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedAddressWithCost.empty();
}

class SavedAddressWithCostPosition {
  double latitude;
  double longitude;

  SavedAddressWithCostPosition(
      {this.latitude = Constants.unsetMapLatLng,
      this.longitude = Constants.unsetMapLatLng});

  factory SavedAddressWithCostPosition.fromJson(Map<String, dynamic> json) =>
      SavedAddressWithCostPosition(
        latitude: APIHelper.getSafeDoubleValue(
            json['latitude'], Constants.unsetMapLatLng),
        longitude: APIHelper.getSafeDoubleValue(
            json['longitude'], Constants.unsetMapLatLng),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static SavedAddressWithCostPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddressWithCostPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedAddressWithCostPosition();
}
