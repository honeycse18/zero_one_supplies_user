import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class PickupStationsWithCostResponse {
  bool error;
  String msg;
  List<PickupStationsWithCost> data;

  PickupStationsWithCostResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory PickupStationsWithCostResponse.fromJson(Map<String, dynamic> json) {
    return PickupStationsWithCostResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => PickupStationsWithCost.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static PickupStationsWithCostResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupStationsWithCostResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickupStationsWithCostResponse();
}

class PickupStationsWithCost {
  String id;
  String name;
  String address;
  PickupStationsWithCostPosition position;
  int estimatedDeliveryHours;
  double totalDistanceInKm;
  double totalCost;

  PickupStationsWithCost({
    this.id = '',
    this.name = '',
    this.address = '',
    required this.position,
    this.estimatedDeliveryHours = 0,
    this.totalDistanceInKm = 0,
    this.totalCost = 0,
  });

  factory PickupStationsWithCost.fromJson(Map<String, dynamic> json) {
    return PickupStationsWithCost(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      address: APIHelper.getSafeStringValue(json['address']),
      position: PickupStationsWithCostPosition.getAPIResponseObjectSafeValue(
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
        'name': name,
        'address': address,
        'position': position.toJson(),
        'estimated_delivery_hours': estimatedDeliveryHours,
        'totalDistanceInKm': totalDistanceInKm == 0 ? null : totalDistanceInKm,
        'totalCost': totalCost,
      };

  factory PickupStationsWithCost.empty() =>
      PickupStationsWithCost(position: PickupStationsWithCostPosition());

  static PickupStationsWithCost getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupStationsWithCost.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickupStationsWithCost.empty();
}

class PickupStationsWithCostPosition {
  double latitude;
  double longitude;

  PickupStationsWithCostPosition(
      {this.latitude = Constants.unsetMapLatLng,
      this.longitude = Constants.unsetMapLatLng});

  factory PickupStationsWithCostPosition.fromJson(Map<String, dynamic> json) =>
      PickupStationsWithCostPosition(
        latitude: APIHelper.getSafeDoubleValue(
            json['latitude'], Constants.unsetMapLatLng),
        longitude: APIHelper.getSafeDoubleValue(
            json['longitude'], Constants.unsetMapLatLng),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static PickupStationsWithCostPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupStationsWithCostPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickupStationsWithCostPosition();
}
