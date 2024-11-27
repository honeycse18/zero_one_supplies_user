import 'dart:developer';

import 'package:ecomik/models/api_responses/product_order_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyOrderScreenController extends GetxController {
  int selectedTabIndex = 0;

  void onTabTap(int tabIndex) {
    selectedTabIndex = tabIndex;
    update();
    myOrderPagingController.refresh();
  }

  final PagingController<int, ProductOrderItem> myOrderPagingController =
      PagingController(firstPageKey: 1);

  String getFilterFromTabIndex(int tabIndex) {
    final String filterTerm;
    switch (tabIndex) {
      case 0:
        filterTerm = '';
        break;
      case 1:
        filterTerm = MyOrderStatusTypes.placed.stringValue;
        break;
      case 2:
        filterTerm = MyOrderStatusTypes.pending.stringValue;
        break;
      case 3:
        filterTerm = MyOrderStatusTypes.confirm.stringValue;
        break;
      case 4:
        filterTerm = MyOrderStatusTypes.processing.stringValue;
        break;
      case 5:
        filterTerm = MyOrderStatusTypes.picked.stringValue;
        break;
      case 6:
        filterTerm = MyOrderStatusTypes.onWay.stringValue;
        break;
      case 7:
        filterTerm = MyOrderStatusTypes.delivered.stringValue;
        break;
      case 8:
        filterTerm = MyOrderStatusTypes.cancelled.stringValue;
        break;
      default:
        filterTerm = MyOrderStatusTypes.pending.stringValue;
    }
    return filterTerm;
  }

  Future<void> getOrders(int currentPageNumber) async {
    ProductOrderResponse? response = await APIRepo.getMyOrderResponses(
        currentPageNumber, getFilterFromTabIndex(selectedTabIndex));
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
    onSuccessRetrievingResponse(response);
  }

  onSuccessRetrievingResponse(ProductOrderResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      myOrderPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    myOrderPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is int) {
      onTabTap(argument);
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    myOrderPagingController.addPageRequestListener((pageKey) {
      getOrders(pageKey);
    });
    super.onInit();
  }
}
