import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class SendAnOfferListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<SendOfferListItem> data;

  SendAnOfferListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory SendAnOfferListResponse.fromJson(Map<String, dynamic> json) {
    return SendAnOfferListResponse(
      error: json['error'] as bool,
      msg: json['msg'] as String,
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            SendOfferListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory SendAnOfferListResponse.empty() => SendAnOfferListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static SendAnOfferListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SendAnOfferListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SendAnOfferListResponse.empty();
}

class SendOfferListItem {
  String id;
  SendOfferProduct product;
  SendOfferStore store;
  String status;
  int quantity;
  double price;
  DateTime createdAt;
  DateTime updatedAt;

  SendOfferListItem({
    this.id = '',
    required this.product,
    required this.store,
    this.status = '',
    this.quantity = 0,
    this.price = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SendOfferListItem.fromJson(Map<String, dynamic> json) =>
      SendOfferListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        product:
            SendOfferProduct.getAPIResponseObjectSafeValue(json['product']),
        store: SendOfferStore.getAPIResponseObjectSafeValue(json['store']),
        status: APIHelper.getSafeStringValue(json['status']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'product': product.toJson(),
        'store': store.toJson(),
        'status': status,
        'quantity': quantity,
        'price': price,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory SendOfferListItem.empty() => SendOfferListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        product: SendOfferProduct.empty(),
        store: SendOfferStore(),
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static SendOfferListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SendOfferListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SendOfferListItem.empty();
}

class SendOfferProduct {
  String id;
  String name;
  String model;
  double price;
  String productImage;
  ProductDetailsLocation productLocation;

  SendOfferProduct({
    this.id = '',
    this.name = '',
    this.model = '',
    this.price = 0,
    this.productImage = '',
    required this.productLocation,
  });

  factory SendOfferProduct.fromJson(Map<String, dynamic> json) =>
      SendOfferProduct(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        model: APIHelper.getSafeStringValue(json['model']),
        price: APIHelper.getSafeDoubleValue(json['price']),
        productImage: APIHelper.getSafeStringValue(json['product_image']),
        productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
            json['product_location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'model': model,
        'price': price,
        'product_image': productImage,
        'product_location': productLocation.toJson(),
      };

  factory SendOfferProduct.empty() => SendOfferProduct(
        productLocation: ProductDetailsLocation.empty(),
      );

  static SendOfferProduct getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SendOfferProduct.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : SendOfferProduct.empty();
}

class SendOfferStore {
  String id;
  String name;
  String address;

  SendOfferStore({this.id = '', this.name = '', this.address = ''});

  factory SendOfferStore.fromJson(Map<String, dynamic> json) => SendOfferStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
      };

  static SendOfferStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? SendOfferStore.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : SendOfferStore();
}
