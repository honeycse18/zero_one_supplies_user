import 'package:ecomik/utils/helpers/api_helper.dart';

class StoredGroupedCartsResponse {
  bool error;
  String msg;
  StoredGroupedCarts data;

  StoredGroupedCartsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory StoredGroupedCartsResponse.fromJson(Map<String, dynamic> json) {
    return StoredGroupedCartsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: StoredGroupedCarts.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory StoredGroupedCartsResponse.empty() =>
      StoredGroupedCartsResponse(data: StoredGroupedCarts.empty());

  static StoredGroupedCartsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartsResponse.empty();
}

class StoredGroupedCarts {
  StoredGroupedCartsTotalCarts totalCarts;
  List<StoredGroupedCart> carts;
  double netAmount;
  String companyCommission;
  double chargedAmount;
  double totalSaveMoney;
  double total;

  StoredGroupedCarts({
    required this.totalCarts,
    this.carts = const [],
    this.netAmount = 0,
    this.companyCommission = '',
    this.chargedAmount = 0,
    this.totalSaveMoney = 0,
    this.total = 0,
  });

  factory StoredGroupedCarts.fromJson(Map<String, dynamic> json) =>
      StoredGroupedCarts(
        totalCarts: StoredGroupedCartsTotalCarts.getAPIResponseObjectSafeValue(
            json['totalCarts']),
        carts: APIHelper.getSafeListValue(json['carts'])
            .map((e) => StoredGroupedCart.getAPIResponseObjectSafeValue(e))
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

  factory StoredGroupedCarts.empty() =>
      StoredGroupedCarts(totalCarts: StoredGroupedCartsTotalCarts());

  static StoredGroupedCarts getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCarts.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCarts.empty();
}

class StoredGroupedCart {
  double total;
  List<StoredGroupedCartProduct> products;
  StoredGroupedCartStore store;
  StoredGroupedCartProductCouponInfo couponInfo;

  StoredGroupedCart(
      {this.total = 0,
      this.products = const [],
      required this.store,
      required this.couponInfo});

  factory StoredGroupedCart.fromJson(Map<String, dynamic> json) =>
      StoredGroupedCart(
        total: APIHelper.getSafeDoubleValue(json['total']),
        products: (APIHelper.getSafeListValue(json['products']))
            .map((e) =>
                StoredGroupedCartProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        store:
            StoredGroupedCartStore.getAPIResponseObjectSafeValue(json['store']),
        couponInfo:
            StoredGroupedCartProductCouponInfo.getAPIResponseObjectSafeValue(
                json['couponInfo']),
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'products': products.map((e) => e.toJson()).toList(),
        'store': store.toJson(),
        'couponInfo': couponInfo.toJson(),
      };
  factory StoredGroupedCart.empty() => StoredGroupedCart(
      store: StoredGroupedCartStore(),
      couponInfo: StoredGroupedCartProductCouponInfo());

  static StoredGroupedCart getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCart.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCart.empty();
}

class StoredGroupedCartProductCouponInfo {
  double currentSubtotal;
  double saveMoney;
  String couponValue;
  String couponCode;
  String msg;

  StoredGroupedCartProductCouponInfo({
    this.currentSubtotal = 0,
    this.saveMoney = 0,
    this.couponValue = '',
    this.couponCode = '',
    this.msg = '',
  });

  factory StoredGroupedCartProductCouponInfo.fromJson(
          Map<String, dynamic> json) =>
      StoredGroupedCartProductCouponInfo(
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

  static StoredGroupedCartProductCouponInfo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartProductCouponInfo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartProductCouponInfo();
}

class StoredGroupedCartProductAttribute {
  String key;
  StoredGroupedCartProductAttributeOption option;

  StoredGroupedCartProductAttribute({this.key = '', required this.option});

  factory StoredGroupedCartProductAttribute.fromJson(
      Map<String, dynamic> json) {
    return StoredGroupedCartProductAttribute(
      key: APIHelper.getSafeStringValue(json['key']),
      option:
          StoredGroupedCartProductAttributeOption.getAPIResponseObjectSafeValue(
              json['option']),
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'option': option.toJson(),
      };
  factory StoredGroupedCartProductAttribute.empty() =>
      StoredGroupedCartProductAttribute(
          option: StoredGroupedCartProductAttributeOption());

  static StoredGroupedCartProductAttribute getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartProductAttribute.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartProductAttribute.empty();
}

class StoredGroupedCartProductAttributeOption {
  String label;
  String value;
  double price;
  String id;

  StoredGroupedCartProductAttributeOption(
      {this.label = '', this.value = '', this.price = 0, this.id = ''});

  factory StoredGroupedCartProductAttributeOption.fromJson(
          Map<String, dynamic> json) =>
      StoredGroupedCartProductAttributeOption(
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
  static StoredGroupedCartProductAttributeOption getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartProductAttributeOption.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartProductAttributeOption();
}

class StoredGroupedCartProduct {
  String cartId;
  String product;
  List<StoredGroupedCartProductAttribute> attributes;
  double extraPrice;
  int quantity;
  double price;
  double subtotal;
  String store;
  String name;
  String image;
  String unit;
  StoredGroupedCartCategories categories;
  bool isAuction;

  StoredGroupedCartProduct({
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
  });

  factory StoredGroupedCartProduct.fromJson(Map<String, dynamic> json) =>
      StoredGroupedCartProduct(
        cartId: APIHelper.getSafeStringValue(json['cart_id']),
        product: APIHelper.getSafeStringValue(json['product']),
        attributes: APIHelper.getSafeListValue(json['attributes'])
            .map((e) =>
                StoredGroupedCartProductAttribute.getAPIResponseObjectSafeValue(
                    e))
            .toList(),
        extraPrice: APIHelper.getSafeDoubleValue(json['extra_price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        store: APIHelper.getSafeStringValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        categories: StoredGroupedCartCategories.getAPIResponseObjectSafeValue(
            json['categories']),
        isAuction: APIHelper.getSafeBoolValue(json['isAuction']),
      );

  Map<String, dynamic> toJson() => {
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
      };

  factory StoredGroupedCartProduct.empty() =>
      StoredGroupedCartProduct(categories: StoredGroupedCartCategories());

  static StoredGroupedCartProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartProduct.empty();
}

class StoredGroupedCartCategories {
  String id;
  String name;

  StoredGroupedCartCategories({this.id = '', this.name = ''});

  factory StoredGroupedCartCategories.fromJson(Map<String, dynamic> json) =>
      StoredGroupedCartCategories(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static StoredGroupedCartCategories getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartCategories.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartCategories();
}

class StoredGroupedCartStore {
  String id;
  String name;

  StoredGroupedCartStore({this.id = '', this.name = ''});

  factory StoredGroupedCartStore.fromJson(Map<String, dynamic> json) =>
      StoredGroupedCartStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static StoredGroupedCartStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartStore();
}

class StoredGroupedCartsTotalCarts {
  String id;
  int carts;

  StoredGroupedCartsTotalCarts({this.id = '', this.carts = 0});

  factory StoredGroupedCartsTotalCarts.fromJson(Map<String, dynamic> json) =>
      StoredGroupedCartsTotalCarts(
        id: APIHelper.getSafeStringValue(json['_id']),
        carts: APIHelper.getSafeIntValue(json['carts']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'carts': carts,
      };

  static StoredGroupedCartsTotalCarts getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? StoredGroupedCartsTotalCarts.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : StoredGroupedCartsTotalCarts();
}
