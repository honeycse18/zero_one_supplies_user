import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomik/models/api_responses/auctions_response.dart';
import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/dash_board_response.dart';
import 'package:ecomik/models/api_responses/home_auction_response.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/bottom_sheet_parameters/auction_bid_filter_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreenController extends GetxController {
  List<Category> categories = [];
  List<AuctionProduct> auctionProducts = [];
  List<FlashSell> flashSell = [];
  List<TopBrand> topBrands = [];
  List<PopularProduct> popularProducts = [];
  List<TopSeller> topSeller = [];
  List<AuctionProduct> endingSoon = [];
  List<DashboardSlider> sliders = [];
  TextEditingController searchTextEditingController = TextEditingController();
  List<DashBoardCouponResponse> coupons = [];
  RxBool isLoading = false.obs;
  final PageController pageController = PageController(keepPage: false);
  final PageController couponPageController = PageController(keepPage: false);
  Timer timer = Timer(const Duration(seconds: 1), () {});
  Timer couponTimer = Timer(const Duration(seconds: 1), () {});
  List<CartDetailsProduct> cartProducts = [];
  final PagingController<int, ProductShortItem> productPagingController =
      PagingController(firstPageKey: 1);

  List<HomeAuctionShortItem> auctionList = [];
  List<HomeAuctionShortItem> endAuctionList = [];

  Future<void> onRefresh() async {
    for (final slider in sliders) {
      await CachedNetworkImage.evictFromCache(slider.image);
    }
    await getDashBoardResponse();
    await getCartProducts();
  }

  Future<void> getAuctions() async {
    HomeAuctionsResponse? response = await APIRepo.getHomeAuctions(
      searchTextEditingController.text,
    );
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetAuctions(response);
  }

  void onSuccessGetAuctions(HomeAuctionsResponse response) {
    auctionList = response.data;
    update();
  }

  Future<void> getEndingAuctions() async {
    HomeAuctionsResponse? response = await APIRepo.getEndingHomeAuctions(
      searchTextEditingController.text,
    );
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetEndAuctions(response);
  }

  void onSuccessGetEndAuctions(HomeAuctionsResponse response) {
    endAuctionList = response.data;
    update();
  }

  Future<void> getProducts(int currentPageNumber) async {
    ProductPageResponse? response = await APIRepo.getSimpleProducts(
        currentPageNumber, '',
        filterOptions: AuctionBidFilterParameter.empty());
    if (response == null) {
      productPagingController.error = response;
      return;
    } else if (response.error) {
      productPagingController.error = response;
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetProducts(response);
  }

  void _onSuccessGetProducts(ProductPageResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      productPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    productPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void onDashboardSliderItemTap(DashboardSlider slider) {
    // Helper.showSnackBar( dashboardFakeSlider.categoryImage.toString().substring(0, 20));
    Get.toNamed(AppPageNames.productPage, arguments: slider.category);
  }

  void copyToClipBoard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    Helper.showSnackBar(
        AppLanguageTranslation.couponCodeCopiedTransKey.toCurrentLanguage);
  }

// Add Everywhere when we need to toggle add to favorite list  -- Start
  toggleAddToFavorite(String id, [bool isAuction = false]) {
    toggleAddFav(id, isAuction);
  }

  void onBidTap(HomeAuctionShortItem bid) {
    Get.toNamed(AppPageNames.bidDetails, arguments: bid.id);
  }

  void onBidFavoriteButtonTap(HomeAuctionShortItem bid) {
    toggleAddToFavorite(bid.id, true);
    onAuctionProductWishListTap(bid);
  }

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
    log(response.msg);
  }

// Add Everywhere when we need to toggle add to favorite list  -- End

  void onFlashSellProductAddTap(FlashSell product) async {
    final isAddedToCart = isProductAddedToCart(product.id);
    if (isAddedToCart) {
      // Helper.removeFromCart(product.id);
      CartDetailsProduct? cartProduct = getCartProduct(product.id);
      if (cartProduct == null) {
        update();
        return;
      }
      await APIHelper.removeAProductFromCart(cartProduct.cartId);
      await getCartProducts();
      update();
      return;
    }
    await APIHelper.addAProductToCart(product.id,
        storeID: product.store.id, productLocation: product.productLocation);
    await getCartProducts();
    update();
  }

  void onPopularProductAddTap(PopularProduct product) async {
    final isAddedToCart = isProductAddedToCart(product.id);
    if (isAddedToCart) {
      // Helper.removeFromCart(product.id);
      CartDetailsProduct? cartProduct = getCartProduct(product.id);
      if (cartProduct == null) {
        update();
        return;
      }
      await APIHelper.removeAProductFromCart(cartProduct.cartId);
      await getCartProducts();
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
    await getCartProducts();
    update();
  }

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
      await getCartProducts();
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
    await getCartProducts();
    update();
  }

  Future<void> getDashBoardResponse() async {
    isLoading.value = true;
    DashBoardResponse? response = await APIRepo.getDashBoardResponse();
    isLoading.value = false;
    if (response == null) {
      onErrorGetDashBoardResponse(response);
      return;
    } else if (response.error) {
      onFailureGetDashBoardResponse(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetDashBoardResponse(response);
  }

  void onErrorGetDashBoardResponse(DashBoardResponse? response) {}

  void onFailureGetDashBoardResponse(DashBoardResponse response) {}
  void onSuccessGetDashBoardResponse(DashBoardResponse response) {
    auctionProducts = response.data.auctionProducts;
    categories = response.data.categories;
    flashSell = response.data.flashSell;
    endingSoon = response.data.endingSoon;
    topBrands = response.data.topBrands;
    popularProducts = response.data.popularProducts;
    topSeller = response.data.topSeller;
    coupons = response.data.coupons;
    sliders = response.data.sliders;
    update();
  }

  void onAuctionProductWishListTap(HomeAuctionShortItem auction) {
    auction.isWishListed = !auction.isWishListed;
    update();
  }

  void onFlashProductWishListTap(FlashSell product) {
    product.isWishListed = !product.isWishListed;
    update();
  }

  void onPopularProductWishListTap(PopularProduct product) {
    product.isWishListed = !product.isWishListed;
    update();
  }

  void gotoSignInScreen([bool canGoBack = false]) {
    Helper.showSnackBar(AppLanguageTranslation
        .sessionExpiredPleaseLoginTransKey.toCurrentLanguage);
    if (canGoBack) {
      Get.toNamed(AppPageNames.signInScreen, arguments: true);
    } else {
      Get.offAllNamed(AppPageNames.signInScreen, arguments: true);
    }
  }

  void slideNextCouponCarousel() {
    if (coupons.isEmpty) {
      return;
    }
    if (!couponPageController.hasClients) {
      return;
    }
    if (couponPageController.page == coupons.length - 1) {
      couponPageController.animateToPage(0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
      return;
    }
    // Goto next intro section
    couponPageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  void slideNextCarousel() {
    if (sliders.isEmpty) {
      return;
    }
    if (!pageController.hasClients) {
      return;
    }
    if (pageController.page == sliders.length - 1) {
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn);
      return;
    }
    // Goto next intro section
    pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    onSuccessGetLoggedInUserDetails(response);
  }

  void onErrorGetLoggedInUserDetails(UserDetailsResponse? response) {
    gotoSignInScreen();
  }

  void onFailureGetLoggedInUserDetails(UserDetailsResponse response) {
    gotoSignInScreen();
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
  }

  bool isProductAddedToCart(String productID) =>
      Helper.isProductAddedToCart(productID, cartProducts);

  CartDetailsProduct? getCartProduct(String productID) =>
      Helper.getCartProduct(productID, cartProducts);

  Future<void> getCartProducts() async {
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
    getAuctions();
    getEndingAuctions();
    // Verify token
    // getLoggedInUserDetails();
    if (Helper.isUserLoggedIn()) {
      getCartProducts();
    }
    getDashBoardResponse();
    timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      slideNextCarousel();
    });
    couponTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      slideNextCouponCarousel();
    });
    productPagingController.addPageRequestListener((pageKey) {
      getProducts(pageKey);
    });

    super.onInit();
  }

  @override
  void onClose() {
    if (timer.isActive) {
      timer.cancel();
    }
    if (couponTimer.isActive) {
      couponTimer.cancel();
    }
    pageController.dispose();
    couponPageController.dispose();
    super.onClose();
  }
}
