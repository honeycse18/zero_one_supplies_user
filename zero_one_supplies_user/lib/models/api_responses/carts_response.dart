import 'package:ecomik/utils/helpers/api_helper.dart';

class CartsResponse {
  bool error;
  String msg;
  CartsData data;

  CartsResponse({this.error = false, this.msg = '', required this.data});

  factory CartsResponse.fromJson(Map<String, dynamic> json) => CartsResponse(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: CartsData.getAPIResponseObjectSafeValue(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory CartsResponse.empty() => CartsResponse(data: CartsData.empty());

  static CartsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartsResponse.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CartsResponse.empty();
}

class CartsData {
  int numberOfCartItems;
  CartDetails cart;
  double total;
  String companyCommission;
  double chargedAmount;

  CartsData({
    this.numberOfCartItems = 0,
    required this.cart,
    this.total = 0,
    this.companyCommission = '',
    this.chargedAmount = 0,
  });

  factory CartsData.fromJson(Map<String, dynamic> json) => CartsData(
        numberOfCartItems: APIHelper.getSafeIntValue(json['numberOfCartItems']),
        cart: CartDetails.getAPIResponseObjectSafeValue(json['cart']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        companyCommission:
            APIHelper.getSafeStringValue(json['company_commission']),
        chargedAmount: APIHelper.getSafeDoubleValue(json['charged_amount']),
      );

  Map<String, dynamic> toJson() => {
        'numberOfCartItems': numberOfCartItems,
        'cart': cart.toJson(),
        'total': total,
        'company_commission': companyCommission,
        'charged_amount': chargedAmount,
      };

  factory CartsData.empty() => CartsData(cart: CartDetails());

  static CartsData getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartsData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CartsData.empty();
}

class CartDetails {
  List<CartDetailsProduct> products;
  String user;
  double netAmount;

  CartDetails({this.products = const [], this.user = '', this.netAmount = 0});

  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
        products: APIHelper.getSafeListValue(json['products'])
            .map((e) => CartDetailsProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
        user: APIHelper.getSafeStringValue(json['user']),
        netAmount: APIHelper.getSafeDoubleValue(json['net_amount']),
      );

  Map<String, dynamic> toJson() => {
        'products': products.map((e) => e.toJson()).toList(),
        'user': user,
        'net_amount': netAmount,
      };

  static CartDetails getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartDetails.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CartDetails();
}

class CartDetailsProduct {
  String cartId;
  String product;
  List<CartProductAttribute> attributes;
  double extraPrice;
  int quantity;
  double price;
  double subtotal;
  String store;
  String name;
  String image;
  String unit;
  CartProductCategory categories;

  CartDetailsProduct({
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
  });

  factory CartDetailsProduct.fromJson(Map<String, dynamic> json) =>
      CartDetailsProduct(
        cartId: APIHelper.getSafeStringValue(json['cart_id']),
        product: APIHelper.getSafeStringValue(json['product']),
        attributes: APIHelper.getSafeListValue(json['attributes'])
            .map((e) => CartProductAttribute.getAPIResponseObjectSafeValue(e))
            .toList(),
        extraPrice: APIHelper.getSafeDoubleValue(json['extra_price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        subtotal: APIHelper.getSafeDoubleValue(json['subtotal']),
        store: APIHelper.getSafeStringValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        categories: CartProductCategory.getAPIResponseObjectSafeValue(
            json['categories']),
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
      };

  factory CartDetailsProduct.empty() =>
      CartDetailsProduct(categories: CartProductCategory());

  static CartDetailsProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartDetailsProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CartDetailsProduct.empty();
}

class CartProductAttribute {
  String attributeKey;
  CartProductAttributeOption option;

  CartProductAttribute({this.attributeKey = '', required this.option});

  factory CartProductAttribute.fromJson(Map<String, dynamic> json) =>
      CartProductAttribute(
        attributeKey: APIHelper.getSafeStringValue(json['key']),
        option: CartProductAttributeOption.getAPIResponseObjectSafeValue(
            json['option']),
      );

  Map<String, dynamic> toJson() => {
        'key': attributeKey,
        'option': option.toJson(),
      };

  factory CartProductAttribute.empty() =>
      CartProductAttribute(option: CartProductAttributeOption());

  static CartProductAttribute getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartProductAttribute.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CartProductAttribute.empty();
}

class CartProductAttributeOption {
  String label;
  String value;
  double price;
  String id;

  CartProductAttributeOption({
    this.label = '',
    this.value = '',
    this.price = 0,
    this.id = '',
  });

  factory CartProductAttributeOption.fromJson(Map<String, dynamic> json) =>
      CartProductAttributeOption(
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

  static CartProductAttributeOption getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartProductAttributeOption.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CartProductAttributeOption();
}

class CartProductCategory {
  String id;
  String name;

  CartProductCategory({this.id = '', this.name = ''});

  factory CartProductCategory.fromJson(Map<String, dynamic> json) =>
      CartProductCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };

  static CartProductCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartProductCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CartProductCategory();
}
