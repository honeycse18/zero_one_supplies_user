import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/models/api_responses/single_brand_by_id_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopBrandScreenController extends GetxController {
  String brandId = '';
  SingleBrandDataResponse theBrand = SingleBrandDataResponse.empty();
  final PagingController<int, ProductShortItem> productsPagingController =
      PagingController(firstPageKey: 1);
  List<CartDetailsProduct> cartProducts = [];

// Add Everywhere when we need to toggle add to favorite list  -- Start
  toggleAddToFavorite(String id) {
    toggleAddFav(id);
  }

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
    log(response.msg);
  }

// Add Everywhere when we need to toggle add to favorite list  -- End

  Future<void> getTopBrands() async {
    SingleBrandByIdResponse? response = await APIRepo.getTopBrand(brandId);
    if (response == null) {
      onErrorGetTopBrands(response);
      return;
    } else if (response.error) {
      onFailureGetTopBrands(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetTopBrands(response);
  }

  void onErrorGetTopBrands(SingleBrandByIdResponse? response) {
    AppDialogs.showErrorDialog(
        messageText:
            AppLanguageTranslation.brandDataNotFoundTransKey.toCurrentLanguage);
  }

  void onFailureGetTopBrands(SingleBrandByIdResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onSuccessGetTopBrands(SingleBrandByIdResponse response) {
    theBrand = response.data;
    update();
  }

  Future<void> getProductsOfBrand(int currentPageNumber) async {
    ProductPageResponse? response = await APIRepo.getProductsUnderCriteria(
        currentPageNumber, '',
        brandId: brandId);
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
    onSuccessRetrievingProductListResponse(response);
  }

  onSuccessRetrievingProductListResponse(ProductPageResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      productsPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    productsPagingController.appendPage(response.data.docs, nextPageNumber);
  }

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
    }
    await APIHelper.addAProductToCart(product.id,
        storeID: product.store.id, productLocation: product.productLocation);
    await _getCartProducts();
    update();
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

  bool isProductAddedToCart(String productID) =>
      Helper.isProductAddedToCart(productID, cartProducts);
  CartDetailsProduct? getCartProduct(String productID) =>
      Helper.getCartProduct(productID, cartProducts);

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      brandId = argument;
    }
  }

  void refreshData() {
    getTopBrands();
    _getCartProducts();
  }

  @override
  void onInit() {
    _getScreenParameters();
    refreshData();
    productsPagingController.addPageRequestListener((pageKey) {
      getProductsOfBrand(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    productsPagingController.dispose();
    super.onClose();
  }
}
