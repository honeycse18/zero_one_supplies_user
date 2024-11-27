import 'dart:developer';

import 'package:ecomik/models/api_responses/single_seller_response.dart';
import 'package:ecomik/models/api_responses/store_reviews_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SellerShortReviewScreenPageController extends GetxController {
  final PagingController<int, StoreReviewsShortItem>
      storeReviewPagingController = PagingController(firstPageKey: 1);
  String sellerId = '';
  SingleSellerDataResponse theSeller = SingleSellerDataResponse.empty();
  int value = 1;
  List<StoreReviewsShortItem> reviews = [];

  String get averageRating => theSeller.rating.avgRating.toStringAsFixed(1);

  Future<void> getStoreReview(int currentPageNumber, String id) async {
    // final String storeId = Helper.getUser().store.id;
    StoreReviewsResponse? response =
        await APIRepo.getStoreReview(currentPageNumber, id);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetStoreReview(response);
  }

  void onSuccessGetStoreReview(StoreReviewsResponse response) {
    if (response.data.docs.length < 5) {
      reviews = response.data.docs;
    } else {
      reviews = response.data.docs.sublist(0, 5);
    }
    update();
  }

  _getScreenParameters() {
    final arguments = Get.arguments;
    if (arguments is SingleSellerDataResponse) {
      theSeller = arguments;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    getStoreReview(1, theSeller.id);
    super.onInit();
  }
}
