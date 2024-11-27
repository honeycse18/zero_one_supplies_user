import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/ending_soon_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EndingSoonScreenController extends GetxController {
  final PagingController<int, EndingSoonShortItem> endingSoonPagingController =
      PagingController(firstPageKey: 1);

// Add Everywhere when we need to toggle add to favorite list  -- Start
  toggleAddToFavorite(String id, [bool isAuction = false]) {
    toggleAddFav(id, isAuction);
  }

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
    log(response.msg);
  }

// Add Everywhere when we need to toggle add to favorite list  -- End

  Future<void> getEndingSoon(int currentPageNumber) async {
    EndingSoonResponse? response = await APIRepo.getEndingSoon(
        currentPageNumber, searchTextEditingController.text, 'true');
    if (response == null) {
      onErrorGetEndingSoon(response);
      return;
    } else if (response.error) {
      onFailureGetOnErrorGetEndingSoon(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetEndingSoon(response);
  }

  void onErrorGetEndingSoon(EndingSoonResponse? response) {
    endingSoonPagingController.error = response;
  }

  void onFailureGetOnErrorGetEndingSoon(EndingSoonResponse response) {
    endingSoonPagingController.error = response;
  }

  void onEndingSoonItemWishListTap(EndingSoonShortItem endingSoonProduct) {
    endingSoonProduct.isFavorite = !endingSoonProduct.isFavorite;
    update();
  }

  void onSuccessGetEndingSoon(EndingSoonResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      endingSoonPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    endingSoonPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void onChange(String text) {
    endingSoonPagingController.refresh();
  }

  @override
  void onInit() {
    endingSoonPagingController.addPageRequestListener((pageKey) {
      getEndingSoon(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    endingSoonPagingController.dispose();
    searchTextEditingController.dispose();
    super.onClose();
  }
}
