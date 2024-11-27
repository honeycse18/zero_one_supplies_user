import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/auction_product_details_response.dart';
// import 'package:ecomik/models/api_responses/bid_details_response.dart';
import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/dialog_Parameters/auction_bid_dialouge_parameters.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/bottom_modal_sheets_widget/auction_filture_widget.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BidDetailsScreenController extends GetxController {
  TextEditingController bidAmountController = TextEditingController();
  final PageController productImagePageController = PageController();
  AuctionProductDetails bidDetails = AuctionProductDetails.empty();
  List<BidDetailsBidUser> bidUsers = const [];
  List<TextEditingController> couponControllers = [];
  int productCount = 1;
  bool isProductInList = false;

  UserDetails user = UserDetails.empty();
  StoreWiseCarts _cartsData = StoreWiseCarts.empty();
  StoreWiseCarts get cartsData => _cartsData;
  set cartsData(StoreWiseCarts value) {
    _cartsData = value;
    couponControllers =
        value.carts.map((e) => TextEditingController()).toList();
    update();
  }

  String bidProductID = '';
  IO.Socket socket = IO.io(
      Constants.appBaseURL,
      IO.OptionBuilder()
          .setAuth({'token': Helper.getUserToken()}).setTransports(
              ['websocket']).build());

  webSocket() {
    // Dart client
    socket.onConnect((_) {
      log('connect');
      socket.emit('msg', 'test');
    });
    socket.on('bid', (data) {
      getBidDetails(bidDetails.id);
    });
    socket.onDisconnect((_) => log('disconnect'));
  }

  void onVisitStoreButtonTap() {
    Get.toNamed(AppPageNames.sellerSingleScreenPage,
        arguments: bidDetails.store.info.id);
  }

  Future<void> onProductBuyNowTap(String productId, int quantity,
      String storeId1, ProductDetailsLocation productLocation) async {
    // await clearCart();
    await APIHelper.addAProductToCart(
        snackbar: false,
        makeAnOffer: false,
        isAuction: true,
        auction: productId,
        productId,
        quantity: quantity,
        storeID: storeId1,
        productLocation: productLocation);
    await Get.snackbar('Added to cart', 'Added to cart');
    await getCarts();
    // await checkout(cartsData);
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

  Future<void> getCarts() async {
    final cartsResponse = await APIHelper.getStoreWiseCarts();
    if (cartsResponse == null) {
      return;
    }
    cartsData = cartsResponse.data;
    isProductInList = cartsData.cartProducts
        .any((element) => element.product == bidDetails.id);
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

  void onBidNowButtonTap() async {
    await Get.bottomSheet(const ApplyBidScreenWidget(),
        isScrollControlled: true,
        settings: RouteSettings(
            arguments: AuctionBidsDialogParameters(
                id: bidProductID,
                applyBid: bidDetails.auctionInfo.currentPrice)));

    getBidDetails(bidDetails.id);
  }

  Future<void> getBidDetails(String id) async {
    AuctionProductDetailsResponse? response =
        await APIRepo.fetchAuctionDetails(id);
    if (response == null) {
      onErrorGetBidDetails(response);
      return;
    } else if (response.error) {
      onFailureGetBidDetails(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetBidDetails(response);
  }

  void onErrorGetBidDetails(AuctionProductDetailsResponse? response) {}

  void onFailureGetBidDetails(AuctionProductDetailsResponse response) {}

  void onSuccessGetBidDetails(AuctionProductDetailsResponse response) {
    bidDetails = response.data;
    bidUsers = response.data.auctionInfo.bidUsers;
    update();
  }

  Future<void> applyBid(double amount) async {
    final Map<String, Object> requestBody = {
      '_id': bidProductID,
      'bid_amount': amount
    };
    final requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.applyBid(requestBodyJson);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessApplyBid(response);
  }

  void onSuccessApplyBid(RawAPIResponse response) {
    AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.yourBidUpdatedTransKey.toCurrentLanguage);
  }

  String? nameFormValidator(String? name) {
    if (name != null) {
      if (name.isEmpty) {
        return AppLanguageTranslation.canNotBeEmptyTransKey.toCurrentLanguage;
      }
    }
    return null;
  }

  void _getScreenParameter() {
    dynamic argument = Get.arguments;
    if (argument is String) {
      bidProductID = argument;
    }
  }

  @override
  void onInit() {
    user = Helper.getUser();
    _getScreenParameter();
    getBidDetails(bidProductID);
    webSocket();
    if (Helper.isUserLoggedIn()) {
      getCarts();
    }
    // bidAmountController.text
    super.onInit();
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.onClose();
  }
}
