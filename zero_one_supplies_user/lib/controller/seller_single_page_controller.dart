import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/models/api_responses/single_seller_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SellerSingleScreenController extends GetxController {
  String get averageRating => theSeller.rating.avgRating.toStringAsFixed(1);
  String sellerId = '';
  SingleSellerDataResponse theSeller = SingleSellerDataResponse.empty();
  final PagingController<int, ProductShortItem>
      productsOfSellerPagingController = PagingController(firstPageKey: 1);
  int value = 1;
  List<CartDetailsProduct> cartProducts = [];
// List<String> tags = [];
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];
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
              AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
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

  bool isProductAddedToCart(String productID) =>
      Helper.isProductAddedToCart(productID, cartProducts);
// Add Everywhere when we need to toggle add to favorite list  -- End

  Future<void> getSellerDetails(String id) async {
    SingleSellerResponse? response = await APIRepo.getSingleSeller(id);
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
    onSuccessRetrievingSellerResponse(response);
  }

  onSuccessRetrievingSellerResponse(SingleSellerResponse response) {
    theSeller = response.data;
    update();
  }

  Future<void> getProductsOfSeller(int currentPageNumber) async {
    ProductPageResponse? response = await APIRepo.getProductsUnderStore(
        currentPageNumber,
        sellerId: sellerId);
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
    onSuccessRetrievingProductsResponse(response);
  }

  onSuccessRetrievingProductsResponse(ProductPageResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      productsOfSellerPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    productsOfSellerPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  CartDetailsProduct? getCartProduct(String productID) =>
      Helper.getCartProduct(productID, cartProducts);

  void onProductAddTap(ProductShortItem product) async {
    final isAddedToCart = isProductAddedToCart(product.id);
    if (isAddedToCart) {
      // Helper.removeFromCart(product.id);
      CartDetailsProduct? cartProduct = getCartProduct(product.id);
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
/*     Helper.addToCart(CartProduct(
        product: product.id,
        name: product.name,
        categoryName: product.category.name,
        image: product.image,
        price: product.currentPrice,
        quantity: 1,
        store: product.store.id)); */
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

  _getScreenParameters() {
    final arguments = Get.arguments;
    if (arguments is String) {
      sellerId = arguments;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    _getCartProducts();
    getSellerDetails(sellerId);
    productsOfSellerPagingController.addPageRequestListener((pageKey) {
      getProductsOfSeller(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    productsOfSellerPagingController.dispose();
    super.onClose();
  }
}
