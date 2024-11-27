import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class OrderCreateResponse {
  bool error;
  String msg;
  List<OrderCreate> data;

  OrderCreateResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory OrderCreateResponse.fromJson(Map<String, dynamic> json) {
    return OrderCreateResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => OrderCreate.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };

  static OrderCreateResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderCreateResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderCreateResponse();
}

class OrderCreate {
  String user;
  int totalProducts;
  List<StoreWiseCart> orders;
  double netAmount;
  String companyCommission;
  double chargedAmount;
  double totalSaveMoney;
  double total;
  String productReceiveTime;
  int estimatedDeliveryHours;
  OrderCreateDelivery delivery;
  String paymentStatus;
  String status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int ref;

  OrderCreate({
    this.user = '',
    this.totalProducts = 0,
    this.orders = const [],
    this.netAmount = 0,
    this.companyCommission = '',
    this.chargedAmount = 0,
    this.totalSaveMoney = 0,
    this.total = 0,
    this.productReceiveTime = '',
    this.estimatedDeliveryHours = 0,
    required this.delivery,
    this.paymentStatus = '',
    this.status = '',
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
    this.ref = -1,
  });

  factory OrderCreate.fromJson(Map<String, dynamic> json) => OrderCreate(
        user: APIHelper.getSafeStringValue(json['user']),
        totalProducts: APIHelper.getSafeIntValue(json['totalProducts']),
        orders: APIHelper.getSafeListValue(json['orders'])
            .map((e) => StoreWiseCart.getAPIResponseObjectSafeValue(e))
            .toList(),
        netAmount: APIHelper.getSafeDoubleValue(json['netAmount']),
        companyCommission:
            APIHelper.getSafeStringValue(json['company_commission']),
        chargedAmount: APIHelper.getSafeDoubleValue(json['charged_amount']),
        totalSaveMoney: APIHelper.getSafeDoubleValue(json['total_save_money']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        productReceiveTime:
            APIHelper.getSafeStringValue(json['product_receive_time']),
        estimatedDeliveryHours:
            APIHelper.getSafeIntValue(json['estimated_delivery_hours']),
        delivery:
            OrderCreateDelivery.getAPIResponseObjectSafeValue(json['delivery']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        status: APIHelper.getSafeStringValue(json['status']),
        id: APIHelper.getSafeStringValue(json['_id']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        ref: APIHelper.getSafeIntValue(json['ref'], -1),
      );

  Map<String, dynamic> toJson() => {
        'user': user,
        'totalProducts': totalProducts,
        'orders': orders.map((e) => e.toJson()).toList(),
        'netAmount': netAmount,
        'company_commission': companyCommission,
        'charged_amount': chargedAmount,
        'total_save_money': totalSaveMoney,
        'total': total,
        'product_receive_time': productReceiveTime,
        'estimated_delivery_hours': estimatedDeliveryHours,
        'delivery': delivery.toJson(),
        'payment_status': paymentStatus,
        'status': status,
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'ref': ref,
      };

  factory OrderCreate.empty() => OrderCreate(
      delivery: OrderCreateDelivery.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);

  static OrderCreate getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderCreate.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : OrderCreate.empty();
}

class OrderCreateDelivery {
  String type;
  OrderCreateDeliveryAddress address;
  String id;

  OrderCreateDelivery({this.type = '', required this.address, this.id = ''});

  factory OrderCreateDelivery.fromJson(Map<String, dynamic> json) =>
      OrderCreateDelivery(
        type: APIHelper.getSafeStringValue(json['type']),
        address: OrderCreateDeliveryAddress.getAPIResponseObjectSafeValue(
            json['address']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'address': address.toJson(),
        '_id': id,
      };

  factory OrderCreateDelivery.empty() =>
      OrderCreateDelivery(address: OrderCreateDeliveryAddress.empty());

  static OrderCreateDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderCreateDelivery.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderCreateDelivery.empty();
}

class OrderCreateDeliveryAddress {
  String id;
  String name;
  String address;
  String delivery;
  OrderCreateDeliveryAddressPosition position;
  double totalCost;
  double totalDistanceInKm;

  OrderCreateDeliveryAddress({
    this.id = '',
    this.name = '',
    this.address = '',
    this.delivery = '',
    required this.position,
    this.totalCost = 0,
    this.totalDistanceInKm = 0,
  });

  factory OrderCreateDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      OrderCreateDeliveryAddress(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        position:
            OrderCreateDeliveryAddressPosition.getAPIResponseObjectSafeValue(
                json['position']),
        totalCost: APIHelper.getSafeDoubleValue(json['totalCost']),
        totalDistanceInKm:
            APIHelper.getSafeDoubleValue(json['totalDistanceInKm']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'delivery': delivery,
        'position': position.toJson(),
        'totalCost': totalCost,
        'totalDistanceInKm': totalDistanceInKm,
      };

  factory OrderCreateDeliveryAddress.empty() => OrderCreateDeliveryAddress(
      position: OrderCreateDeliveryAddressPosition());

  static OrderCreateDeliveryAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderCreateDeliveryAddress.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderCreateDeliveryAddress.empty();
}

class OrderCreateDeliveryAddressPosition {
  double latitude;
  double longitude;

  OrderCreateDeliveryAddressPosition(
      {this.latitude = Constants.unsetMapLatLng,
      this.longitude = Constants.unsetMapLatLng});

  factory OrderCreateDeliveryAddressPosition.fromJson(
          Map<String, dynamic> json) =>
      OrderCreateDeliveryAddressPosition(
        latitude: APIHelper.getSafeDoubleValue(
            json['latitude'], Constants.unsetMapLatLng),
        longitude: APIHelper.getSafeDoubleValue(
            json['longitude'], Constants.unsetMapLatLng),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
  static OrderCreateDeliveryAddressPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OrderCreateDeliveryAddressPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : OrderCreateDeliveryAddressPosition();
}
