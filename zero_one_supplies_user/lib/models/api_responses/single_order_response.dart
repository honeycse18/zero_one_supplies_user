import 'package:ecomik/models/api_responses/my_order_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SingleOrderResponse {
  bool error;
  String msg;
  SingleOrderItemData data;

  SingleOrderResponse({this.error = false, this.msg = '', required this.data});

  factory SingleOrderResponse.fromJson(Map<String, dynamic> json) {
    return SingleOrderResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: SingleOrderItemData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SingleOrderResponse.empty() => SingleOrderResponse(
        data: SingleOrderItemData.empty(),
      );
  static SingleOrderResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderResponse.empty();
}

class SingleOrderItemData {
  String id;
  String orderNumber;
  String date;
  SingleOrderUser user;
  List<SingleOrderedProduct> products;
  double netPrice;
  double subtotal;
  double discount;
  SingleOrderDiscountCoupon discountCoupon;
  double vat;
  SingleOrderVatApplied vatApplied;
  SingleOrderDelivery delivery;
  double total;
  dynamic address;
  String paymentStatus;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  SingleOrderPickupStation pickupStation;
  SingleOrderCusAddressShortItem cusAddress;
  DateTime estimatedDeliveryDay;
  String receivedTime;

  SingleOrderItemData({
    this.id = '',
    this.orderNumber = '',
    this.date = '',
    required this.user,
    this.products = const [],
    this.netPrice = 0,
    this.subtotal = 0,
    this.discount = 0,
    required this.discountCoupon,
    this.vat = 0,
    required this.vatApplied,
    required this.delivery,
    this.total = 0,
    this.address = '',
    this.paymentStatus = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    required this.pickupStation,
    required this.cusAddress,
    required this.estimatedDeliveryDay,
    this.receivedTime = '',
  });

  factory SingleOrderItemData.fromJson(Map<String, dynamic> json) =>
      SingleOrderItemData(
        id: APIHelper.getSafeStringValue(json['_id']),
        orderNumber: APIHelper.getSafeStringValue(json['order_number']),
        date: APIHelper.getSafeStringValue(json['date']),
        user: SingleOrderUser.getAPIResponseObjectSafeValue(json['user']),
        products: APIHelper.getSafeListValue(json['products'])
            .map((e) => SingleOrderedProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        netPrice: APIHelper.getSafeDoubleValue(json['net_price']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        discount: APIHelper.getSafeDoubleValue(json['discount']),
        discountCoupon: SingleOrderDiscountCoupon.getAPIResponseObjectSafeValue(
            json['discount_coupon']),
        vat: APIHelper.getSafeDoubleValue(json['vat']),
        vatApplied: SingleOrderVatApplied.getAPIResponseObjectSafeValue(
            json['vat_applied']),
        delivery:
            SingleOrderDelivery.getAPIResponseObjectSafeValue(json['delivery']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        address: APIHelper.getSafeStringValue(json['address']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        pickupStation: SingleOrderPickupStation.getAPIResponseObjectSafeValue(
            json['pickup_station']),
        cusAddress:
            SingleOrderCusAddressShortItem.getAPIResponseObjectSafeValue(
                json['cus_address']),
        estimatedDeliveryDay:
            APIHelper.getSafeDateTimeValue(json['estimated_delivery_day']),
        receivedTime: APIHelper.getSafeStringValue(json['received_time']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'order_number': orderNumber,
        'date': date,
        'user': user.toJson(),
        'products': products.map((e) => e.toJson()).toList(),
        'net_price': netPrice,
        'subtotal': subtotal,
        'discount': discount,
        'discount_coupon': discountCoupon.toJson(),
        'vat': vat,
        'vat_applied': vatApplied.toJson(),
        'delivery': delivery.toJson(),
        'total': total,
        'address': address,
        'payment_status': paymentStatus,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'pickup_station': pickupStation.toJson(),
        'cus_address': cusAddress.toJson(),
        'estimated_delivery_day':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(
                estimatedDeliveryDay),
        'received_time': receivedTime,
      };

  factory SingleOrderItemData.empty() => SingleOrderItemData(
        createdAt: AppComponents.defaultUnsetDateTime,
        cusAddress: SingleOrderCusAddressShortItem.empty(),
        delivery: SingleOrderDelivery(),
        discountCoupon: SingleOrderDiscountCoupon(),
        estimatedDeliveryDay: AppComponents.defaultUnsetDateTime,
        pickupStation: SingleOrderPickupStation.empty(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        user: SingleOrderUser(),
        vatApplied: SingleOrderVatApplied(),
      );

  static SingleOrderItemData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderItemData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderItemData.empty();
}

//=============================================

class SingleOrderCusAddressShortItem {
  String deliveryType;
  MyOrderCustomAddressBook addressBook;
  MyOrderCusAddressPosition position;

  SingleOrderCusAddressShortItem(
      {this.deliveryType = '',
      required this.addressBook,
      required this.position});

  factory SingleOrderCusAddressShortItem.fromJson(Map<String, dynamic> json) =>
      SingleOrderCusAddressShortItem(
        deliveryType: APIHelper.getSafeStringValue(json['delivery_type']),
        addressBook: MyOrderCustomAddressBook.getAPIResponseObjectSafeValue(
            json['address_book']),
        position: MyOrderCusAddressPosition.getAPIResponseObjectSafeValue(
            json['position']),
      );

  Map<String, dynamic> toJson() => {
        'delivery_type': deliveryType,
        'address_book': addressBook.toJson(),
        'position': position.toJson(),
      };
  factory SingleOrderCusAddressShortItem.empty() =>
      SingleOrderCusAddressShortItem(
        addressBook: MyOrderCustomAddressBook.empty(),
        position: MyOrderCusAddressPosition(),
      );

  static SingleOrderCusAddressShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderCusAddressShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderCusAddressShortItem.empty();
}

class SingleOrderCustomAddressBook {
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
  String country;
  bool isPrimary;
  DateTime createdAt;
  DateTime updatedAt;
  Location location;
  MyOrderCusAddressPosition position;

  SingleOrderCustomAddressBook({
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
    this.country = '',
    this.isPrimary = false,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    required this.position,
  });

  factory SingleOrderCustomAddressBook.fromJson(Map<String, dynamic> json) =>
      SingleOrderCustomAddressBook(
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
        country: APIHelper.getSafeStringValue(json['country']),
        isPrimary: APIHelper.getSafeBoolValue(json['is_primary']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        position: MyOrderCusAddressPosition.getAPIResponseObjectSafeValue(
            json['position']),
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
        'country': country,
        'is_primary': isPrimary,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'location': location.toJson(),
        'position': position.toJson(),
      };

  factory SingleOrderCustomAddressBook.empty() => SingleOrderCustomAddressBook(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        position: MyOrderCusAddressPosition(),
        location: Location(),
      );

  static SingleOrderCustomAddressBook getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderCustomAddressBook.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderCustomAddressBook.empty();
}

//=============VatApplied====================

class SingleOrderVatApplied {
  String type;
  double value;

  SingleOrderVatApplied({this.type = '', this.value = 0});

  factory SingleOrderVatApplied.fromJson(Map<String, dynamic> json) =>
      SingleOrderVatApplied(
        type: APIHelper.getSafeStringValue(json['type']),
        value: APIHelper.getSafeDoubleValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };

  static SingleOrderVatApplied getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderVatApplied.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderVatApplied();
}

class Location {
  String type;
  List<double> coordinates;

  Location({this.type = '', this.coordinates = const []});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: APIHelper.getSafeStringValue(json['type']),
        coordinates: APIHelper.getSafeListValue(json['coordinates']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };

  static Location getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Location.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Location();
}

class SingleOrderCusAddressPosition {
  double latitude;
  double longitude;

  SingleOrderCusAddressPosition({this.latitude = 0, this.longitude = 0});

  factory SingleOrderCusAddressPosition.fromJson(Map<String, dynamic> json) =>
      SingleOrderCusAddressPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static SingleOrderCusAddressPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderCusAddressPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderCusAddressPosition();
}
//====delivery======

class SingleOrderDelivery {
  double fare;
  double distance;
  double perKmFare;

  SingleOrderDelivery({this.fare = 0, this.distance = 0, this.perKmFare = 0});

  factory SingleOrderDelivery.fromJson(Map<String, dynamic> json) =>
      SingleOrderDelivery(
        fare: APIHelper.getSafeDoubleValue(json['fare']),
        distance: APIHelper.getSafeDoubleValue(json['distance']),
        perKmFare: APIHelper.getSafeDoubleValue(json['per_km_fare']),
      );

  Map<String, dynamic> toJson() => {
        'fare': fare,
        'per_km_fare': perKmFare,
        'distance': distance,
      };
  static SingleOrderDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderDelivery.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderDelivery();
}

//============PickupLocation====================

class SingleOrderPickupStationLocation {
  double latitude;
  double longitude;

  SingleOrderPickupStationLocation({this.latitude = 0, this.longitude = 0});

  factory SingleOrderPickupStationLocation.fromJson(Map<String, dynamic> json) {
    return SingleOrderPickupStationLocation(
      latitude: APIHelper.getSafeDoubleValue(json['latitude']),
      longitude: APIHelper.getSafeDoubleValue(json['longitude']),
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static SingleOrderPickupStationLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderPickupStationLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderPickupStationLocation();
}

//=========PickUpStation==========================
class SingleOrderPickupStation {
  String id;
  String name;
  String address;
  double charged;
  SingleOrderPickupStationLocation pickupLocation;

  SingleOrderPickupStation({
    this.id = '',
    this.name = '',
    this.address = '',
    this.charged = 0,
    required this.pickupLocation,
  });

  factory SingleOrderPickupStation.fromJson(Map<String, dynamic> json) =>
      SingleOrderPickupStation(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        charged: APIHelper.getSafeDoubleValue(json['charged']),
        pickupLocation:
            SingleOrderPickupStationLocation.getAPIResponseObjectSafeValue(
                json['pickup_location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'charged': charged,
        'pickup_location': pickupLocation.toJson(),
      };

  factory SingleOrderPickupStation.empty() => SingleOrderPickupStation(
        pickupLocation: SingleOrderPickupStationLocation(),
      );

  static SingleOrderPickupStation getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderPickupStation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderPickupStation.empty();
}

//================DiscountCoupon===========
class SingleOrderDiscountCoupon {
  String code;
  double value;
  String discountType;

  SingleOrderDiscountCoupon(
      {this.code = '', this.value = 0, this.discountType = ''});

  factory SingleOrderDiscountCoupon.fromJson(Map<String, dynamic> json) {
    return SingleOrderDiscountCoupon(
      code: APIHelper.getSafeStringValue(json['code']),
      value: APIHelper.getSafeDoubleValue(json['value']),
      discountType: APIHelper.getSafeStringValue(json['discount_type']),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'value': value,
        'discount_type': discountType,
      };

  static SingleOrderDiscountCoupon getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderDiscountCoupon.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderDiscountCoupon();
}

class SingleOrderUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String image;

  SingleOrderUser({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.image = '',
  });

  factory SingleOrderUser.fromJson(Map<String, dynamic> json) =>
      SingleOrderUser(
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
  static SingleOrderUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderUser();
}
//=========Product======

class SingleOrderedProduct {
  String product;
  String name;
  String image;
  String unit;
  double price;
  int quantity;
  double subtotal;
  String id;

  SingleOrderedProduct({
    this.product = '',
    this.name = '',
    this.image = '',
    this.unit = '',
    this.price = 0,
    this.quantity = 0,
    this.subtotal = 0,
    this.id = '',
  });

  factory SingleOrderedProduct.fromJson(Map<String, dynamic> json) =>
      SingleOrderedProduct(
        product: APIHelper.getSafeStringValue(json['product']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'product': product,
        'name': name,
        'image': image,
        'unit': unit,
        'price': price,
        'quantity': quantity,
        'subtotal': subtotal,
        '_id': id,
      };

  static SingleOrderedProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleOrderedProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleOrderedProduct();
}
