import 'dart:developer';

import 'package:ecomik/models/api_responses/seller_list_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopSellerScreenController extends GetxController {
  final PagingController<int, SellerSingleShortItem> flashSellPagingController =
      PagingController(firstPageKey: 1);
  String theSeller = '';
  Future<void> getTopSeller(int currentPageNumber) async {
    SellerListResponse? response =
        await APIRepo.getTopSeller(currentPageNumber);
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

  void onErrorGetFlashSell(SellerListResponse? response) {
    flashSellPagingController.error = response;
  }

  void onFailureGetFlashSell(SellerListResponse response) {
    flashSellPagingController.error = response;
  }

  void onSuccessGetFlashSell(SellerListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      flashSellPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    flashSellPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      theSeller = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    flashSellPagingController.addPageRequestListener((pageKey) {
      getTopSeller(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    flashSellPagingController.dispose();
    super.onClose();
  }
}
