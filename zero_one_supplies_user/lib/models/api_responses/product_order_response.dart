import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ProductOrderResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ProductOrderItem> data;

  ProductOrderResponse({this.error = false, this.msg = '', required this.data});

  factory ProductOrderResponse.fromJson(Map<String, dynamic> json) {
    return ProductOrderResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            ProductOrderItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ProductOrderResponse.empty() =>
      ProductOrderResponse(data: PaginatedDataResponse.empty());
  static ProductOrderResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductOrderResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductOrderResponse.empty();
}

class ProductOrderItem {
  String id;
  String user;
  int totalProducts;
  double netAmount;
  String companyCommission;
  double chargedAmount;
  double totalSaveMoney;
  double total;
  String productReceiveTime;
  int estimatedDeliveryHours;
  Delivery delivery;
  String paymentStatus;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int ref;
  int v;
  String payment;
  String paymentMethod;
  String orderNumber;

  ProductOrderItem({
    this.id = '',
    this.user = '',
    this.totalProducts = 0,
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
    required this.createdAt,
    required this.updatedAt,
    this.ref = 0,
    this.v = 0,
    this.payment = '',
    this.paymentMethod = '',
    this.orderNumber = '',
  });

  factory ProductOrderItem.fromJson(Map<String, dynamic> json) =>
      ProductOrderItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        totalProducts: APIHelper.getSafeIntValue(json['totalProducts']),
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
        delivery: Delivery.getAPIResponseObjectSafeValue(json['delivery']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        ref: APIHelper.getSafeIntValue(json['ref']),
        v: APIHelper.getSafeIntValue(json['__v']),
        payment: APIHelper.getSafeStringValue(json['payment']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        orderNumber: APIHelper.getSafeStringValue(json['order_number']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'totalProducts': totalProducts,
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
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'ref': ref,
        '__v': v,
        'payment': payment,
        'payment_method': paymentMethod,
        'order_number': orderNumber,
      };

  factory ProductOrderItem.empty() => ProductOrderItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        delivery: Delivery.empty(),
      );
  static ProductOrderItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductOrderItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductOrderItem.empty();
}

class Delivery {
  String type;
  Address address;
  String id;

  Delivery({this.type = '', required this.address, this.id = ''});

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        type: APIHelper.getSafeStringValue(json['type']),
        address: Address.getAPIResponseObjectSafeValue(json['address']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'address': address.toJson(),
        '_id': id,
      };

  factory Delivery.empty() => Delivery(address: Address.empty());
  static Delivery getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Delivery.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Delivery.empty();
}

class Address {
  String id;
  String address;
  String delivery;
  Position position;
  double totalCost;
  double totalDistanceInKm;

  Address({
    this.id = '',
    this.address = '',
    this.delivery = '',
    required this.position,
    this.totalCost = 0,
    this.totalDistanceInKm = 0,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: APIHelper.getSafeStringValue(json['_id']),
        address: APIHelper.getSafeStringValue(json['address']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        position: Position.getAPIResponseObjectSafeValue(json['position']),
        totalCost: APIHelper.getSafeDoubleValue(json['totalCost']),
        totalDistanceInKm:
            APIHelper.getSafeDoubleValue(json['totalDistanceInKm']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'address': address,
        'delivery': delivery,
        'position': position.toJson(),
        'totalCost': totalCost,
        'totalDistanceInKm': totalDistanceInKm,
      };

  factory Address.empty() => Address(
        position: Position(),
      );
  static Address getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Address.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Address.empty();
}

class Position {
  double latitude;
  double longitude;

  Position({this.latitude = 0, this.longitude = 0});

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static Position getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Position.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Position();
}
