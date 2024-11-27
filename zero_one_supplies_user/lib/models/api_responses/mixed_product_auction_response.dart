import 'package:ecomik/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:ecomik/models/api_responses/pickup_stations_response.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';

class ProductAuctionMixedResponse {
  bool error;
  String msg;
  PaginatedDataResponse<MixedAuctionProductItem> data;

  ProductAuctionMixedResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ProductAuctionMixedResponse.fromJson(Map<String, dynamic> json) =>
      ProductAuctionMixedResponse(
        error: APIHelper.getSafeBoolValue(json['error']),
        msg: APIHelper.getSafeStringValue(json['msg']),
        data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
          json['data'],
          docFromJson: (data) =>
              MixedAuctionProductItem.getAPIResponseObjectSafeValue(data),
        ),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ProductAuctionMixedResponse.empty() =>
      ProductAuctionMixedResponse(data: PaginatedDataResponse.empty());
  static ProductAuctionMixedResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductAuctionMixedResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductAuctionMixedResponse.empty();
}

class MixedAuctionProductItem {
  String id;
  Store store;
  String name;
  String productCondition;
  List<String> tags;
  double originalPrice;
  bool newArrival;
  List<QuantityBasedPrice> quantityBasedPrice;
  DateTime createdAt;
  String image;
  bool discount;
  DiscountValue discountValue;
  double currentPrice;
  Product product;
  DateTime startDate;
  DateTime endDate;
  bool status;
  bool isEnd;
  bool isAuction;
  bool isFavorite;
  bool isAddedToCart;
  ProductDetailsLocation productLocation;

  MixedAuctionProductItem({
    this.id = '',
    this.name = '',
    this.productCondition = '',
    this.tags = const [],
    this.originalPrice = 0,
    this.newArrival = false,
    this.quantityBasedPrice = const [],
    required this.createdAt,
    this.image = '',
    this.discount = false,
    required this.discountValue,
    this.currentPrice = 0,
    required this.store,
    required this.product,
    required this.startDate,
    required this.endDate,
    this.status = false,
    this.isEnd = false,
    this.isAuction = false,
    this.isFavorite = false,
    this.isAddedToCart = false,
    required this.productLocation,
  });

  factory MixedAuctionProductItem.fromJson(Map<String, dynamic> json) =>
      MixedAuctionProductItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        productCondition:
            APIHelper.getSafeStringValue(json['product_condition']),
        tags: APIHelper.getSafeListValue(json['tags']),
        originalPrice: APIHelper.getSafeDoubleValue(json['price']),
        newArrival: APIHelper.getSafeBoolValue(json['new_arrival']),
        quantityBasedPrice:
            APIHelper.getSafeListValue(json['quantity_based_price'])
                .map((e) => QuantityBasedPrice.getAPIResponseObjectSafeValue(
                    json['quantity_based_price']))
                .toList(),
        productLocation: ProductDetailsLocation.getAPIResponseObjectSafeValue(
            json['product_location']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        image: APIHelper.getSafeStringValue(json['image']),
        discount: APIHelper.getSafeBoolValue(json['discount']),
        isFavorite: APIHelper.getSafeBoolValue(json['isFavorite']),
        isAddedToCart: APIHelper.getSafeBoolValue(json['isAddedToCart']),
        discountValue:
            DiscountValue.getAPIResponseObjectSafeValue(json['discount_value']),
        currentPrice: APIHelper.getSafeDoubleValue(json['current_price']),
        store: Store.getAPIResponseObjectSafeValue(json['store']),
        product: Product.getAPIResponseObjectSafeValue(json['product']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
        status: APIHelper.getSafeBoolValue(json['status']),
        isEnd: APIHelper.getSafeBoolValue(json['is_end']),
        isAuction: APIHelper.getSafeBoolValue(json['is_auction']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'product_condition': productCondition,
        'tags': tags,
        'price': originalPrice,
        'new_arrival': newArrival,
        'quantity_based_price':
            quantityBasedPrice.map((e) => e.toJson()).toList(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'image': image,
        'discount': discount,
        'discount_value': discountValue.toJson(),
        'current_price': currentPrice,
        'isFavorite': isFavorite,
        'isAddedToCart': isAddedToCart,
        'store': store.toJson(),
        'product_location': productLocation.toJson(),
        'product': product.toJson(),
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
        'status': status,
        'is_end': isEnd,
        'isAuction': isAuction,
      };

  factory MixedAuctionProductItem.empty() => MixedAuctionProductItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      discountValue: DiscountValue.empty(),
      endDate: AppComponents.defaultUnsetDateTime,
      product: Product.empty(),
      productLocation: ProductDetailsLocation.empty(),
      startDate: AppComponents.defaultUnsetDateTime,
      store: Store());
  static MixedAuctionProductItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MixedAuctionProductItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MixedAuctionProductItem.empty();

  ProductConditionStatus get productConditionStatusEnum =>
      ProductConditionStatus.toEnumValue(productCondition);
}

class ProductDetailsLocationStore {
  String id;
  String name;
  String address;
  ProductDetailsLocationStoreLocation location;

  ProductDetailsLocationStore(
      {this.id = '',
      this.name = '',
      this.address = '',
      required this.location});

  factory ProductDetailsLocationStore.fromJson(Map<String, dynamic> json) =>
      ProductDetailsLocationStore(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        address: APIHelper.getSafeStringValue(json['address']),
        location:
            ProductDetailsLocationStoreLocation.getAPIResponseObjectSafeValue(
                json['location']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'address': address,
        'location': location.toJson(),
      };

  factory ProductDetailsLocationStore.empty() => ProductDetailsLocationStore(
      location: ProductDetailsLocationStoreLocation());

  static ProductDetailsLocationStore getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsLocationStore.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsLocationStore.empty();
}

class ProductDetailsLocationStoreLocation {
  double latitude;
  double longitude;

  ProductDetailsLocationStoreLocation(
      {this.latitude = Constants.unsetMapLatLng,
      this.longitude = Constants.unsetMapLatLng});

  factory ProductDetailsLocationStoreLocation.fromJson(
          Map<String, dynamic> json) =>
      ProductDetailsLocationStoreLocation(
        latitude: APIHelper.getSafeDoubleValue(
            json['latitude'], Constants.unsetMapLatLng),
        longitude: APIHelper.getSafeDoubleValue(
            json['longitude'], Constants.unsetMapLatLng),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
  static ProductDetailsLocationStoreLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ProductDetailsLocationStoreLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ProductDetailsLocationStoreLocation();
}

class Product {
  String id;
  String name;
  String image;
  Store store;

  Product({
    this.id = '',
    this.name = '',
    this.image = '',
    required this.store,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
        store: Store.getAPIResponseObjectSafeValue(json['store']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
        'store': store.toJson(),
      };

  factory Product.empty() => Product(store: Store());
  static Product getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Product.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Product.empty();
}

class Store {
  String id;
  String name;
  bool verified;

  Store({this.id = '', this.name = '', this.verified = false});

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        verified: APIHelper.getSafeBoolValue(json['verified']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'verified': verified,
      };

  static Store getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Store.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Store();
}

class DiscountValue {
  String type;
  double amount;
  DateTime startDate;
  DateTime endDate;

  DiscountValue(
      {this.type = '',
      this.amount = 0,
      required this.startDate,
      required this.endDate});

  factory DiscountValue.fromJson(Map<String, dynamic> json) => DiscountValue(
        type: APIHelper.getSafeStringValue(json['type']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        startDate: APIHelper.getSafeDateTimeValue(json['start_date']),
        endDate: APIHelper.getSafeDateTimeValue(json['end_date']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'amount': amount,
        'start_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startDate),
        'end_date':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(endDate),
      };

  factory DiscountValue.empty() => DiscountValue(
        endDate: AppComponents.defaultUnsetDateTime,
        startDate: AppComponents.defaultUnsetDateTime,
      );
  static DiscountValue getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DiscountValue.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : DiscountValue.empty();
}

class QuantityBasedPrice {
  int minimum;
  int maximum;
  double price;
  String id;

  QuantityBasedPrice(
      {this.minimum = 0, this.maximum = 0, this.price = 0, this.id = ''});

  factory QuantityBasedPrice.fromJson(Map<String, dynamic> json) {
    return QuantityBasedPrice(
      minimum: APIHelper.getSafeIntValue(json['minimum']),
      maximum: APIHelper.getSafeIntValue(json['maximum']),
      price: APIHelper.getSafeDoubleValue(json['price']),
      id: APIHelper.getSafeStringValue(json['_id']),
    );
  }

  Map<String, dynamic> toJson() => {
        'minimum': minimum,
        'maximum': maximum,
        'price': price,
        '_id': id,
      };

  static QuantityBasedPrice getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? QuantityBasedPrice.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : QuantityBasedPrice();
}
