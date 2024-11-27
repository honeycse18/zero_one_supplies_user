import 'dart:developer';

import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/api_responses/send_an_offer_list_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SendOfferListScreenScreenController extends GetxController {
  List<TextEditingController> couponControllers = [];

  StoreWiseCarts _cartsData = StoreWiseCarts.empty();
  StoreWiseCarts get cartsData => _cartsData;
  set cartsData(StoreWiseCarts value) {
    _cartsData = value;
    couponControllers =
        value.carts.map((e) => TextEditingController()).toList();
    update();
  }

  final PagingController<int, SendOfferListItem> sendOffersPagingController =
      PagingController(firstPageKey: 1);

  SendOfferListItem sendOfferListItem = SendOfferListItem.empty();

  Future<void> getSendOfferList(int currentPageNumber) async {
    SendAnOfferListResponse? response =
        await APIRepo.getSendOfferList(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onError(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetEndingSoon(response);
  }

  void onErrorGetEndingSoon(SendAnOfferListResponse? response) {
    sendOffersPagingController.error = response;
  }

  void onFailureGetOnErrorGetEndingSoon(SendAnOfferListResponse response) {
    sendOffersPagingController.error = response;
  }

  void onSuccessGetEndingSoon(SendAnOfferListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      sendOffersPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    sendOffersPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  Future<void> onBuyNowTap(String offerId, String productId, int quantity,
      String storeId1, ProductDetailsLocation productLocation) async {
    await clearCart();
    await APIHelper.addAProductToCart(
        snackbar: false,
        makeAnOffer: true,
        quantity: quantity,
        productId,
        storeID: storeId1,
        productLocation: productLocation);
    await getCarts();
    await checkout(cartsData, offerId);
  }

  Future<void> checkout(StoreWiseCarts data, String offerId) async {
    final response = await APIRepo.checkout(cartsData.toJson());
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    await clearOfferItem(offerId);
    await Get.toNamed(AppPageNames.shipping1stScreen);
  }

  Future<void> getCarts() async {
    final cartsResponse = await APIHelper.getStoreWiseCarts();
    if (cartsResponse == null) {
      return;
    }
    cartsData = cartsResponse.data;
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

  Future<void> clearOfferItem(String offerId) async {
    final response = await APIRepo.clearOfferItem(offerId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
  }

  @override
  void onInit() {
    sendOffersPagingController.addPageRequestListener((pageKey) {
      getSendOfferList(pageKey);
    });
    super.onInit();
  }
}
