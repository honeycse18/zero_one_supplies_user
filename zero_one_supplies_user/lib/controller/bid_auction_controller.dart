import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/active_auction_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/models/api_responses/won_auction_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BidAuctionScreenController extends GetxController {
  final PageController productImagePageController = PageController();
  RxBool isActiveSelected = true.obs;

  toggleAddToFavorite(String id, [bool isAuction = false]) {
    toggleAddFav(id, isAuction);
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

  final PagingController<int, ActiveAuctionShortItem>
      activeAuctionsPagingController = PagingController(firstPageKey: 1);
  final PagingController<int, WonAuctionShortItem> wonAuctionsPagingController =
      PagingController(firstPageKey: 1);

// Add Everywhere when we need to toggle add to favorite list  -- End

  Future<void> getActiveAuctions(int currentPageNumber) async {
    ActiveAuctionResponse? response =
        await APIRepo.getActiveAuctions(currentPageNumber);
    if (response == null) {
      onErrorGetActiveAuctions(response);
      return;
    } else if (response.error) {
      onFailureGetActiveAuctions(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetActiveAuctions(response);
  }

  void onErrorGetActiveAuctions(ActiveAuctionResponse? response) {
    activeAuctionsPagingController.error = response;
  }

  void onFailureGetActiveAuctions(ActiveAuctionResponse response) {
    activeAuctionsPagingController.error = response;
  }

  void onActiveAuctionItemWishListTap(ActiveAuctionShortItem activeAuction) {
    activeAuction.isFavorite = !activeAuction.isFavorite;
    update();
  }

  void onSuccessGetActiveAuctions(ActiveAuctionResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      activeAuctionsPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    activeAuctionsPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  Future<void> getWonAuctions(int currentPageNumber) async {
    WonAuctionResponse? response =
        await APIRepo.getWonAuctions(currentPageNumber);
    if (response == null) {
      onErrorGetWonAuctions(response);
      return;
    } else if (response.error) {
      onFailureGetWonAuctions(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetWonAuctions(response);
  }

  void onErrorGetWonAuctions(WonAuctionResponse? response) {
    wonAuctionsPagingController.error = response;
  }

  void onFailureGetWonAuctions(WonAuctionResponse response) {
    wonAuctionsPagingController.error = response;
  }

  void onWonAuctionItemWishListTap(WonAuctionShortItem wonAuction) {
    wonAuction.isFavorite = !wonAuction.isFavorite;
    update();
  }

/*   void onAuctionItemWishListTap(ActiveAuctionResponse auction) {
    auction.isWishListed = !auction.isWishListed;
    update();
  } */
  void onSuccessGetWonAuctions(WonAuctionResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      wonAuctionsPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    wonAuctionsPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    activeAuctionsPagingController.addPageRequestListener((pageKey) {
      getActiveAuctions(pageKey);
    });
    wonAuctionsPagingController.addPageRequestListener((pageKey) {
      getWonAuctions(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    activeAuctionsPagingController.dispose();
    wonAuctionsPagingController.dispose();
    super.onClose();
  }
}
