import 'package:ecomik/utils/helpers/api_helper.dart';

class CartProduct {
  String product;
  String store;
  String name;
  String categoryName;
  String unit;
  String image;
  double price;
  int quantity;

  CartProduct({
    this.product = '',
    this.store = '',
    this.name = '',
    this.unit = '',
    this.categoryName = '',
    this.image = '',
    this.price = 0,
    this.quantity = 0,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        product: APIHelper.getSafeStringValue(json['product']),
        store: APIHelper.getSafeStringValue(json['store']),
        name: APIHelper.getSafeStringValue(json['name']),
        unit: APIHelper.getSafeStringValue(json['unit']),
        categoryName: APIHelper.getSafeStringValue(json['category_name']),
        image: APIHelper.getSafeStringValue(json['image']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
      );

  Map<String, dynamic> toJson() => {
        'product': product,
        'store': store,
        'name': name,
        'unit': unit,
        'category_name': categoryName,
        'image': image,
        'price': price,
        'quantity': quantity,
      };

  static CartProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartProduct.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CartProduct();

  double get subtotal => price * quantity;
}
