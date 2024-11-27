import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class DeliveryRequestsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<DeliveryRequestItem> data;

  DeliveryRequestsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory DeliveryRequestsResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryRequestsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            DeliveryRequestItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((data) => data.toJson()),
      };

  factory DeliveryRequestsResponse.empty() => DeliveryRequestsResponse(
        data: PaginatedDataResponse.empty(),
      );
  static DeliveryRequestsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryRequestsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryRequestsResponse.empty();
}

class DeliveryRequestItem {
  String id;
  String sender;
  Receiver receiver;
  List<String> productImages;
  String status;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String deliveryNumber;
  double packageWeight;
  double distanceInKm;
  double total;
  String pickupPoint;
  String destinationPickupPoint;
  String payment;
  String paymentType;

  DeliveryRequestItem({
    this.id = '',
    this.sender = '',
    required this.receiver,
    this.productImages = const [],
    this.status = '',
    this.paymentStatus = '',
    required this.createdAt,
    required this.updatedAt,
    this.deliveryNumber = '',
    this.packageWeight = 0,
    this.distanceInKm = 0,
    this.total = 0,
    this.pickupPoint = '',
    this.payment = '',
    this.paymentType = '',
    this.destinationPickupPoint = '',
  });

  factory DeliveryRequestItem.fromJson(Map<String, dynamic> json) =>
      DeliveryRequestItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        sender: APIHelper.getSafeStringValue(json['sender']),
        receiver: Receiver.getAPIResponseObjectSafeValue(json['receiver']),
        productImages: APIHelper.getSafeListValue(json['product_images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        status: APIHelper.getSafeStringValue(json['status']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        deliveryNumber: APIHelper.getSafeStringValue(json['delivery_number']),
        packageWeight: APIHelper.getSafeDoubleValue(json['packageWeight']),
        distanceInKm: APIHelper.getSafeDoubleValue(json['distanceInKM']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        pickupPoint: APIHelper.getSafeStringValue(json['pickup_point']),
        destinationPickupPoint:
            APIHelper.getSafeStringValue(json['destination_pickup_point']),
        payment: APIHelper.getSafeStringValue(json['payment']),
        paymentType: APIHelper.getSafeStringValue(json['payment_type']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'sender': sender,
        'receiver': receiver.toJson(),
        'product_images': productImages,
        'status': status,
        'payment_status': paymentStatus,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'delivery_number': deliveryNumber,
        'packageWeight': packageWeight,
        'distanceInKM': distanceInKm,
        'total': total,
        'pickup_point': pickupPoint,
        'destination_pickup_point': destinationPickupPoint,
        'payment': payment,
        'payment_type': paymentType,
      };

  factory DeliveryRequestItem.empty() => DeliveryRequestItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        receiver: Receiver(),
      );
  static DeliveryRequestItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryRequestItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryRequestItem.empty();
}

class Receiver {
  String name;
  String phone;
  String email;
  String suitableDeliveryTime;

  Receiver({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.suitableDeliveryTime = '',
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        suitableDeliveryTime:
            APIHelper.getSafeStringValue(json['suitable_delivery_time']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'suitable_delivery_time': suitableDeliveryTime,
      };

  static Receiver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Receiver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Receiver();
}
