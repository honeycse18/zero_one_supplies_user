import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/categories_response.dart';
import 'package:ecomik/models/api_responses/mixed_product_auction_response.dart';
import 'package:ecomik/models/api_responses/product_tag.dart';
import 'package:ecomik/models/api_responses/products_with_tags_response.dart';
import 'package:ecomik/models/api_responses/subcategory_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/models/bottom_sheet_parameters/auction_bid_filter_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductPageController extends GetxController {
  AuctionBidFilterParameter filterOptions = AuctionBidFilterParameter.empty();
  String preSelectedCategoryID = '';
  GlobalKey<ScaffoldState> productPageScaffoldKey = GlobalKey();
  List<CartDetailsProduct> cartProducts = [];
  bool _isNormalMode = true;
  bool get isNormalMode => _isNormalMode;
  set isNormalMode(bool value) {
    _isNormalMode = value;
    update();
  }

  RangeValues currentRangeValues = const RangeValues(0, 100000);

  toggleAddToFavorite(String id, [bool isAuction = false]) {
    toggleAddFav(id, isAuction);
  }

  void onAuctionItemWishListTap(MixedAuctionProductItem auction) {
    auction.isFavorite = !auction.isFavorite;
    update();
  }

// Add Everywhere when we need to toggle add to favorite list  -- Start
  TextEditingController searchTextEditingController = TextEditingController();
  Future<void> toggleAddFav(String id, [bool isAuction = false]) async {
    final Map<String, dynamic> requestBody = {
      'product': id,
      'isAuction': isAuction
    };
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

  final PagingController<int, MixedAuctionProductItem>
      normalProductPagingController = PagingController(firstPageKey: 1);

  final PagingController<int, ProductsAndTags> productsAndTagsPagingController =
      PagingController(firstPageKey: 1);

  void setFilterOptions(AuctionBidFilterParameter options) {
    filterOptions = options;
    update();
    refreshProducts();
  }

  void applyFilters() {
    productPageScaffoldKey.currentState?.closeDrawer();
    _checkAnyFilterSelected();
    update();
    refreshProducts();
  }

  void _checkAnyFilterSelected() {
    if (selectedOptions.value == 'lowToHigh' ||
        selectedOptions.value == 'highToLow' ||
        selectedOptions.value == 'a2z' ||
        selectedOptions.value == 'z2a') {
      isNormalMode = true;
    } else {
      isNormalMode = false;
    }
    if (isNormalMode) {
      return;
    }
    isNormalMode = selectedCategoryOption.id.isNotEmpty;
    if (isNormalMode) {
      return;
    }
    isNormalMode = selectedSubCategoryOption.id.isNotEmpty;
    if (isNormalMode) {
      return;
    }
    if (currentRangeValues.start == 0 && currentRangeValues.end == 100000) {
      isNormalMode = false;
    } else {
      isNormalMode = true;
    }
    if (isNormalMode) {
      return;
    }
    isNormalMode = searchTextEditingController.text.isNotEmpty;
    if (isNormalMode) {
      return;
    }
  }

  void refreshProducts() {
    normalProductPagingController.refresh();
  }

  void toggleSelectedRange(RangeValues theRange) {
    currentRangeValues = theRange;
    filterOptions.selectedRangeValues = theRange;
    update();
  }

  bool isProductAddedToCart(String productID) =>
      Helper.isProductAddedToCart(productID, cartProducts);

/*   void onProductAddTap(ProductShortItem product) async {
    final isAddedToCart = isProductAddedToCart(product.id);
    if (isAddedToCart) {
      CartDetailsProduct? cartProduct =
          Helper.getCartProduct(product.id, cartProducts);
      if (cartProduct == null) {
        update();
        return;
      }
      await APIHelper.removeAProductFromCart(cartProduct.cartId);
      await _getCartProducts();
      update();
      return;
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
  } */
  void onProductAddTap(MixedAuctionProductItem product) async {
    final isAddedToCart = isProductAddedToCart(product.id);
    if (isAddedToCart) {
      CartDetailsProduct? cartProduct =
          Helper.getCartProduct(product.id, cartProducts);
      if (cartProduct == null) {
        update();
        return;
      }
      await APIHelper.removeAProductFromCart(cartProduct.cartId);
      await _getCartProducts();
      update();
      return;
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
    ProductAuctionMixedResponse? response = await APIRepo.getProducts(
        currentPageNumber, searchTextEditingController.text,
        filterOptions: filterOptions);
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

  void onErrorGetProducts(ProductAuctionMixedResponse? response) {
    normalProductPagingController.error = response;
  }

  void onFailureGetProducts(ProductAuctionMixedResponse response) {
    normalProductPagingController.error = response;
  }

  void onSuccessGetProducts(ProductAuctionMixedResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      normalProductPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    normalProductPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  Future<void> getProductsWithTags(int currentPageNumber) async {
    final ProductsWithTagsResponse? response =
        await APIRepo.getProductsWithTags(currentPageNumber);
    if (response == null) {
      productsAndTagsPagingController.error = response;
      return;
    } else if (response.error) {
      productsAndTagsPagingController.error = response;
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetProductsWithTags(response);
  }

  void onSuccessGetProductsWithTags(ProductsWithTagsResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      productsAndTagsPagingController
          .appendLastPage([response.data.productsAndTags]);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    productsAndTagsPagingController
        .appendPage([response.data.productsAndTags], nextPageNumber);
  }

  /*  void onFlashSellItemWishListTap(ProductShortItem flashSell) {
    flashSell.isFavorite = !flashSell.isFavorite;
    update();
  } */
  void onFlashSellItemWishListTap(MixedAuctionProductItem flashSell) {
    flashSell.isFavorite = !flashSell.isFavorite;
    update();
  }

  void onChange(String text) {
    isNormalMode = (searchTextEditingController.text.isNotEmpty);
    update();
    normalProductPagingController.refresh();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is String) {
      preSelectedCategoryID = argument;
      filterOptions.selectedCategoryOption = CategoryDocResponse(
          id: preSelectedCategoryID,
          createdAt: AppComponents.defaultUnsetDateTime,
          updatedAt: AppComponents.defaultUnsetDateTime);
    }
  }

  List<CategoryDocResponse> categories = const [];
  List<ProductTag> tags = [];
  List<SubcategoryDocResponse> subCategories = const [];
  // AuctionBidFilterParameter filterOptions = AuctionBidFilterParameter.empty();
  CategoryDocResponse selectedCategoryOption = CategoryDocResponse.empty();
  SubcategoryDocResponse selectedSubCategoryOption =
      SubcategoryDocResponse.empty();
  RxString selectedOptions = ''.obs;
  // ProductTag selectedTag = ProductTag.empty();
  String preselectedCategoryID = '';
  /*  RxList<String> selectedOptions = <String>[].obs;

  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  } */

  void clearAllButtonTap() {
    selectedOptions.value = '';
    selectedCategoryOption = CategoryDocResponse.empty();
    selectedSubCategoryOption = SubcategoryDocResponse.empty();
    filterOptions = AuctionBidFilterParameter.empty();
    currentRangeValues = const RangeValues(0, 100000);
    applyFilters();
    update();
  }

  void toggleTag(ProductTag tag, bool isSelected) {
    if (isSelected) {
      // selectedTag = tag;
      searchTextEditingController.text = tag.name;
    } else {
      // selectedTag = ProductTag.empty();
      searchTextEditingController.clear();
    }
    normalProductPagingController.refresh();
    update();
  }

  void toggleInnerTag(ProductsAndTags tag, bool isSelected, int index) {
    if (isSelected) {
      tag.selectedTagIndex = index;
    } else {
      tag.selectedTagIndex = -1;
    }
    update();
  }

  void toggleOption(String option) {
    selectedOptions.value = option;
    filterOptions.selectedOptions = selectedOptions.value;
  }

  void toggleCategoryOption(CategoryDocResponse option) {
    selectedCategoryOption = option;
    filterOptions.selectedCategoryOption = selectedCategoryOption;
    selectedSubCategoryOption = SubcategoryDocResponse.empty();
    getSubCats(1, selectedCategoryOption.id);
    update();
  }

  void toggleSubCategoryOption(SubcategoryDocResponse option) {
    selectedSubCategoryOption = option;
    filterOptions.selectedSubCategoryOption = selectedSubCategoryOption;
    update();
  }

  Future<void> getCategories(int currentPageNumber) async {
    CategoriesResponse? response =
        await APIRepo.getCategoriesAPICall(currentPageNumber, size: 50);
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
    _onSuccessRetrievingResponse(response);
  }

  _onSuccessRetrievingResponse(CategoriesResponse response) {
    categories = response.data.docs;
    if (preselectedCategoryID.isNotEmpty) {
      final foundCategory = categories
          .firstWhereOrNull((category) => category.id == preselectedCategoryID);
      if (foundCategory != null) {
        toggleCategoryOption(foundCategory);
      }
    }
    update();
  }

  Future<void> getTags(int currentPageNumber) async {
    final ProductTagResponse? response =
        await APIRepo.getTagsAPICall(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetTags(response);
  }

  void _onSuccessGetTags(ProductTagResponse response) {
    final isFirstPage = response.data.page == 1;
    if (isFirstPage) {
      tags.clear();
    }
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      tags.addAll(response.data.docs);
      update();
      return;
    }
    tags.addAll(response.data.docs);
    update();
    final nextPageNumber = response.data.page + 1;
    getTags(nextPageNumber);
  }

  Future<void> getSubCats(int currentPageNumber, String id) async {
    SubcategoryResponse? response =
        await APIRepo.getSubcategoriesAPICall(currentPageNumber, id, size: 50);
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
    onSuccessRetrievingSubcategories(response);
  }

  onSuccessRetrievingSubcategories(SubcategoryResponse response) {
    subCategories = response.data.docs;
    update();
  }

/*   void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is AuctionBidFilterParameter) {
      preselectedCategoryID = argument.selectedCategoryOption.id;
    }
  } */

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
    _getScreenParameter();
    _getCartProducts();
    isNormalMode = false;
    normalProductPagingController.addPageRequestListener((pageKey) {
      getProducts(pageKey);
    });
    productsAndTagsPagingController.addPageRequestListener((pageKey) {
      getProductsWithTags(pageKey);
    });
    getCategories(1);
    getTags(1);
    super.onInit();
  }

  @override
  void onClose() {
    normalProductPagingController.dispose();
    productsAndTagsPagingController.dispose();
    searchTextEditingController.dispose();
    super.onClose();
  }
}
