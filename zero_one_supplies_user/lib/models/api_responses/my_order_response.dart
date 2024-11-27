import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class MyOrderResponse {
  bool error;
  String msg;
  PaginatedDataResponse<MyOrderShortItem> data;

  MyOrderResponse({this.error = false, this.msg = '', required this.data});

  factory MyOrderResponse.fromJson(Map<String, dynamic> json) {
    return MyOrderResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            MyOrderShortItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory MyOrderResponse.empty() =>
      MyOrderResponse(data: PaginatedDataResponse.empty());

  static MyOrderResponse getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderResponse.empty();
}

class MyOrderShortItem {
  String id;
  String orderNumber;
  String date;
  String user;
  List<MyOrderedProduct> products;
  double netPrice;
  double subtotal;
  double discount;
  MyOrderDiscountCoupon discountCoupon;
  double vat;
  MyOrderVatApplied vatApplied;
  MyOrderDelivery delivery;
  double total;
  String paymentStatus;
  String paymentMethod;
  String payment;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime estimatedDeliveryDay;
  String receivedTime;
  MyOrderCustomAddress cusAddress;
  MyOrderPickupStation pickupStation;

  MyOrderShortItem({
    this.id = '',
    this.orderNumber = '',
    this.date = '',
    this.user = '',
    this.products = const [],
    this.netPrice = 0,
    this.subtotal = 0,
    this.discount = 0,
    required this.discountCoupon,
    this.vat = 0,
    required this.vatApplied,
    required this.delivery,
    this.total = 0,
    this.paymentStatus = '',
    this.paymentMethod = '',
    this.payment = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    required this.estimatedDeliveryDay,
    this.receivedTime = '',
    required this.cusAddress,
    required this.pickupStation,
  });

  factory MyOrderShortItem.fromJson(Map<String, dynamic> json) =>
      MyOrderShortItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        orderNumber: APIHelper.getSafeStringValue(json['order_number']),
        date: APIHelper.getSafeStringValue(json['date']),
        user: APIHelper.getSafeStringValue(json['user']),
        products: APIHelper.getSafeListValue(json['products'])
            .map((e) => MyOrderedProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        netPrice: APIHelper.getSafeDoubleValue(json['net_price']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        discount: APIHelper.getSafeDoubleValue(json['discount']),
        discountCoupon: MyOrderDiscountCoupon.getAPIResponseObjectSafeValue(
            json['discount_coupon']),
        vat: APIHelper.getSafeDoubleValue(json['vat']),
        vatApplied: MyOrderVatApplied.getAPIResponseObjectSafeValue(
            json['vat_applied']),
        delivery:
            MyOrderDelivery.getAPIResponseObjectSafeValue(json['delivery']),
        total: APIHelper.getSafeDoubleValue(json['total'] as num?),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        payment: APIHelper.getSafeStringValue(json['payment']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        estimatedDeliveryDay:
            APIHelper.getSafeDateTimeValue(json['estimated_delivery_day']),
        receivedTime: APIHelper.getSafeStringValue(json['received_time']),
        cusAddress: MyOrderCustomAddress.getAPIResponseObjectSafeValue(
            json['cus_address']),
        pickupStation: MyOrderPickupStation.getAPIResponseObjectSafeValue(
            json['pickup_station']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'order_number': orderNumber,
        'date': date,
        'user': user,
        'products': products.map((e) => e.toJson()).toList(),
        'net_price': netPrice,
        'subtotal': subtotal,
        'discount': discount,
        'discount_coupon': discountCoupon.toJson(),
        'vat': vat,
        'vat_applied': vatApplied.toJson(),
        'delivery': delivery.toJson(),
        'total': total,
        'payment_status': paymentStatus,
        'payment_method': paymentMethod,
        'payment': payment,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'estimated_delivery_day':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(
                estimatedDeliveryDay),
        'received_time': receivedTime,
        'cus_address': cusAddress,
        'pickup_station': pickupStation.toJson(),
      };
  factory MyOrderShortItem.empty() => MyOrderShortItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        cusAddress: MyOrderCustomAddress.empty(),
        discountCoupon: MyOrderDiscountCoupon(),
        vatApplied: MyOrderVatApplied(),
        delivery: MyOrderDelivery(),
        estimatedDeliveryDay: AppComponents.defaultUnsetDateTime,
        pickupStation: MyOrderPickupStation.empty(),
      );

  static MyOrderShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderShortItem.empty();
}
//=========Product======

class MyOrderedProduct {
  String product;
  MyOrderProductStore store;
  String name;
  String image;
  String unit;
  double price;
  int quantity;
  double subtotal;
  String id;

  MyOrderedProduct({
    this.product = '',
    required this.store,
    this.name = '',
    this.image = '',
    this.unit = '',
    this.price = 0,
    this.quantity = 0,
    this.subtotal = 0,
    this.id = '',
  });

  factory MyOrderedProduct.fromJson(Map<String, dynamic> json) =>
      MyOrderedProduct(
        product: APIHelper.getSafeStringValue(json['product']),
        store: MyOrderProductStore.getAPIResponseObjectSafeValue(json['store']),
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
        'store': store.toJson(),
        'name': name,
        'image': image,
        'unit': unit,
        'price': price,
        'quantity': quantity,
        'subtotal': subtotal,
        '_id': id,
      };

  factory MyOrderedProduct.empty() => MyOrderedProduct(
        store: MyOrderProductStore.empty(),
      );

  static MyOrderedProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderedProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderedProduct.empty();
}

//====delivery======
class MyOrderDelivery {
  double fare;
  double distance;
  double perKmFare;

  MyOrderDelivery({this.fare = 0, this.distance = 0, this.perKmFare = 0});

  factory MyOrderDelivery.fromJson(Map<String, dynamic> json) =>
      MyOrderDelivery(
        fare: APIHelper.getSafeDoubleValue(json['fare']),
        distance: APIHelper.getSafeDoubleValue(json['distance']),
        perKmFare: APIHelper.getSafeDoubleValue(json['per_km_fare']),
      );

  Map<String, dynamic> toJson() => {
        'fare': fare,
        'per_km_fare': perKmFare,
        'distance': distance,
      };
  static MyOrderDelivery getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderDelivery.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderDelivery();
}

//=========PickUpStation==========================
class MyOrderPickupStation {
  String id;
  String name;
  String address;
  double charged;
  MyOrderPickupStationLocation pickupLocation;

  MyOrderPickupStation({
    this.id = '',
    this.name = '',
    this.address = '',
    this.charged = 0,
    required this.pickupLocation,
  });

  factory MyOrderPickupStation.fromJson(Map<String, dynamic> json) =>
      MyOrderPickupStation(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        charged: APIHelper.getSafeDoubleValue(json['charged']),
        pickupLocation:
            MyOrderPickupStationLocation.getAPIResponseObjectSafeValue(
                json['pickup_location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'charged': charged,
        'pickup_location': pickupLocation.toJson(),
      };

  factory MyOrderPickupStation.empty() => MyOrderPickupStation(
        pickupLocation: MyOrderPickupStationLocation(),
      );

  static MyOrderPickupStation getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderPickupStation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderPickupStation.empty();
}

//======Store===============
class MyOrderProductStore {
  String id;
  String name;
  String location;
  String description;
  String logo;
  MyOrderProductVendor vendor;

  MyOrderProductStore({
    this.id = '',
    this.name = '',
    this.location = '',
    this.description = '',
    this.logo = '',
    required this.vendor,
  });

  factory MyOrderProductStore.fromJson(Map<String, dynamic> json) =>
      MyOrderProductStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        location: APIHelper.getSafeStringValue(json['location']),
        description: APIHelper.getSafeStringValue(json['description']),
        logo: APIHelper.getSafeStringValue(json['logo']),
        vendor:
            MyOrderProductVendor.getAPIResponseObjectSafeValue(json['vendor']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'location': location,
        'description': description,
        'logo': logo,
        'vendor': vendor.toJson(),
      };

  factory MyOrderProductStore.empty() => MyOrderProductStore(
        vendor: MyOrderProductVendor(),
      );

  static MyOrderProductStore getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderProductStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderProductStore.empty();
}

//================DiscountCoupon===========
class MyOrderDiscountCoupon {
  String code;
  double value;
  String discountType;

  MyOrderDiscountCoupon(
      {this.code = '', this.value = 0, this.discountType = ''});

  factory MyOrderDiscountCoupon.fromJson(Map<String, dynamic> json) {
    return MyOrderDiscountCoupon(
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

  static MyOrderDiscountCoupon getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderDiscountCoupon.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderDiscountCoupon();
}

//=========Vendor=============

class MyOrderProductVendor {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;

  MyOrderProductVendor(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.phone = ''});

  factory MyOrderProductVendor.fromJson(Map<String, dynamic> json) =>
      MyOrderProductVendor(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
      };

  static MyOrderProductVendor getAPIResponseObjectSafeValue(
          Object? unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderProductVendor.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderProductVendor();
}

//============PickupLocation====================
class MyOrderPickupStationLocation {
  double latitude;
  double longitude;

  MyOrderPickupStationLocation({this.latitude = 0, this.longitude = 0});

  factory MyOrderPickupStationLocation.fromJson(Map<String, dynamic> json) {
    return MyOrderPickupStationLocation(
      latitude: APIHelper.getSafeDoubleValue(json['latitude']),
      longitude: APIHelper.getSafeDoubleValue(json['longitude']),
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static MyOrderPickupStationLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderPickupStationLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderPickupStationLocation();
}

//=============VatApplied====================
class MyOrderVatApplied {
  String type;
  double value;

  MyOrderVatApplied({this.type = '', this.value = 0});

  factory MyOrderVatApplied.fromJson(Map<String, dynamic> json) =>
      MyOrderVatApplied(
        type: APIHelper.getSafeStringValue(json['type']),
        value: APIHelper.getSafeDoubleValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };

  static MyOrderVatApplied getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderVatApplied.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderVatApplied();
}

//=========CustomAddress===============

class MyOrderCustomAddress {
  MyOrderCusAddressShortItem cusAddress;

  MyOrderCustomAddress({required this.cusAddress});

  factory MyOrderCustomAddress.fromJson(Map<String, dynamic> json) {
    return MyOrderCustomAddress(
      cusAddress: MyOrderCusAddressShortItem.getAPIResponseObjectSafeValue(
          json['cus_address']),
    );
  }

  Map<String, dynamic> toJson() => {
        'cus_address': cusAddress.toJson(),
      };

  factory MyOrderCustomAddress.empty() => MyOrderCustomAddress(
        cusAddress: MyOrderCusAddressShortItem.empty(),
      );

  static MyOrderCustomAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderCustomAddress.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderCustomAddress.empty();
}

class MyOrderCusAddressShortItem {
  String deliveryType;
  MyOrderCustomAddressBook addressBook;
  MyOrderCusAddressPosition position;

  MyOrderCusAddressShortItem(
      {this.deliveryType = '',
      required this.addressBook,
      required this.position});

  factory MyOrderCusAddressShortItem.fromJson(Map<String, dynamic> json) =>
      MyOrderCusAddressShortItem(
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
  factory MyOrderCusAddressShortItem.empty() => MyOrderCusAddressShortItem(
        addressBook: MyOrderCustomAddressBook.empty(),
        position: MyOrderCusAddressPosition(),
      );

  static MyOrderCusAddressShortItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderCusAddressShortItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderCusAddressShortItem.empty();
}

class MyOrderCustomAddressBook {
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

  MyOrderCustomAddressBook({
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

  factory MyOrderCustomAddressBook.fromJson(Map<String, dynamic> json) =>
      MyOrderCustomAddressBook(
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

  factory MyOrderCustomAddressBook.empty() => MyOrderCustomAddressBook(
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
        position: MyOrderCusAddressPosition(),
        location: Location(),
      );

  static MyOrderCustomAddressBook getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderCustomAddressBook.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderCustomAddressBook.empty();

  String addressText() {
    return '$address, $area, $province, $city, $country';
  }
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

class MyOrderCusAddressPosition {
  double latitude;
  double longitude;

  MyOrderCusAddressPosition({this.latitude = 0, this.longitude = 0});

  factory MyOrderCusAddressPosition.fromJson(Map<String, dynamic> json) =>
      MyOrderCusAddressPosition(
        latitude: APIHelper.getSafeDoubleValue(json['latitude']),
        longitude: APIHelper.getSafeDoubleValue(json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static MyOrderCusAddressPosition getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyOrderCusAddressPosition.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyOrderCusAddressPosition();
}
