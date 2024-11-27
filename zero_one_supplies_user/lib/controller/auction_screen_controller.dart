import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/auctions_response.dart';
import 'package:ecomik/models/api_responses/product_tag.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/models/bottom_sheet_parameters/auction_bid_filter_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AuctionScreenController extends GetxController {
  AuctionBidFilterParameter filterOptions = AuctionBidFilterParameter.empty();

/* RxList<String> selectedOptions = <String>[].obs;

 void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  } */

  int value1 = 1;
  int value2 = 1;
  int value3 = 1;
  List<String> sort = [
    AppLanguageTranslation.recentlyStartedTransKey.toCurrentLanguage,
    AppLanguageTranslation.endingSoonTransKey.toCurrentLanguage,
    AppLanguageTranslation.priceLowToHighTransKey.toCurrentLanguage,
    AppLanguageTranslation.priceHighToLowTransKey.toCurrentLanguage
  ];

  List<String> category = ['Hand Made', 'African Art', 'Frame Art'];
  List<String> subCategory = ['Hand Made', 'African Art', 'Frame Art'];
  RxBool isNewProductsTabSelected = false.obs;
  RxBool isNewAuctionsTabSelected = false.obs;
  final PagingController<int, AuctionShortItem> auctionsPagingController =
      PagingController(firstPageKey: 1);
  TextEditingController searchTextEditingController = TextEditingController();
  List<ProductTag> tags = [];
  void onChange(String text) {
    update();
    auctionsPagingController.refresh();
  }
/*   void onProductItemTap(Product myOrder) {
    // Navigator.pushNamed(context, AppPageNames.editProductScreen, arguments: myOrder);
    Get.toNamed(AppPageNames.editProductScreen, arguments: myOrder);
    update();
  }

  void outOfStockToggleOnTap(Product product) {
    product.stockAvailable = !product.stockAvailable;
    update();
  }

  void outOfStockGestureOnTap(Product myOrder) {
    outOfStockToggleOnTap(myOrder);
  } */

//=======================================================================

// ==============================================================================
/* ---------------------Duplicate ---------------------------------------------*/

// Add Everywhere when we need to toggle add to favorite list  -- Start
  toggleAddToFavorite(String id, [bool isAuction = false]) {
    toggleAddFav(id, isAuction);
  }

  void setFilterOptions(AuctionBidFilterParameter options) {
    filterOptions = options;
    update();
    auctionsPagingController.refresh();
  }

  void toggleTag(ProductTag tag, bool isSelected) {
    if (isSelected) {
      // selectedTag = tag;
      searchTextEditingController.text = tag.name;
    } else {
      // selectedTag = ProductTag.empty();
      searchTextEditingController.clear();
    }
    auctionsPagingController.refresh();
    update();
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

  Future<void> getAuctions(int currentPageNumber) async {
    AuctionsResponse? response = await APIRepo.getAuctions(
        currentPageNumber, searchTextEditingController.text, 'true',
        filterOptions: filterOptions);
    if (response == null) {
      onErrorGetAuctions(response);
      return;
    } else if (response.error) {
      onFailureGetAuctions(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetAuctions(response);
  }

  void onErrorGetAuctions(AuctionsResponse? response) {
    auctionsPagingController.error = response;
  }

  void onFailureGetAuctions(AuctionsResponse response) {
    auctionsPagingController.error = response;
  }

  void onAuctionItemWishListTap(AuctionShortItem auction) {
    auction.isWishListed = !auction.isWishListed;
    update();
  }

  void onSuccessGetAuctions(AuctionsResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      auctionsPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    auctionsPagingController.appendPage(response.data.docs, nextPageNumber);
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

/* ---------------------Duplicate ---------------------------------------------*/
  @override
  void onInit() {
    auctionsPagingController.addPageRequestListener((pageKey) {
      getAuctions(pageKey);
    });
    getTags(1);
    super.onInit();
  }

  @override
  void onClose() {
    auctionsPagingController.dispose();
    searchTextEditingController.dispose();
    super.onClose();
  }
}
