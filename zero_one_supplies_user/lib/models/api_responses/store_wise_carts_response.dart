import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class StoreWiseCartsResponse {
  bool error;
  String msg;
  StoreWiseCarts data;

  StoreWiseCartsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory StoreWiseCartsResponse.fromJson(Map<String, dynamic> json) {
    return StoreWiseCartsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: StoreWiseCarts.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory StoreWiseCartsResponse.empty() => StoreWiseCartsResponse(
      data: StoreWiseCarts(totalCarts: StoreWiseTotalCarts()));

  static StoreWiseCartsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartsResponse.empty();
}

class StoreWiseCarts {
  StoreWiseTotalCarts totalCarts;
  List<StoreWiseCart> carts;
  double netAmount;
  String companyCommission;
  double chargedAmount;
  double totalSaveMoney;
  double total;

  StoreWiseCarts({
    required this.totalCarts,
    this.carts = const [],
    this.netAmount = 0,
    this.companyCommission = '',
    this.chargedAmount = 0,
    this.totalSaveMoney = 0,
    this.total = 0,
  });

  factory StoreWiseCarts.fromJson(Map<String, dynamic> json) => StoreWiseCarts(
        totalCarts: StoreWiseTotalCarts.getAPIResponseObjectSafeValue(
            json['totalCarts']),
        carts: APIHelper.getSafeListValue((json['carts']))
            .map((e) => StoreWiseCart.getAPIResponseObjectSafeValue(e))
            .toList(),
        netAmount: APIHelper.getSafeDoubleValue(json['netAmount']),
        companyCommission:
            APIHelper.getSafeStringValue(json['company_commission']),
        chargedAmount: APIHelper.getSafeDoubleValue(json['charged_amount']),
        totalSaveMoney: APIHelper.getSafeDoubleValue(json['total_save_money']),
        total: APIHelper.getSafeDoubleValue(json['total']),
      );

  Map<String, dynamic> toJson() => {
        'totalCarts': totalCarts.toJson(),
        'carts': carts.map((e) => e.toJson()).toList(),
        'netAmount': netAmount,
        'company_commission': companyCommission,
        'charged_amount': chargedAmount,
        'total_save_money': totalSaveMoney,
        'total': total,
      };

  factory StoreWiseCarts.empty() =>
      StoreWiseCarts(totalCarts: StoreWiseTotalCarts());

  static StoreWiseCarts getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCarts.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCarts.empty();

  List<StoreWiseCartProduct> get cartProducts => carts.fold(
      [], (previousValue, element) => previousValue..addAll(element.products));
}

class StoreWiseTotalCarts {
  String id;
  int carts;

  StoreWiseTotalCarts({this.id = '', this.carts = 0});

  factory StoreWiseTotalCarts.fromJson(Map<String, dynamic> json) =>
      StoreWiseTotalCarts(
        id: APIHelper.getSafeStringValue(json['_id']),
        carts: APIHelper.getSafeIntValue(json['carts']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id.isEmpty ? null : id,
        'carts': carts,
      };

  static StoreWiseTotalCarts getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseTotalCarts.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseTotalCarts();
}

class StoreWiseCart {
  double total;
  List<StoreWiseCartProduct> products;
  StoreWiseCartStore store;
  StoreWiseCartCouponInfo couponInfo;

  StoreWiseCart(
      {this.total = 0,
      this.products = const [],
      required this.store,
      required this.couponInfo});

  factory StoreWiseCart.fromJson(Map<String, dynamic> json) => StoreWiseCart(
        total: APIHelper.getSafeDoubleValue(json['total']),
        products: APIHelper.getSafeListValue((json['products']))
            .map((e) => StoreWiseCartProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        store: StoreWiseCartStore.getAPIResponseObjectSafeValue(json['store']),
        couponInfo: StoreWiseCartCouponInfo.getAPIResponseObjectSafeValue(
            json['couponInfo']),
      );

  Map<String, dynamic> toJson() {
    final map = {
      'total': total,
      'products': products.map((e) => e.toJson()).toList(),
      'store': store.toJson(),
      'couponInfo': couponInfo.toJson(),
    };
    if (couponInfo.saveMoney == 0) {
      map.remove('couponInfo');
    }
    return map;
  }

  factory StoreWiseCart.empty() => StoreWiseCart(
      store: StoreWiseCartStore.empty(), couponInfo: StoreWiseCartCouponInfo());

  static StoreWiseCart getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCart.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCart.empty();
}

class StoreWiseCartCouponInfo {
  double currentSubtotal;
  double saveMoney;
  String couponValue;
  String couponCode;
  String msg;

  StoreWiseCartCouponInfo({
    this.currentSubtotal = 0,
    this.saveMoney = 0,
    this.couponValue = '',
    this.couponCode = '',
    this.msg = '',
  });

  factory StoreWiseCartCouponInfo.fromJson(Map<String, dynamic> json) {
    return StoreWiseCartCouponInfo(
      currentSubtotal: APIHelper.getSafeDoubleValue(json['current_subtotal']),
      saveMoney: APIHelper.getSafeDoubleValue(json['save_money']),
      couponValue: APIHelper.getSafeStringValue(json['coupon_value']),
      couponCode: APIHelper.getSafeStringValue(json['coupon_code']),
      msg: APIHelper.getSafeStringValue(json['msg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'current_subtotal': currentSubtotal,
        'save_money': saveMoney,
        'coupon_value': couponValue,
        'coupon_code': couponCode,
        'msg': msg,
      };

  static StoreWiseCartCouponInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartCouponInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartCouponInfo();
}

class StoreWiseCartStore {
  String id;
  String name;
  String address;
  StoreWiseCartStoreLocation location;

  StoreWiseCartStore(
      {this.id = '',
      this.name = '',
      this.address = '',
      required this.location});

  factory StoreWiseCartStore.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: StoreWiseCartStoreLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() {
    final map = {
      '_id': id,
      'name': name,
      'address': address,
      'location': location.toJson(),
    };
    if (address.isEmpty) {
      map.remove('address');
    }
    if (location.latitude == Constants.unsetMapLatLng ||
        location.longitude == Constants.unsetMapLatLng) {
      map.remove('location');
    }
    return map;
  }

  factory StoreWiseCartStore.empty() =>
      StoreWiseCartStore(location: StoreWiseCartStoreLocation());

  static StoreWiseCartStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartStore.empty();
}

class StoreWiseCartRelayPoint {
  String id;
  String name;
  String address;
  StoreWiseCartStoreLocation location;

  StoreWiseCartRelayPoint(
      {this.id = '',
      this.name = '',
      this.address = '',
      required this.location});

  factory StoreWiseCartRelayPoint.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartRelayPoint(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: StoreWiseCartStoreLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'location': location.toJson(),
      };

  factory StoreWiseCartRelayPoint.empty() =>
      StoreWiseCartRelayPoint(location: StoreWiseCartStoreLocation());

  static StoreWiseCartRelayPoint getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartRelayPoint.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartRelayPoint.empty();
}

class StoreWiseCartStoreLocation {
  double latitude;
  double longitude;

  StoreWiseCartStoreLocation(
      {this.latitude = Constants.unsetMapLatLng,
      this.longitude = Constants.unsetMapLatLng});

  factory StoreWiseCartStoreLocation.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartStoreLocation(
        latitude: APIHelper.getSafeDoubleValue(
            json['latitude'], Constants.unsetMapLatLng),
        longitude: APIHelper.getSafeDoubleValue(
            json['longitude'], Constants.unsetMapLatLng),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  static StoreWiseCartStoreLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartStoreLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartStoreLocation();
}

class StoreWiseCartProduct {
  String cartId;
  String product;
  List<StoreWiseCartProductAttribute> attributes;
  double extraPrice;
  int quantity;
  double price;
  double subtotal;
  String store;
  String name;
  String image;
  String unit;
  StoreWiseCartProductCategories categories;
  bool isAuction;
  StoreWiseCartProductLocation productLocation;

  StoreWiseCartProduct({
    this.cartId = '',
    this.product = '',
    this.attributes = const [],
    this.extraPrice = 0,
    this.quantity = 0,
    this.price = 0,
    this.subtotal = 0,
    this.store = '',
    this.name = '',
    this.image = '',
    this.unit = '',
    required this.categories,
    this.isAuction = false,
    required this.productLocation,
  });

  factory StoreWiseCartProduct.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartProduct(
        cartId: APIHelper.getSafeStringValue(json['cart_id']),
        product: APIHelper.getSafeStringValue(json['product']),
        attributes: APIHelper.getSafeListValue((json['attributes']))
            .map((e) =>
                StoreWiseCartProductAttribute.getAPIResponseObjectSafeValue(e))
            .toList(),
        extraPrice: APIHelper.getSafeDoubleValue(json['extra_price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        store: APIHelper.getSafeStringValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        categories:
            StoreWiseCartProductCategories.getAPIResponseObjectSafeValue(
                json['categories']),
        isAuction: APIHelper.getSafeBoolValue(json['isAuction']),
        productLocation:
            StoreWiseCartProductLocation.getAPIResponseObjectSafeValue(
                json['product_location']),
      );

  Map<String, dynamic> toJson() {
    final map = {
      'cart_id': cartId,
      'product': product,
      'attributes': attributes.map((e) => e.toJson()).toList(),
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
      'product_location': productLocation.toJson(),
    };
    if (productLocation.productLocationType == ProductLocation.none) {
      map.remove('product_location');
    }
    return map;
  }

  factory StoreWiseCartProduct.empty() => StoreWiseCartProduct(
      categories: StoreWiseCartProductCategories(),
      productLocation: StoreWiseCartProductLocation.empty());

  static StoreWiseCartProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProduct.empty();
}

class StoreWiseCartProductCategories {
  String id;
  String name;

  StoreWiseCartProductCategories({this.id = '', this.name = ''});

  factory StoreWiseCartProductCategories.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartProductCategories(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static StoreWiseCartProductCategories getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductCategories.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductCategories();
}

class StoreWiseCartProductLocation {
  String type;
  StoreWiseCartStore store;
  StoreWiseCartRelayPoint relayPoint;

  StoreWiseCartProductLocation(
      {this.type = '', required this.store, required this.relayPoint});

  factory StoreWiseCartProductLocation.fromJson(Map<String, dynamic> json) {
    return StoreWiseCartProductLocation(
      type: APIHelper.getSafeStringValue(json['type']),
      store: StoreWiseCartStore.getAPIResponseObjectSafeValue(json['store']),
      relayPoint: StoreWiseCartRelayPoint.getAPIResponseObjectSafeValue(
          json['replay_point']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'type': type,
    };
    switch (type) {
      case 'store':
        map['store'] = store.toJson();
        break;
      case 'replay_point':
        map['replay_point'] = relayPoint.toJson();
        break;
    }
    return map;
  }

  factory StoreWiseCartProductLocation.empty() => StoreWiseCartProductLocation(
      store: StoreWiseCartStore.empty(),
      relayPoint: StoreWiseCartRelayPoint.empty());

  static StoreWiseCartProductLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductLocation.empty();

  ProductLocation get productLocationType =>
      ProductLocation.typeToEnumValue(type);
}

class StoreWiseCartProductAttribute {
  String key;
  StoreWiseCartProductAttributeOption option;

  StoreWiseCartProductAttribute({this.key = '', required this.option});

  factory StoreWiseCartProductAttribute.fromJson(Map<String, dynamic> json) =>
      StoreWiseCartProductAttribute(
        key: APIHelper.getSafeStringValue(json['key']),
        option:
            StoreWiseCartProductAttributeOption.getAPIResponseObjectSafeValue(
                json['option']),
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'option': option.toJson(),
      };
  factory StoreWiseCartProductAttribute.empty() =>
      StoreWiseCartProductAttribute(
          option: StoreWiseCartProductAttributeOption());

  static StoreWiseCartProductAttribute getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductAttribute.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductAttribute.empty();
}

class StoreWiseCartProductAttributeOption {
  String label;
  String value;
  double price;
  String id;

  StoreWiseCartProductAttributeOption(
      {this.label = '', this.value = '', this.price = 0, this.id = ''});

  factory StoreWiseCartProductAttributeOption.fromJson(
          Map<String, dynamic> json) =>
      StoreWiseCartProductAttributeOption(
        label: APIHelper.getSafeStringValue(json['label']),
        value: APIHelper.getSafeStringValue(json['value']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        id: APIHelper.getSafeStringValue(json['_id']),
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'value': value,
        'price': price,
        '_id': id,
      };

  static StoreWiseCartProductAttributeOption getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoreWiseCartProductAttributeOption.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoreWiseCartProductAttributeOption();
}
