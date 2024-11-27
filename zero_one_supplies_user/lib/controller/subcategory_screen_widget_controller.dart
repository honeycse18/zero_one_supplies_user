import 'dart:developer';

import 'package:ecomik/models/api_responses/subcategory_children_response.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SubcategoryChildrenScreenWidgetController extends GetxController {
  String selectedSubcategoryID = '';
  final PagingController<int, SubsChildrenDocResponse>
      subcategoryChildrenPagingController = PagingController(firstPageKey: 1);

  Future<void> getChildren(int currentPageNumber, String id) async {
    if (id.isEmpty) {
      subcategoryChildrenPagingController.error = false;
      return;
    }
    SubcategoryChildrenResponse? response =
        await APIRepo.getSubcategoryChildren(currentPageNumber, id);
    if (response == null) {
      subcategoryChildrenPagingController.error = response?.toJson() ?? true;
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      subcategoryChildrenPagingController.error = response.toJson();
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingChildren(response);
  }

  onSuccessRetrievingChildren(SubcategoryChildrenResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      subcategoryChildrenPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    subcategoryChildrenPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  _getScreenParameters() {
    final String arguments = Get.find<String>(tag: 'product_subcategory');
    selectedSubcategoryID = arguments;
    Get.delete<String>(tag: 'product_subcategory');
  }

  @override
  void onInit() {
    _getScreenParameters();
    subcategoryChildrenPagingController.addPageRequestListener((pageKey) {
      getChildren(pageKey, selectedSubcategoryID);
    });
    super.onInit();
  }
}
