import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreenController extends GetxController {
  final Object productCategoryName = Object();

  /// Current product category name from parameter
  String currentProductCategoryName = '';

  /// This Global key of scaffold state use for drawer showing
  final GlobalKey<ScaffoldState> currentProductScaffoldKey =
      GlobalKey<ScaffoldState>();
  /* <-------- Select current category product name initially --------> */
  void setCurrentProductCategoryName(Object? argument) {
    if (argument != null) {
      if (argument is String) {
        currentProductCategoryName = argument;
      }
    }
  }

  /// Current filter availability value
  int currentFilterAvailability = 0;

  /// Current filter interface value
  int currentFilterInterface = 0;

  /// Current filter brand value
  int currentFilterBrand = 0;

  RangeValues rangeValues = const RangeValues(0, 60);

  @override
  void onInit() {
    setCurrentProductCategoryName(productCategoryName);
    super.onInit();
  }
}
