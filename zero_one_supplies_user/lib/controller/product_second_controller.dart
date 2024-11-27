import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/models/fake_models/category_items.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductSecondScreenController extends GetxController {
  String childrenId = '';
  String childrenName = 'No Name';
  List<CartDetailsProduct> cartProducts = [];

  CartDetailsProduct? getCartProduct(String productID) =>
      Helper.getCartProduct(productID, cartProducts);

// Add Everywhere when we need to toggle add to favorite list  -- Start

  bool isProductAddedToCart(String productID) =>
      Helper.isProductAddedToCart(productID, cartProducts);

  void toggleAddToFavorite(String id) {
    toggleAddFav(id);
  }

  TextEditingController searchTextEditingController = TextEditingController();
  Future<void> toggleAddFav(String id) async {
    final Map<String, dynamic> requestBody = {'product': id};
    String requestBodyJson = jsonEncode(requestBody);
    ToggleAddToFavoriteResponse? response =
        await APIRepo.toggleAddToFav(requestBodyJson);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingResponse(response);
  }

  onSuccessGettingResponse(ToggleAddToFavoriteResponse response) {
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

// Add Everywhere when we need to toggle add to favorite list  -- End
  final CategoryItems category =
      CategoryItems(name: '', image: '', totalCount: 0);

  final PagingController<int, ProductShortItem> productPagingController =
      PagingController(firstPageKey: 1);

  void onProductAddTap(ProductShortItem product) async {
    final isAddedToCart = isProductAddedToCart(product.id);
    if (isAddedToCart) {
      // Helper.removeFromCart(product.id);
      final cartProduct = getCartProduct(product.id);
      if (cartProduct == null) {
        update();
        return;
      }
      await APIHelper.removeAProductFromCart(cartProduct.cartId);
      await _getCartProducts();
      update();
      return;
      // await APIHelper.updateAProductFromCart(getCartProduct(product.id)!.cartId,
      //     getCartProduct(product.id)!.product,
      //     isIncrement: true);
      // update();
      // return;
    }
/*     Helper.addToCart(CartProduct(
        product: product.id,
        name: product.name,
        categoryName: ' ',
        image: product.image,
        price: product.currentPrice,
        quantity: 1,
        store: product.store.id)); */
    await APIHelper.addAProductToCart(product.id,
        storeID: product.store.id, productLocation: product.productLocation);
    await _getCartProducts();
    update();
  }

  Future<void> getProducts(int currentPageNumber) async {
    ProductPageResponse? response = await APIRepo.getProductsUnderCriteria(
      currentPageNumber,
      searchTextEditingController.text,
      childCategory: childrenId,
    );
    if (response == null) {
      onErrorGetProducts(response);
      return;
    } else if (response.error) {
      onFailureGetProducts(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetProducts(response);
  }

  void onErrorGetProducts(ProductPageResponse? response) {
    productPagingController.error = response;
  }

  void onFailureGetProducts(ProductPageResponse response) {
    productPagingController.error = response;
  }

  void onSuccessGetProducts(ProductPageResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      productPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    productPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void onChange(String text) {
    productPagingController.refresh();
  }

  _getScreenParameters() {
    final parameters = Get.arguments;
    if (parameters is Map) {
      childrenId = parameters['id'];
      childrenName = parameters['name'];
    }
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

  @override
  void onInit() {
    _getScreenParameters();
    _getCartProducts();
    productPagingController.addPageRequestListener((pageKey) {
      getProducts(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    productPagingController.dispose();
    searchTextEditingController.dispose();
    super.onClose();
  }
}
