import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FlashSellScreenController extends GetxController {
  final PagingController<int, ProductShortItem> flashSellPagingController =
      PagingController(firstPageKey: 1);

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

  Future<void> getFlashSell(int currentPageNumber) async {
    ProductPageResponse? response = await APIRepo.getProductsUnderCriteria(
        currentPageNumber, '',
        flashDeal: 'true');
    if (response == null) {
      onErrorGetFlashSell(response);
      return;
    } else if (response.error) {
      onFailureGetFlashSell(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetFlashSell(response);
  }

  void onErrorGetFlashSell(ProductPageResponse? response) {
    flashSellPagingController.error = response;
  }

  void onFailureGetFlashSell(ProductPageResponse response) {
    flashSellPagingController.error = response;
  }

  void onSuccessGetFlashSell(ProductPageResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      flashSellPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    flashSellPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void onFlashSellItemWishListTap(ProductShortItem flashSell) {
    flashSell.isFavorite = !flashSell.isFavorite;
    update();
  }

  @override
  void onInit() {
    flashSellPagingController.addPageRequestListener((pageKey) {
      getFlashSell(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    flashSellPagingController.dispose();
    super.onClose();
  }
}
