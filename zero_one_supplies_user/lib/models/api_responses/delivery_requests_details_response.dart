
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class DeliveryRequestsDetailsResponse {
  bool error;
  String msg;
  DeliveryRequestDetails data;

  DeliveryRequestsDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory DeliveryRequestsDetailsResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryRequestsDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: DeliveryRequestDetails.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory DeliveryRequestsDetailsResponse.empty() =>
      DeliveryRequestsDetailsResponse(
        data: DeliveryRequestDetails.empty(),
      );
  static DeliveryRequestsDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryRequestsDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryRequestsDetailsResponse.empty();
}

class DeliveryRequestDetails {
  String id;
  Sender sender;
  Receiver receiver;
  String description;
  Dimensions dimensions;
  int weight;
  PickupAddress pickupAddress;
  DestinationAddress destinationAddress;
  List<String> productImages;
  String status;
  DeliveryCharge deliveryCharge;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String deliveryNumber;

  DeliveryRequestDetails({
    this.id = '',
    required this.sender,
    required this.receiver,
    this.description = '',
    required this.dimensions,
    this.weight = 0,
    required this.pickupAddress,
    this.productImages = const [],
    this.status = '',
    required this.deliveryCharge,
    this.paymentStatus = '',
    required this.createdAt,
    required this.updatedAt,
    this.deliveryNumber = '',
    required this.destinationAddress,
  });

  factory DeliveryRequestDetails.fromJson(Map<String, dynamic> json) =>
      DeliveryRequestDetails(
        id: APIHelper.getSafeStringValue(json['_id']),
        sender: Sender.getAPIResponseObjectSafeValue(json['sender']),
        receiver: Receiver.getAPIResponseObjectSafeValue(json['receiver']),
        description: APIHelper.getSafeStringValue(json['description']),
        dimensions:
            Dimensions.getAPIResponseObjectSafeValue(json['dimensions']),
        weight: APIHelper.getSafeIntValue(json['weight']),
        pickupAddress:
            PickupAddress.getAPIResponseObjectSafeValue(json['pickup_address']),
        destinationAddress: DestinationAddress.getAPIResponseObjectSafeValue(
            json['destination_address']),
        productImages: APIHelper.getSafeListValue(json['product_images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        status: APIHelper.getSafeStringValue(json['status']),
        deliveryCharge: DeliveryCharge.getAPIResponseObjectSafeValue(
            json['deliveryCharge']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        deliveryNumber: APIHelper.getSafeStringValue(json['delivery_number']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'sender': sender.toJson(),
        'receiver': receiver.toJson(),
        'description': description,
        'dimensions': dimensions.toJson(),
        'weight': weight,
        'pickup_address': pickupAddress.toJson(),
        'destination_address': destinationAddress.toJson(),
        'product_images': productImages,
        'status': status,
        'deliveryCharge': deliveryCharge.toJson(),
        'payment_status': paymentStatus,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'delivery_number': deliveryNumber,
      };

  factory DeliveryRequestDetails.empty() => DeliveryRequestDetails(
        createdAt: AppComponents.defaultUnsetDateTime,
        deliveryCharge: DeliveryCharge.empty(),
        destinationAddress: DestinationAddress.empty(),
        dimensions: Dimensions(),
        pickupAddress: PickupAddress.empty(),
        receiver: Receiver(),
        sender: Sender(),
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static DeliveryRequestDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryRequestDetails.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryRequestDetails.empty();
}

class DeliveryCharge {
  double totalCharge;
  ChargeInfo chargeInfo;
  Measurements measurements;
  String id;

  DeliveryCharge({
    this.totalCharge = 0,
    required this.chargeInfo,
    required this.measurements,
    this.id = '',
  });

  factory DeliveryCharge.fromJson(Map<String, dynamic> json) {
    return DeliveryCharge(
      totalCharge: APIHelper.getSafeDoubleValue(json['totalCharge']),
      chargeInfo: ChargeInfo.getAPIResponseObjectSafeValue(json['chargeInfo']),
      measurements:
          Measurements.getAPIResponseObjectSafeValue(json['measurements']),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalCharge': totalCharge,
        'chargeInfo': chargeInfo.toJson(),
        'measurements': measurements.toJson(),
        '_id': id,
      };

  factory DeliveryCharge.empty() => DeliveryCharge(
      chargeInfo: ChargeInfo.empty(), measurements: Measurements());
  static DeliveryCharge getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryCharge.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DeliveryCharge.empty();
}

class ChargeInfo {
  ShippingCharge shippingCharge;
  PackageCharge packageCharge;

  ChargeInfo({required this.shippingCharge, required this.packageCharge});

  factory ChargeInfo.fromJson(Map<String, dynamic> json) => ChargeInfo(
        shippingCharge: ShippingCharge.getAPIResponseObjectSafeValue(
            json['shippingCharge']),
        packageCharge:
            PackageCharge.getAPIResponseObjectSafeValue(json['packageCharge']),
      );

  Map<String, dynamic> toJson() => {
        'shippingCharge': shippingCharge.toJson(),
        'packageCharge': packageCharge.toJson(),
      };

  factory ChargeInfo.empty() => ChargeInfo(
        packageCharge: PackageCharge(),
        shippingCharge: ShippingCharge.empty(),
      );
  static ChargeInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChargeInfo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ChargeInfo.empty();
}

class DestinationAddress {
  String name;
  String address;
  DeliveryRequestPosition position;

  DestinationAddress(
      {this.name = '', this.address = '', required this.position});

  factory DestinationAddress.fromJson(Map<String, dynamic> json) {
    return DestinationAddress(
      name: APIHelper.getSafeStringValue(json['name']),
      address: APIHelper.getSafeStringValue(json['address']),
      position: DeliveryRequestPosition.getAPIResponseObjectSafeValue(
          json['position']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'position': position.toJson(),
      };

  factory DestinationAddress.empty() =>
      DestinationAddress(position: DeliveryRequestPosition());
  static DestinationAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DestinationAddress.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DestinationAddress.empty();
}

class Dimensions {
  int length;
  int width;
  int height;

  Dimensions({this.length = 0, this.width = 0, this.height = 0});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: APIHelper.getSafeIntValue(json['length']),
        width: APIHelper.getSafeIntValue(json['width']),
        height: APIHelper.getSafeIntValue(json['height']),
      );

  Map<String, dynamic> toJson() => {
        'length': length,
        'width': width,
        'height': height,
      };

  static Dimensions getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Dimensions.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Dimensions();
}

class Measurements {
  double cbmConversionFactor;
  double deliveryRequestPerKgChargeAmount;

  Measurements({
    this.cbmConversionFactor = 0,
    this.deliveryRequestPerKgChargeAmount = 0,
  });

  factory Measurements.fromJson(Map<String, dynamic> json) => Measurements(
        cbmConversionFactor:
            APIHelper.getSafeDoubleValue(json['cbm_conversion_factor']),
        deliveryRequestPerKgChargeAmount: APIHelper.getSafeDoubleValue(
            json['delivery_request_per_kg_charge_amount']),
      );

  Map<String, dynamic> toJson() => {
        'cbm_conversion_factor': cbmConversionFactor,
        'delivery_request_per_kg_charge_amount':
            deliveryRequestPerKgChargeAmount,
      };

  static Measurements getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Measurements.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Measurements();
}

class PackageCharge {
  double packageWeight;
  int packageWeightPerKg;
  double total;

  PackageCharge(
      {this.packageWeight = 0, this.packageWeightPerKg = 0, this.total = 0});

  factory PackageCharge.fromJson(Map<String, dynamic> json) => PackageCharge(
        packageWeight: APIHelper.getSafeDoubleValue(json['packageWeight']),
        packageWeightPerKg:
            APIHelper.getSafeIntValue(json['packageWeightPerKG']),
        total: APIHelper.getSafeDoubleValue(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'packageWeight': packageWeight,
        'packageWeightPerKG': packageWeightPerKg,
        'total': total,
      };

  static PackageCharge getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PackageCharge.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PackageCharge();
}

class PickupAddress {
  String name;
  String address;
  DeliveryRequestPosition position;

  PickupAddress({this.name = '', this.address = '', required this.position});

  factory PickupAddress.fromJson(Map<String, dynamic> json) => PickupAddress(
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        position: DeliveryRequestPosition.getAPIResponseObjectSafeValue(
            json['position']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'position': position.toJson(),
      };

  factory PickupAddress.empty() =>
      PickupAddress(position: DeliveryRequestPosition());
  static PickupAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PickupAddress.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : PickupAddress.empty();
}

class DeliveryRequestPosition {
  double latitude;
  double longitude;

  DeliveryRequestPosition({this.latitude = 0, this.longitude = 0});

  factory DeliveryRequestPosition.fromJson(Map<String, dynamic> json) =>
      DeliveryRequestPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static DeliveryRequestPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryRequestPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryRequestPosition();
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

class Sender {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String image;

  Sender({
    this.id = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.image = '',
    this.firstName = '',
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'image': image,
      };

  static Sender getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Sender.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Sender();
}

class RestKmCharges {
  int from;
  int to;
  double fare;

  RestKmCharges({this.from = 0, this.to = 0, this.fare = 0});

  factory RestKmCharges.fromJson(Map<String, dynamic> json) => RestKmCharges(
        from: APIHelper.getSafeIntValue(json['from']),
        to: APIHelper.getSafeIntValue(json['to']),
        fare: APIHelper.getSafeDoubleValue(json['fare']),
      );

  Map<String, dynamic> toJson() => {
        'from': from,
        'to': to,
        'fare': fare,
      };

  static RestKmCharges getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RestKmCharges.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RestKmCharges();
}

class DeliveryCharges {
  double firstKmDistanceCharge;
  RestKmCharges restKmCharges;

  DeliveryCharges(
      {this.firstKmDistanceCharge = 0, required this.restKmCharges});

  factory DeliveryCharges.fromJson(Map<String, dynamic> json) {
    return DeliveryCharges(
      firstKmDistanceCharge:
          APIHelper.getSafeDoubleValue(json['firstKMDistanceCharge']),
      restKmCharges:
          RestKmCharges.getAPIResponseObjectSafeValue(json['restKMCharges']),
    );
  }

  Map<String, dynamic> toJson() => {
        'firstKMDistanceCharge': firstKmDistanceCharge,
        'restKMCharges': restKmCharges.toJson(),
      };

  factory DeliveryCharges.empty() =>
      DeliveryCharges(restKmCharges: RestKmCharges());
  static DeliveryCharges getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DeliveryCharges.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DeliveryCharges.empty();
}

class ShippingCharge {
  double totalDistanceInKm;
  DeliveryCharges deliveryCharges;
  double total;

  ShippingCharge({
    this.totalDistanceInKm = 0,
    required this.deliveryCharges,
    this.total = 0,
  });

  factory ShippingCharge.fromJson(Map<String, dynamic> json) {
    return ShippingCharge(
      totalDistanceInKm:
          APIHelper.getSafeDoubleValue(json['totalDistanceInKM']),
      deliveryCharges: DeliveryCharges.getAPIResponseObjectSafeValue(
          json['deliveryCharges']),
      total: APIHelper.getSafeDoubleValue(json['total']),
    );
  }

  Map<String, dynamic> toJson() => {
        'totalDistanceInKM': totalDistanceInKm,
        'deliveryCharges': deliveryCharges.toJson(),
        'total': total,
      };

  factory ShippingCharge.empty() => ShippingCharge(
        deliveryCharges: DeliveryCharges.empty(),
      );
  static ShippingCharge getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ShippingCharge.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ShippingCharge.empty();
}

