import 'dart:developer';

import 'package:ecomik/models/api_responses/delivery_requests_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DeliveryRequestListScreenController extends GetxController {
  final PagingController<int, DeliveryRequestItem>
      deliveryRequestPagingController = PagingController(firstPageKey: 1);

  Future<void> getDeliveryRequestsList(int currentPageNumber) async {
    DeliveryRequestsResponse? response =
        await APIRepo.getDeliveryRequestsList(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetTransactionList(response);
  }

  void onSuccessGetTransactionList(DeliveryRequestsResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      deliveryRequestPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    deliveryRequestPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    deliveryRequestPagingController.addPageRequestListener((pageKey) {
      getDeliveryRequestsList(pageKey);
    });
    super.onInit();
  }
}
