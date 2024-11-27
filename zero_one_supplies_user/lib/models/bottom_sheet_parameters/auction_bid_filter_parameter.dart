import 'package:ecomik/models/api_responses/categories_response.dart';
import 'package:ecomik/models/api_responses/subcategory_response.dart';
import 'package:flutter/material.dart';

class AuctionBidFilterParameter {
  String selectedOptions;
  CategoryDocResponse selectedCategoryOption;
  SubcategoryDocResponse selectedSubCategoryOption;
  RangeValues selectedRangeValues;

  AuctionBidFilterParameter(
      {this.selectedOptions = '',
      required this.selectedCategoryOption,
      required this.selectedSubCategoryOption,
      this.selectedRangeValues = const RangeValues(0, 100000)});

  factory AuctionBidFilterParameter.empty() => AuctionBidFilterParameter(
      selectedCategoryOption: CategoryDocResponse.empty(),
      selectedSubCategoryOption: SubcategoryDocResponse.empty());

  bool get isEmpty =>
      selectedCategoryOption.id.isEmpty || selectedSubCategoryOption.id.isEmpty;
}
