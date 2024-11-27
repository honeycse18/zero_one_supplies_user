import 'dart:developer';

import 'package:ecomik/models/api_responses/categories_response.dart';
import 'package:ecomik/models/api_responses/subcategory_response.dart';
import 'package:ecomik/models/categories_rout_parameters/categories_rout_parameters.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CategoriesScreenController extends GetxController {
  int selectedIndex = -1;
  int selectedSubIndex = -1;
  String selectedCategoryID = '';
  String selectedSubcategoryID = '';
  RxBool hasBackButton = false.obs;

  final PagingController<int, CategoryDocResponse> categoriesPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, SubcategoryDocResponse>
      subcategoryPagingController = PagingController(firstPageKey: 1);

  void onCategoryTapped(int index, CategoryDocResponse category) {
    // setState(() {
    selectedIndex = index;
    selectedCategoryID = category.id;
    update();
    subcategoryPagingController.refresh();
    // });
  }

  void onSubcategoryItemTap(int index, SubcategoryDocResponse subcategory) {
    selectedSubIndex = index;
    selectedSubcategoryID = subcategory.id;
    update();
  }

  Future<void> getSubCats(int currentPageNumber, String id) async {
    if (id.isEmpty) {
      subcategoryPagingController.error = false;
      return;
    }
    SubcategoryResponse? response =
        await APIRepo.getSubcategoriesAPICall(currentPageNumber, id);
    if (response == null) {
      subcategoryPagingController.error = response?.toJson() ?? true;
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      subcategoryPagingController.error = response.toJson();
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingSubcategories(response);
  }

  onSuccessRetrievingSubcategories(SubcategoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      subcategoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    subcategoryPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  Future<void> getCategories(int currentPageNumber) async {
    CategoriesResponse? response =
        await APIRepo.getCategoriesAPICall(currentPageNumber);
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

  onSuccessRetrievingResponse(CategoriesResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      categoriesPagingController.appendLastPage(response.data.docs);
      getRequiredCategoryTapped();
      return;
    }
    final nextPageNumber = response.data.page + 1;
    categoriesPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void _getScreenParameters() {
    final params = Get.arguments;
    if (params is CategoriesRoutParameters) {
      selectedCategoryID = params.categoryId;
      hasBackButton.value = params.hasBackButton;
    }
  }

  void getRequiredCategoryTapped() {
    if (selectedCategoryID.isNotEmpty) {
      for (var i = 0;
          i < (categoriesPagingController.itemList?.length ?? 0);
          i++) {
        if (categoriesPagingController.itemList?[i].id == selectedCategoryID) {
          selectedIndex = i;
          return;
        }
      }
    } else {
      onCategoryTapped(
          0,
          categoriesPagingController.itemList?[0] ??
              CategoryDocResponse.empty());
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    categoriesPagingController.addPageRequestListener((pageKey) {
      getCategories(pageKey);
    });
    subcategoryPagingController.addPageRequestListener((pageKey) {
      getSubCats(pageKey, selectedCategoryID);
    });
    super.onInit();
  }
}
