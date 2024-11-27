import 'package:ecomik/models/fake_models/chat_message_model.dart';
import 'package:ecomik/models/fake_models/home_product_category_model.dart';
import 'package:ecomik/models/fake_models/intro_content_model.dart';
import 'package:ecomik/models/fake_models/recent_payment_product_model.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:flutter/material.dart';

// import 'fake_models/bid_category_model.dart';

class FakeData {
  // Intro screens
  static List<FakeIntroContent> fakeIntroContents = [
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro_illustration1.png',
        slogan: LanguageHelper.currentLanguageText(
            LanguageHelper.discoverSomethingNewTransKey),
        content: LanguageHelper.currentLanguageText(
            LanguageHelper.introFirstScreenTextTransKey)),
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro_illustration2.png',
        slogan: LanguageHelper.currentLanguageText(
            LanguageHelper.trackingYourOrderTransKey),
        content: LanguageHelper.currentLanguageText(
            LanguageHelper.introSecondScreenTextTransKey)),
    FakeIntroContent(
        localSVGImageLocation: 'assets/images/intro_illustration3.png',
        slogan: LanguageHelper.currentLanguageText(
            LanguageHelper.paymentMultipleGatewayTransKey),
        content: LanguageHelper.currentLanguageText(
            LanguageHelper.introThirdScreenTextTransKey)),
  ];

  // Home page product categories
  static List<FakeHomeProductCategory> fakeHomeProductCategories = [
    FakeHomeProductCategory(
        title: 'Headphone',
        itemNumber: 22,
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/item1.png')
            .image),
    FakeHomeProductCategory(
        title: 'Photography',
        itemNumber: 22,
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/item2.png')
            .image),
    FakeHomeProductCategory(
        title: 'Accessories',
        itemNumber: 22,
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/item3.png')
            .image),
    FakeHomeProductCategory(
        title: 'Hand watch',
        itemNumber: 22,
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/item4.png')
            .image),
    FakeHomeProductCategory(
        title: 'Home Decor',
        itemNumber: 22,
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/item5.png')
            .image),
    FakeHomeProductCategory(
        title: 'Sound speaker',
        itemNumber: 22,
        categoryImage: Image.asset(
                'assets/images/demo_images/product_categories/item6.png')
            .image),
  ];
  // Home page product categories
  static List<FakeDashboardSlider> dashboardFakeSlider = [
    FakeDashboardSlider(
        categoryImage:
            Image.asset('assets/images/demo_images/product_categories/sld1.jpg')
                .image),
    FakeDashboardSlider(
        categoryImage:
            Image.asset('assets/images/demo_images/product_categories/sld2.jpg')
                .image),
    FakeDashboardSlider(
        categoryImage:
            Image.asset('assets/images/demo_images/product_categories/sld5.jpg')
                .image),
    FakeDashboardSlider(
        categoryImage:
            Image.asset('assets/images/demo_images/product_categories/sld4.jpg')
                .image),
    FakeDashboardSlider(
        categoryImage:
            Image.asset('assets/images/demo_images/product_categories/sld5.jpg')
                .image),
  ];

  // Notifications
/*   static List<FakeNotificationDateGroupModel> fakeNotificationDateGroups = [
    FakeNotificationDateGroupModel(
      dateHumanReadableText: 'Today',
      groupNotifications: [
        FakeNotificationModel(timeText: '02:02 PM', isRead: false, texts: [
          FakeNotificationTextModel(text: 'Your order '),
          FakeNotificationTextModel(text: '#637288', isHashText: true),
          FakeNotificationTextModel(text: ' is arrived Railstation by '),
          FakeNotificationTextModel(text: 'Michle Leo Hunt', isBoldText: true),
        ]),
        FakeNotificationModel(timeText: '03:10 PM', isRead: true, texts: [
          FakeNotificationTextModel(text: 'You received a payment of '),
          FakeNotificationTextModel(text: '#58.00', isHashText: true),
          FakeNotificationTextModel(text: ' is arrived Railstation by '),
          FakeNotificationTextModel(text: 'Michle Leo Hunt', isBoldText: true),
        ]),
      ],
    ),
    FakeNotificationDateGroupModel(
      dateHumanReadableText: 'Yesterday',
      groupNotifications: [
        FakeNotificationModel(timeText: '02:02 PM', isRead: true, texts: [
          FakeNotificationTextModel(text: '30% Discount', isColoredText: true),
          FakeNotificationTextModel(text: ' on '),
          FakeNotificationTextModel(text: 'trending item', isColoredText: true),
          FakeNotificationTextModel(
              text: ' for all new customer for first 20 sales'),
        ]),
        FakeNotificationModel(timeText: '03:10 PM', isRead: true, texts: [
          FakeNotificationTextModel(text: 'You received a payment of '),
          FakeNotificationTextModel(text: '#58.00', isHashText: true),
          FakeNotificationTextModel(text: ' is arrived Railstation by '),
          FakeNotificationTextModel(text: 'Michle Leo Hunt', isBoldText: true),
        ]),
        FakeNotificationModel(timeText: '27 Dec, 2021', isRead: true, texts: [
          FakeNotificationTextModel(text: 'You received a payment of '),
          FakeNotificationTextModel(text: '#58.00', isHashText: true),
          FakeNotificationTextModel(text: ' is arrived Railstation by '),
          FakeNotificationTextModel(text: 'Michle Leo Hunt', isBoldText: true),
        ]),
      ],
    ),
    FakeNotificationDateGroupModel(
      dateHumanReadableText: '27 Dec, 2021',
      groupNotifications: [
        FakeNotificationModel(timeText: '02:02 PM', isRead: true, texts: [
          FakeNotificationTextModel(text: '30% Discount', isColoredText: true),
          FakeNotificationTextModel(text: ' on '),
          FakeNotificationTextModel(text: 'trending item', isColoredText: true),
          FakeNotificationTextModel(
              text: ' for all new customer for first 20 sales'),
        ]),
        FakeNotificationModel(timeText: '03:10 PM', isRead: true, texts: [
          FakeNotificationTextModel(text: 'You received a payment of '),
          FakeNotificationTextModel(text: '#58.00', isHashText: true),
          FakeNotificationTextModel(text: ' is arrived Railstation by '),
          FakeNotificationTextModel(text: 'Michle Leo Hunt', isBoldText: true),
        ]),
        FakeNotificationModel(timeText: '27 Dec, 2021', isRead: true, texts: [
          FakeNotificationTextModel(text: 'You received a payment of '),
          FakeNotificationTextModel(text: '#58.00', isHashText: true),
          FakeNotificationTextModel(text: ' is arrived Railstation by '),
          FakeNotificationTextModel(text: 'Michle Leo Hunt', isBoldText: true),
        ]),
      ],
    ),
  ]; */

  /// Payment options
  /* static List<FakePaymentOptionModel> paymentOptions = [
    FakePaymentOptionModel(
        name: 'Cash on delivery',
        paymentImage: SvgPicture.asset(AppAssetImages.walletSVGLogoSolid,
            color: AppColors.primaryColor, height: 32, width: 32)),
    FakePaymentOptionModel(
        name: 'Credit card',
        paymentImage: SvgPicture.asset(AppAssetImages.masterCardSVGLogoColor)),
  ]; */

  /// Sample delivery man chat data
  static List<FakeChatMessageModel> deliveryManChats = [
    FakeChatMessageModel(
      isMyMessage: true,
      message: 'Hey there?\nHow much time?',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: false,
      message: 'On my way sir.\nWill reach in 10 mins.',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: true,
      message: 'Ok come with carefully!\nRemember the address please!',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: false,
      message:
          'Btw, I want to know more about the room space and facilities & can I get some more picture of current.',
      dateTimeText: 'Sep 04 2020',
    ),
  ];

  /// My orders

  /// Recently my bought product
  static List<FakeRecentPaymentProduct> recentPaymentProducts = [
    FakeRecentPaymentProduct(
        productName: 'Sennheiser Headphones',
        paymentDateTimeText: '30 Sep 2021, 11:59am',
        priceText: '129.00',
        itemCount: 3,
        productImage:
            Image.asset('assets/images/demo_images/recent_payment/image1.png')
                .image),
    FakeRecentPaymentProduct(
        productName: 'JBL Headphones',
        paymentDateTimeText: '30 Sep 2021, 11:59am',
        priceText: '129.00',
        itemCount: 3,
        productImage:
            Image.asset('assets/images/demo_images/recent_payment/image2.png')
                .image),
    FakeRecentPaymentProduct(
        productName: 'Beats Headphones',
        paymentDateTimeText: '30 Sep 2021, 11:59am',
        priceText: '129.00',
        itemCount: 3,
        productImage:
            Image.asset('assets/images/demo_images/recent_payment/image3.png')
                .image),
    FakeRecentPaymentProduct(
        productName: 'Bose Headphones',
        paymentDateTimeText: '30 Sep 2021, 11:59am',
        priceText: '129.00',
        itemCount: 3,
        productImage:
            Image.asset('assets/images/demo_images/recent_payment/image4.png')
                .image),
  ];
}
