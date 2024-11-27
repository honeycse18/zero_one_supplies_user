import 'dart:developer';

import 'package:ecomik/models/api_responses/remove_favorite_response.dart';
import 'package:ecomik/models/api_responses/wishlist_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WishListScreenController extends GetxController {
  final PagingController<int, WishlistDocResponse> wishlistPagingController =
      PagingController(firstPageKey: 1);

  RxBool isAuctionTabSelected = false.obs;

  onWishListTap(String id) {
    removeItemFromWishList(id);
  }

  Future<void> removeItemFromWishList(String id) async {
    RemoveFavoriteResponse? response = await APIRepo.removeFromWishlist(id);
    if (response == null) {
      log(AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRemoveFromFavList(response);
  }

  onSuccessRemoveFromFavList(RemoveFavoriteResponse response) {
    wishlistPagingController.refresh();
  }

  Future<void> getWishlist(int currentPageNumber) async {
    WishlistResponse? response = await APIRepo.getWishlist(
        currentPageNumber, isAuctionTabSelected.value);
    if (response == null) {
      onFailureGettingWishlist(response);
      return;
    } else if (response.error) {
      onErrorGettingWishlist(response);
      return;
    }
    log(response.toJson().toString());
    log(APIHelper.getAuthHeaderMap().toString());
    onSuccessGettingWishlist(response);
  }

  onFailureGettingWishlist(WishlistResponse? response) {
    AppDialogs.showErrorDialog(
        messageText:
            AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
  }

  onErrorGettingWishlist(WishlistResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  onSuccessGettingWishlist(WishlistResponse response) {
    final isLastPage = !response.data.favorites.hasNextPage;
    if (isLastPage) {
      wishlistPagingController.appendLastPage(response.data.favorites.docs);
      return;
    }
    final nextPageNumber = response.data.favorites.page + 1;
    wishlistPagingController.appendPage(
        response.data.favorites.docs, nextPageNumber);
  }

  @override
  void onInit() {
    wishlistPagingController.addPageRequestListener((pageKey) {
      getWishlist(pageKey);
    });

    super.onInit();
  }

  @override
  void onClose() {
    wishlistPagingController.dispose();
    super.onClose();
  }
}
