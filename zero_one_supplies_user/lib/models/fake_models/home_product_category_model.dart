import 'package:flutter/material.dart';

class FakeHomeProductCategory {
  String title;
  int itemNumber;
  ImageProvider<Object> categoryImage;
  FakeHomeProductCategory({
    required this.title,
    required this.itemNumber,
    required this.categoryImage,
  });
}

class BidCategory {
  String name;
  String shortFrame;
  String money;
  ImageProvider<Object> categoryImage;
  BidCategory({
    required this.name,
    required this.shortFrame,
    required this.money,
    required this.categoryImage,
  });
}

class FakeDashboardSlider {
  ImageProvider<Object> categoryImage;
  FakeDashboardSlider({
    required this.categoryImage,
  });
}
