import 'package:ecomik/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Categories {
  String name;
  String image;
  bool imageType;
  Color color;
  Categories({
    required this.name,
    required this.image,
    required this.imageType,
    this.color = AppColors.primaryColor,
  });
}
