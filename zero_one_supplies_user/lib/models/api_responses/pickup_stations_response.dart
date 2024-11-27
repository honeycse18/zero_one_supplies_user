import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class PickupStationsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<PickupStation> data;

  PickupStationsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory PickupStationsResponse.fromJson(Map<String, dynamic> json) {
    return PickupStationsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            PickupStation.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((data) => data.toJson()),
      };

  factory PickupStationsResponse.empty() =>
      PickupStationsResponse(data: PaginatedDataResponse.empty());

  static PickupStationsResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupStationsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickupStationsResponse.empty();
}

class PickupStation {
  String id;
  String name;
  String address;
  PickupStationLocation location;
  double charge;
  int estimatedDay;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;

  PickupStation({
    this.id = '',
    this.name = '',
    this.address = '',
    required this.location,
    this.charge = 0,
    this.estimatedDay = 0,
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PickupStation.fromJson(Map<String, dynamic> json) => PickupStation(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: PickupStationLocation.getAPIResponseObjectSafeValue(
            json['location']),
        charge: APIHelper.getSafeDoubleValue(json['charge'], 0),
        estimatedDay: APIHelper.getSafeIntValue(json['estimated_day'], 0),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'location': location.toJson(),
        'charge': charge,
        'estimated_day': estimatedDay,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory PickupStation.empty() => PickupStation(
      location: PickupStationLocation(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static PickupStation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupStation.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PickupStation.empty();
}

class PickupStationLocation {
  double latitude;
  double longitude;

  PickupStationLocation({this.latitude = 0, this.longitude = 0});

  factory PickupStationLocation.fromJson(Map<String, dynamic> json) =>
      PickupStationLocation(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static PickupStationLocation getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupStationLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PickupStationLocation();
}
