import 'dart:developer';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/api_responses/single_product_review_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SingleProductReviewsScreenController extends GetxController {
  final PagingController<int, SingleProductReviewShortItem>
      singleProductReviewPagingController = PagingController(firstPageKey: 1);

  ProductDetailsItem theProduct = ProductDetailsItem.empty();

  double getStarProgressValue(double currentStar) {
    double percentValue = 0;

    for (var element in theProduct.productRatingWiseUser) {
      if (element.id.rating == currentStar) {
        percentValue = (100 / theProduct.totalReview) * element.count;
      }
    }
    return percentValue / 100;
  }

// Add Everywhere when we need to toggle add to favorite list  -- End

  Future<void> getSingleProductReview(
      int currentPageNumber, String product) async {
    // final String storeId = Helper.getUser().store.id;
    SingleProductReviewResponse? response =
        await APIRepo.getSingleProductReviewResponse(
            currentPageNumber, product);
    if (response == null) {
      onErrorGetSingleProductReview(response);
      return;
    } else if (response.error) {
      onFailureGetSingleProductReview(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetSingleProductReview(response);
  }

  //=========Error========
  void onErrorGetSingleProductReview(SingleProductReviewResponse? response) {
    singleProductReviewPagingController.error = response;
  }

//=========Failure========
  void onFailureGetSingleProductReview(SingleProductReviewResponse response) {
    singleProductReviewPagingController.error = response;
  }

  //=========success========
  void onSuccessGetSingleProductReview(SingleProductReviewResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      singleProductReviewPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    singleProductReviewPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  _getScreenParameters() {
    final arguments = Get.arguments;
    if (arguments is ProductDetailsItem) {
      theProduct = arguments;
    }
  }

//====on init======
  @override
  void onInit() {
    _getScreenParameters();
    singleProductReviewPagingController.addPageRequestListener((pageKey) {
      getSingleProductReview(pageKey, theProduct.id);
    });

    super.onInit();
  }

  //=====on close========
  @override
  void onClose() {
    singleProductReviewPagingController.dispose();
    super.onClose();
  }
}
