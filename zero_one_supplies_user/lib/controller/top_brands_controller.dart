import 'dart:developer';

import 'package:ecomik/models/api_responses/brands_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopBrandsScreenController extends GetxController {
  final PagingController<int, BrandShortItem> topBrandPagingController =
      PagingController(firstPageKey: 1);

  Future<void> getTopBrand(int currentPageNumber) async {
    BrandListsResponse? response =
        await APIRepo.getTopBrands(currentPageNumber);
    if (response == null) {
      onErrorGetTopBrand(response);
      return;
    } else if (response.error) {
      onFailureGetTopBrand(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetTopBrand(response);
  }

  void onErrorGetTopBrand(BrandListsResponse? response) {
    topBrandPagingController.error = response;
  }

  void onFailureGetTopBrand(BrandListsResponse response) {
    topBrandPagingController.error = response;
  }

  void onSuccessGetTopBrand(BrandListsResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      topBrandPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    topBrandPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    topBrandPagingController.addPageRequestListener((pageKey) {
      getTopBrand(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    topBrandPagingController.dispose();
    super.onClose();
  }
}
