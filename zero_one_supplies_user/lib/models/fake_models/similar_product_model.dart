import 'package:flutter/material.dart';

class FakeSimilarProduct {
  String productName;
  String productCategory;
  String priceText;
  bool isWishListed;
  bool isAddedToCart;
  ImageProvider<Object> productImage;
  FakeSimilarProduct({
    required this.productName,
    required this.productCategory,
    required this.priceText,
    this.isWishListed = false,
    this.isAddedToCart = false,
    required this.productImage,
  });
}
