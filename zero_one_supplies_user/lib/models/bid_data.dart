import 'package:ecomik/models/fake_models/home_product_category_model.dart';
import 'package:flutter/material.dart';

// import 'fake_models/bid_category_model.dart';

class BidData {
  // Home page product categories
  static List<BidCategory> bidCategories = [
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$14.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image942.png')
            .image),
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$14.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image946.png')
            .image),
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$14.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image947.png')
            .image),
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$14.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image948.png')
            .image),
  ];
//===============Won Catagories===============

  static List<BidCategory> wonCategories = [
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$17.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image946.png')
            .image),
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$20.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image942.png')
            .image),
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$90.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image948.png')
            .image),
    BidCategory(
        name: 'African Art',
        shortFrame: 'Art frame',
        money: r'$47.99',
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/image947.png')
            .image),
  ];
}
