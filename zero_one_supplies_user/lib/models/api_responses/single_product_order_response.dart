import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SingleProductOrderResponse {
  bool error;
  String msg;
  SingleProductOrderItem data;

  SingleProductOrderResponse(
      {this.error = false, this.msg = '', required this.data});

  factory SingleProductOrderResponse.fromJson(Map<String, dynamic> json) {
    return SingleProductOrderResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: SingleProductOrderItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory SingleProductOrderResponse.empty() => SingleProductOrderResponse(
        data: SingleProductOrderItem.empty(),
      );
  static SingleProductOrderResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductOrderResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductOrderResponse.empty();
}

class SingleProductOrderItem {
  String id;
  SingleProductOrderUser user;
  int totalProducts;
  List<SingleProductOrder> orders;
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
  String payment;
  String paymentMethod;

  SingleProductOrderItem({
    this.id = '',
    required this.user,
    this.totalProducts = 0,
    this.orders = const [],
    this.netAmount = 0,
    this.companyCommission = '',
    this.chargedAmount = 0,
    this.totalSaveMoney = 0,
    this.total = 0,
    this.productReceiveTime = '',
    required this.delivery,
    this.paymentStatus = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.payment = '',
    this.paymentMethod = '',
    this.estimatedDeliveryHours = 0,
  });

  factory SingleProductOrderItem.fromJson(Map<String, dynamic> json) =>
      SingleProductOrderItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user:
            SingleProductOrderUser.getAPIResponseObjectSafeValue(json['user']),
        totalProducts: APIHelper.getSafeIntValue(json['totalProducts']),
        orders: (json['orders'] as List<dynamic>)
            .map((e) => SingleProductOrder.fromJson(e))
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
        delivery: Delivery.getAPIResponseObjectSafeValue(json['delivery']),
        paymentStatus: APIHelper.getSafeStringValue(json['payment_status']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        payment: APIHelper.getSafeStringValue(json['payment']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
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
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        'payment': payment,
        'payment_method': paymentMethod,
      };

  factory SingleProductOrderItem.empty() => SingleProductOrderItem(
        user: SingleProductOrderUser(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        createdAt: AppComponents.defaultUnsetDateTime,
        delivery: Delivery.empty(),
      );
  static SingleProductOrderItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductOrderItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductOrderItem.empty();
}

class SingleProductOrderUser {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String role;
  bool verified;
  bool active;
  String gender;
  String image;

  SingleProductOrderUser({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.role = '',
    this.verified = false,
    this.active = false,
    this.gender = '',
    this.image = '',
  });

  factory SingleProductOrderUser.fromJson(Map<String, dynamic> json) =>
      SingleProductOrderUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        firstName: APIHelper.getSafeStringValue(json['first_name']),
        lastName: APIHelper.getSafeStringValue(json['last_name']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        role: APIHelper.getSafeStringValue(json['role']),
        verified: APIHelper.getSafeBoolValue(json['verified']),
        active: APIHelper.getSafeBoolValue(json['active']),
        gender: APIHelper.getSafeStringValue(json['gender']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'role': role,
        'verified': verified,
        'active': active,
        'gender': gender,
        'image': image,
      };

  static SingleProductOrderUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductOrderUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductOrderUser();
}

class SingleProductOrderProduct {
  String cartId;
  String product;
  List<dynamic> attributes;
  double extraPrice;
  int quantity;
  double price;
  double subtotal;
  String store;
  String name;
  String image;
  String unit;
  Categories categories;
  bool isAuction;

  SingleProductOrderProduct({
    this.cartId = '',
    this.product = '',
    this.attributes = const [],
    this.quantity = 0,
    this.price = 0,
    this.subtotal = 0,
    this.store = '',
    this.name = '',
    this.image = '',
    this.unit = '',
    this.isAuction = false,
    required this.categories,
    this.extraPrice = 0,
  });

  factory SingleProductOrderProduct.fromJson(Map<String, dynamic> json) =>
      SingleProductOrderProduct(
        cartId: APIHelper.getSafeStringValue(json['cart_id']),
        product: APIHelper.getSafeStringValue(json['product']),
        attributes: APIHelper.getSafeListValue(json['attributes']),
        extraPrice: APIHelper.getSafeDoubleValue(json['extra_price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        store: APIHelper.getSafeStringValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        categories:
            Categories.getAPIResponseObjectSafeValue(json['categories']),
        isAuction: APIHelper.getSafeBoolValue(json['isAuction']),
      );

  Map<String, dynamic> toJson() => {
        'cart_id': cartId,
        'product': product,
        'attributes': attributes,
        'extra_price': extraPrice,
        'quantity': quantity,
        'price': price,
        'subtotal': subtotal,
        'store': store,
        'name': name,
        'image': image,
        'unit': unit,
        'categories': categories.toJson(),
        'isAuction': isAuction,
      };

  factory SingleProductOrderProduct.empty() =>
      SingleProductOrderProduct(categories: Categories());
  static SingleProductOrderProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductOrderProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductOrderProduct.empty();
}

class CouponInfo {
  double currentSubtotal;
  double saveMoney;
  String couponValue;
  String couponCode;
  String msg;

  CouponInfo({
    this.currentSubtotal = 0,
    this.saveMoney = 0,
    this.couponValue = '',
    this.couponCode = '',
    this.msg = '',
  });

  factory CouponInfo.fromJson(Map<String, dynamic> json) => CouponInfo(
        currentSubtotal: APIHelper.getSafeDoubleValue(json['current_subtotal']),
        saveMoney: APIHelper.getSafeDoubleValue(json['save_money']),
        couponValue: APIHelper.getSafeStringValue(json['coupon_value']),
        couponCode: APIHelper.getSafeStringValue(json['coupon_code']),
        msg: APIHelper.getSafeStringValue(json['msg']),
      );

  Map<String, dynamic> toJson() => {
        'current_subtotal': currentSubtotal,
        'save_money': saveMoney,
        'coupon_value': couponValue,
        'coupon_code': couponCode,
        'msg': msg,
      };

  static CouponInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CouponInfo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CouponInfo();
}

class SingleProductOrder {
  double total;
  List<SingleProductOrderProduct> products;
  Store store;
  CouponInfo couponInfo;

  SingleProductOrder(
      {this.total = 0,
      this.products = const [],
      required this.store,
      required this.couponInfo});

  factory SingleProductOrder.fromJson(Map<String, dynamic> json) =>
      SingleProductOrder(
        total: APIHelper.getSafeDoubleValue(json['total']),
        products: APIHelper.getSafeListValue(json['products'])
            .map((e) =>
                SingleProductOrderProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        store: Store.getAPIResponseObjectSafeValue(json['store']),
        couponInfo:
            CouponInfo.getAPIResponseObjectSafeValue(json['couponInfo']),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'products': products.map((e) => e.toJson()).toList(),
        'store': store.toJson(),
        'couponInfo': couponInfo.toJson(),
      };

  factory SingleProductOrder.empty() =>
      SingleProductOrder(couponInfo: CouponInfo(), store: Store());
  static SingleProductOrder getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SingleProductOrder.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SingleProductOrder.empty();
}

class Store {
  String id;
  String name;

  Store({this.id = '', this.name = ''});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static Store getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Store.fromJson(unsafeResponseValue)
          : Store();
}

class Delivery {
  Address address;
  String type;
  String id;

  Delivery({required this.address, this.type = '', this.id = ''});

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        address: Address.getAPIResponseObjectSafeValue(json['address']),
        type: APIHelper.getSafeStringValue(json['type']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'address': address.toJson(),
        'type': type,
        '_id': id,
      };

  factory Delivery.empty() => Delivery(
        address: Address.empty(),
      );
  static Delivery getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Delivery.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Delivery.empty();
}

class Address {
  Position position;
  String id;
  String address;
  String delivery;
  double totalCost;

  Address({
    required this.position,
    this.id = '',
    this.address = '',
    this.delivery = '',
    this.totalCost = 0,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        position: Position.getAPIResponseObjectSafeValue(json['position']),
        id: APIHelper.getSafeStringValue(json['_id']),
        address: APIHelper.getSafeStringValue(json['address']),
        delivery: APIHelper.getSafeStringValue(json['delivery']),
        totalCost: APIHelper.getSafeDoubleValue(json['totalCost']),
      );

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        '_id': id,
        'address': address,
        'delivery': delivery,
        'totalCost': totalCost,
      };

  factory Address.empty() => Address(position: Position());
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

class Categories {
  String id;
  String name;

  Categories({this.id = '', this.name = ''});

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static Categories getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Categories.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Categories();
}
