import 'dart:developer';

import 'package:ecomik/models/api_responses/categories_response.dart';
import 'package:ecomik/models/api_responses/subcategory_response.dart';
import 'package:ecomik/models/bottom_sheet_parameters/auction_bid_filter_parameter.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';

class ProductFilterScreenController extends GetxController {
  List<CategoryDocResponse> categories = const [];
  List<SubcategoryDocResponse> subCategories = const [];
  AuctionBidFilterParameter filterOptions = AuctionBidFilterParameter.empty();
  CategoryDocResponse selectedCategoryOption = CategoryDocResponse.empty();
  SubcategoryDocResponse selectedSubCategoryOption =
      SubcategoryDocResponse.empty();
  RxString selectedOptions = ''.obs;
  String preselectedCategoryID = '';
  /*  RxList<String> selectedOptions = <String>[].obs;

  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  } */

  void clearAllButtonTap() {
    selectedOptions.value = '';
    selectedCategoryOption = CategoryDocResponse.empty();
    selectedSubCategoryOption = SubcategoryDocResponse.empty();
    filterOptions = AuctionBidFilterParameter.empty();
    update();
  }

  void toggleOption(String option) {
    selectedOptions.value = option;
    filterOptions.selectedOptions = selectedOptions.value;
  }

  void toggleCategoryOption(CategoryDocResponse option) {
    selectedCategoryOption = option;
    filterOptions.selectedCategoryOption = selectedCategoryOption;
    selectedSubCategoryOption = SubcategoryDocResponse.empty();
    getSubCats(1, selectedCategoryOption.id);
    update();
  }

  void toggleSubCategoryOption(SubcategoryDocResponse option) {
    selectedSubCategoryOption = option;
    filterOptions.selectedSubCategoryOption = selectedSubCategoryOption;
    update();
  }

  Future<void> getCategories(int currentPageNumber) async {
    CategoriesResponse? response =
        await APIRepo.getCategoriesAPICall(currentPageNumber, size: 50);
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
    categories = response.data.docs;
    if (preselectedCategoryID.isNotEmpty) {
      final foundCategory = categories
          .firstWhereOrNull((category) => category.id == preselectedCategoryID);
      if (foundCategory != null) {
        toggleCategoryOption(foundCategory);
      }
    }
    update();
  }

  Future<void> getSubCats(int currentPageNumber, String id) async {
    SubcategoryResponse? response =
        await APIRepo.getSubcategoriesAPICall(currentPageNumber, id, size: 50);
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
    onSuccessRetrievingSubcategories(response);
  }

  onSuccessRetrievingSubcategories(SubcategoryResponse response) {
    subCategories = response.data.docs;
    update();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is AuctionBidFilterParameter) {
      preselectedCategoryID = argument.selectedCategoryOption.id;
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    getCategories(1);
    super.onInit();
  }
}
