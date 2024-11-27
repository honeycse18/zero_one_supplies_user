import 'package:ecomik/models/local_models/local_storage_models/cart_product.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class CartProducts {
  List<CartProduct> cartProducts;

  CartProducts({this.cartProducts = const []});

  factory CartProducts.fromJson(Map<String, dynamic> json) => CartProducts(
        cartProducts: APIHelper.getSafeListValue(json['products'])
            .map((e) => CartProduct.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'products': cartProducts.map((e) => e.toJson()).toList(),
      };

  static CartProducts getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CartProducts.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CartProducts();
}
