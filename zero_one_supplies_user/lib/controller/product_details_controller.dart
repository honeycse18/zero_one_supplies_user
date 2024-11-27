import 'dart:developer';

import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/local_models/selected_product_attribute.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  ProductDetailsItem productDetails = ProductDetailsItem.empty();
  RelatedProduct relatedProduct = RelatedProduct.empty();
  RxBool isReadMoreSelected = false.obs;
  List<ProductDetailsCategory> productDetailsCategories = [];
  List<ProductDetailsSubCategory> productDetailsSubCategories = [];
  List<String> galleryImages = [];
  List<Specification> specifications = [];
  List<dynamic> variants = [];
  List<RelatedProduct> relatedProducts = [];
  String productID = '';
  List<TextEditingController> couponControllers = [];
  ProductColor selectedColor = ProductColor();
  final PageController productImagePageController = PageController();
  Set<SelectedProductAttribute> selectedProductAttributes = {};
  List<CartDetailsProduct> cartProducts = [];
  StoreWiseCarts _cartsData = StoreWiseCarts.empty();
  StoreWiseCarts get cartsData => _cartsData;
  set cartsData(StoreWiseCarts value) {
    _cartsData = value;
    couponControllers =
        value.carts.map((e) => TextEditingController()).toList();
    update();
  }

  /* HtmlWidget get productText {
    final String about;
    return about =productDetails.description;
  } */
  RxBool showFullText = false.obs;

  /*  String get aboutProductText {
    final productSummery = Helper.setHTML(productDetails.description);
    if (isReadMoreSelected.value) {
      return productSummery;
    }
    return productSummery.length > 101
        ? productSummery.substring(0, 101)
        : productSummery;
  } */

  bool isProductAddedToCart(String productID) =>
      Helper.isProductAddedToCart(productID, cartProducts);

  CartDetailsProduct? get cartProduct =>
      Helper.getCartProduct(productID, cartProducts);

  bool get isProductVarianted => productDetails.variants.isNotEmpty;

  double get subtotalAmount => (productPrice * productDetails.productCount);

  double get totalExtraAmount => selectedProductAttributes.fold(
      0, (previousValue, element) => previousValue + element.option.price);

  double get totalAmount => subtotalAmount + totalExtraAmount;

  double get productPrice => productDetails.productPrice;

  // CartDetailsProduct? get getCartProduct => cartProducts.firstWhereOrNull((element) => element.product == productID);

  void onProductAttributeOptionSelected(
      ProductAttribute productAttribute, ProductAttributeOption? option) {
    productAttribute.selectedOption = option;
    if (option != null) {
      _addSelectedProductAttribute(productAttribute, option);
    }
    update();
  }

  void _addSelectedProductAttribute(
      ProductAttribute productAttribute, ProductAttributeOption option) {
    final newSelectedProductAttribute =
        SelectedProductAttribute(key: productAttribute.key, option: option);
    if (selectedProductAttributes
        .any((element) => element == newSelectedProductAttribute)) {
      selectedProductAttributes.remove(newSelectedProductAttribute);
    }
    selectedProductAttributes.add(
        SelectedProductAttribute(key: productAttribute.key, option: option));
  }

  void onPlusButtonTap() async {
    productDetails.productCount++;

    if (isProductAddedToCart(productDetails.id)) {
/*       await Helper.updateCart(CartProduct(
          product: productDetails.id,
          name: productDetails.name,
          store: productDetails.store.id,
          unit: productDetails.unit,
          categoryName:
              productDetails.productDetailsCategories.firstOrNull?.id ?? '',
          image: productDetails.productImage,
          price: productPrice,
          quantity: productDetails.productCount)); */
      if (cartProduct == null) {
        update();
        return;
      }
      await APIHelper.updateAProductFromCart(
          cartProduct!.cartId, cartProduct!.product,
          isIncrement: true);
    }
    update();
  }

  void onMinusButtonTap() async {
    if (productDetails.productCount > 1) {
      productDetails.productCount--;
      if (isProductAddedToCart(productDetails.id)) {
/*         await Helper.updateCart(CartProduct(
            product: productDetails.id,
            name: productDetails.name,
            store: productDetails.store.id,
            unit: productDetails.unit,
            categoryName:
                productDetails.productDetailsCategories.firstOrNull?.id ?? '',
            image: productDetails.productImage,
            price: productPrice,
            quantity: productDetails.productCount)); */
        if (cartProduct == null) {
          update();
          return;
        }
        await APIHelper.updateAProductFromCart(
            cartProduct!.cartId, cartProduct!.product,
            isIncrement: false);
      }
      update();
    }
  }

  void onRemoveFromCartButtonTap() async {
    // await Helper.removeFromCart(productDetails.id);
    // update();
    if (cartProduct == null) {
      return;
    }
    await APIHelper.removeAProductFromCart(cartProduct!.cartId);
    _getCartProducts();
  }

  void onAddToCartButtonTap() async {
/*     await Helper.addToCart(CartProduct(
        product: productDetails.id,
        name: productDetails.name,
        store: productDetails.store.id,
        unit: productDetails.unit,
        categoryName:
            productDetails.productDetailsCategories.firstOrNull?.id ?? '',
        image: productDetails.productImage,
        price: productDetails.currentPrice,
        quantity: productDetails.productCount));
    update(); */
    await APIHelper.addAProductToCart(productDetails.id,
        attributes: selectedProductAttributes.toList(),
        quantity: productDetails.productCount,
        storeID: productDetails.store.info.id,
        productLocation: productDetails.productLocation);
    _getCartProducts();
  }

  /*  void onBuyNowButtonTap() {
    // Go to delivery info screen
    Get.toNamed(AppPageNames.productsScreen);
  } */

  Future<void> _getProductDetails(String productId) async {
    ProductDetailsResponse? response =
        await APIRepo.getProductDetails(productId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetProductDetailsResponse(response);
  }

  void onAddProductTap(RelatedProduct product) {
    product.isFavorite = !product.isFavorite;
    update();
  }

  void onProductColorTap(ProductColor productColor) {
    selectedColor = productColor;
    update();
  }

  void _onSuccessGetProductDetailsResponse(ProductDetailsResponse response) {
    productDetails = response.data;
    productDetailsCategories = response.data.productDetailsCategories;
    productDetailsSubCategories = response.data.productDetailsSubCategories;
    galleryImages = response.data.galleryImages;
    specifications = response.data.specifications;
    variants = response.data.variants;
    relatedProducts = response.data.relatedProducts;
    if (isProductAddedToCart(productDetails.id)) {
      productDetails.productCount =
          // Helper.getCartByID(productDetails.id)?.quantity ?? 0;
          cartProduct?.quantity ?? 1;
    }
    update();
  }

  Future<void> onProductBuyNowTap(String productId, int quantity,
      String storeId1, ProductDetailsLocation productLocation) async {
    await clearCart();
    await APIHelper.addAProductToCart(
        snackbar: false,
        makeAnOffer: false,
        productId,
        quantity: quantity,
        storeID: storeId1,
        productLocation: productLocation);
    await getCarts();
    await checkout(cartsData);
    /*  await Get.toNamed(
      AppPageNames.shipping1stScreen,
    ); */
  }

  Future<void> checkout(StoreWiseCarts data) async {
    final response = await APIRepo.checkout(cartsData.toJson());
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    await Get.toNamed(AppPageNames.shipping1stScreen);
  }

  Future<void> clearCart() async {
    final response = await APIRepo.clearCart();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
  }

  CartDetailsProduct? getCartProduct(String productID) =>
      Helper.getCartProduct(productID, cartProducts);

  void onProductAddTap(RelatedProduct product) async {
    final isAddedToCart = isProductAddedToCart(product.id);
    if (isAddedToCart) {
      final cartProduct = getCartProduct(product.id);
      if (cartProduct == null) {
        update();
        return;
      }
      await APIHelper.removeAProductFromCart(cartProduct.cartId);
      await _getCartProducts();
      update();
      return;
    }
    await APIHelper.addAProductToCart(product.id,
        storeID: product.store.id, productLocation: product.productLocation);
    await _getCartProducts();
    update();
  }

  Future<void> getCarts() async {
    final cartsResponse = await APIHelper.getStoreWiseCarts();
    if (cartsResponse == null) {
      return;
    }
    cartsData = cartsResponse.data;
  }

  Future<void> _getCartProducts() async {
    final CartsResponse? cartsResponse = await APIHelper.getCarts();
    if (cartsResponse != null) {
      final List<CartDetailsProduct> products =
          cartsResponse.data.cart.products;
      cartProducts = products;
      update();
    }
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      productID = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    _getCartProducts();
    _getProductDetails(productID);
    super.onInit();
  }
}
