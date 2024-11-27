import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SavedAddressResponse {
  bool error;
  String msg;
  List<SavedAddress> data;

  SavedAddressResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory SavedAddressResponse.fromJson(Map<String, dynamic> json) {
    return SavedAddressResponse(
      error: (json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => SavedAddress.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };
  static SavedAddressResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddressResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedAddressResponse();
}

//=====Address short========
class SavedAddress {
  String id;
  String user;
  String name;
  String phone;
  String province;
  String city;
  String area;
  String address;
  String landmark;
  String delivery;
  bool defaultShippingAddress;
  bool defaultBillingAddress;
  DateTime createdAt;
  DateTime updatedAt;
  bool isPrimary;
  String country;
  SavedAddressLocation location;
  SavedAddressPosition position;
  String zipCode;

  SavedAddress({
    this.id = '',
    this.user = '',
    this.name = '',
    this.phone = '',
    this.province = '',
    this.city = '',
    this.area = '',
    this.address = '',
    this.landmark = '',
    this.delivery = '',
    this.defaultShippingAddress = false,
    this.defaultBillingAddress = false,
    required this.createdAt,
    required this.updatedAt,
    this.isPrimary = false,
    this.country = '',
    required this.location,
    required this.position,
    this.zipCode = '',
  });

  factory SavedAddress.fromJson(Map<String, dynamic> json) => SavedAddress(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        province: APIHelper.getSafeStringValue(json['province']),
        city: APIHelper.getSafeStringValue(json['city']),
        area: APIHelper.getSafeStringValue(json['area']),
        address: APIHelper.getSafeStringValue(json['address']),
        landmark: APIHelper.getSafeStringValue(json['landmark']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        defaultShippingAddress:
            APIHelper.getSafeBoolValue(json['default_shipping_address']),
        defaultBillingAddress:
            APIHelper.getSafeBoolValue(json['default_billing_address']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        isPrimary: APIHelper.getSafeBoolValue(json['is_primary']),
        country: APIHelper.getSafeStringValue(json['country']),
        location: SavedAddressLocation.getAPIResponseObjectSafeValue(
            json['location']),
        position: SavedAddressPosition.getAPIResponseObjectSafeValue(
            json['position']),
        zipCode: APIHelper.getSafeStringValue(json['zip_code']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'name': name,
        'phone': phone,
        'province': province,
        'city': city,
        'area': area,
        'address': address,
        'landmark': landmark,
        'delivery': delivery,
        'default_shipping_address': defaultShippingAddress,
        'default_billing_address': defaultBillingAddress,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'is_primary': isPrimary,
        'country': country,
        'location': location.toJson(),
        'position': position.toJson(),
        'zip_code': zipCode,
      };
  factory SavedAddress.empty() => SavedAddress(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        location: SavedAddressLocation(),
        position: SavedAddressPosition(),
      );
  static SavedAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddress.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SavedAddress.empty();

  String addressText() {
    return '$address, $area, $province, $city, $zipCode, $country';
  }
}

//=====Location=======
class SavedAddressLocation {
  String type;
  List<double> coordinates;

  SavedAddressLocation({this.type = '', this.coordinates = const []});

  factory SavedAddressLocation.fromJson(Map<String, dynamic> json) =>
      SavedAddressLocation(
        type: APIHelper.getSafeStringValue(json['type']),
        coordinates: APIHelper.getSafeListValue(json['coordinates']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  static SavedAddressLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddressLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedAddressLocation();
}

//========position===========
class SavedAddressPosition {
  double latitude;
  double longitude;

  SavedAddressPosition({this.latitude = 0, this.longitude = 0});

  factory SavedAddressPosition.fromJson(Map<String, dynamic> json) =>
      SavedAddressPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
  static SavedAddressPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SavedAddressPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SavedAddressPosition();
}
