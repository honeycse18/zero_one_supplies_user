import 'dart:developer';

import 'package:ecomik/models/api_responses/review_count_response.dart';
import 'package:ecomik/models/api_responses/single_seller_response.dart';
import 'package:ecomik/models/api_responses/store_reviews_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StoreReviewsScreenController extends GetxController {
  final PagingController<int, StoreReviewsShortItem>
      storeReviewPagingController = PagingController(firstPageKey: 1);
  SingleSellerDataResponse theSeller = SingleSellerDataResponse.empty();
  StoreReviewCountShortItem storeReviewCount =
      StoreReviewCountShortItem.empty();
  String get averageRating => theSeller.rating.avgRating.toStringAsFixed(1);

  double getStarProgressValue(double currentStar) {
    double percentValue = 0;
    for (RatingPercentage element in storeReviewCount.ratingPercentage) {
      if (element.id.rating == currentStar) {
        percentValue =
            (100 / storeReviewCount.rating.sellerReviews) * element.count;
      }
    }
    return percentValue / 100;
  }

  Future<void> getReviewCount(String id) async {
    ReviewCountResponse? response = await APIRepo.getReviewCount(id);
    if (response == null) {
      onErrorGetReviewCount(response);
      return;
    } else if (response.error) {
      onFailureGetReviewCount(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetReviewCount(response);
  }

  void onErrorGetReviewCount(ReviewCountResponse? response) {}

  void onFailureGetReviewCount(ReviewCountResponse response) {}
  void onSuccessGetReviewCount(ReviewCountResponse response) {
    storeReviewCount = response.data;
    update();
  }

// Add Everywhere when we need to toggle add to favorite list  -- End

  Future<void> getStoreReview(int currentPageNumber, String id) async {
    // final String storeId = Helper.getUser().store.id;
    StoreReviewsResponse? response =
        await APIRepo.getStoreReview(currentPageNumber, id);
    if (response == null) {
      onErrorGetStoreReview(response);
      return;
    } else if (response.error) {
      onFailureGetStoreReview(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetStoreReview(response);
  }

  void onErrorGetStoreReview(StoreReviewsResponse? response) {
    storeReviewPagingController.error = response;
  }

  void onFailureGetStoreReview(StoreReviewsResponse response) {
    storeReviewPagingController.error = response;
  }

  void onSuccessGetStoreReview(StoreReviewsResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      storeReviewPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    storeReviewPagingController.appendPage(response.data.docs, nextPageNumber);
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
    getReviewCount(theSeller.id);
    storeReviewPagingController.addPageRequestListener((pageKey) {
      getStoreReview(pageKey, theSeller.id);
    });

    super.onInit();
  }

  @override
  void onClose() {
    storeReviewPagingController.dispose();
    super.onClose();
  }
}
