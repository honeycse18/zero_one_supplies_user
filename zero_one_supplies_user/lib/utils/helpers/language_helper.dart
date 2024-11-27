import 'package:ecomik/utils/app_singleton.dart';
import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';

class LanguageHelper {
  static const String welcomeTo01SuppliesTransKey = 'welcome to 01 supplies';
  static const String helloThereSignInToContinueTransKey =
      'hello there, sign in to continue';
  static const String emailAddressTransKey = 'email address';
  static const String passwordTransKey = 'password';
  static const String confirmPasswordTransKey = 'confirm password';
  static const String dontHaveAnAccountTransKey = 'dont\'t have an account?';
  static const String signUpTransKey = 'sign up';
  static const String discoverSomethingNewTransKey = 'discover something new';
  static const String trackingYourOrderTransKey = 'tracking your order';
  static const String paymentMultipleGatewayTransKey =
      'payment multiple gateway';
  static const String introFirstScreenTextTransKey =
      'discover the easiest way to shop from a wide range of products across various categories. Enjoy a seamless shopping experience tailored just for you, right at your fingertips.';
  static const String introSecondScreenTextTransKey =
      'browse through our extensive collection of fashion, electronics, home essentials, and more. Find exclusive deals, enjoy easy returns, and track your orders with a few taps.';
  static const String introThirdScreenTextTransKey =
      'sign up now to unlock a special welcome offer! Explore new arrivals and shop your favorite brands. Your next purchase is just a swipe away.';

  static const String rememberMeTransKey = 'remember me';
  static const String forgotPasswordTransKey = 'forgot password';
  static const String signInTransKey = 'sign in';
  static const String orSignInWithSocialAccountTransKey =
      'or sign in with social account';
  static const String gettingStartedTransKey = 'getting started';
  static const String helloThereSignUpToContinueTransKey =
      'hello there, sign up to continue';
  static const String firstNameTransKey = 'first name';
  static const String yourFirstNameTransKey = 'your first name';
  static const String lastNameTransKey = 'last name';
  static const String yourLastNameTransKey = 'your last name';
  static const String phoneTransKey = 'phone';
  static const String bySigningUpIAgreeToTheTransKey =
      'by signing up, I agree to the';
  static const String termsOfServiceTransKey = 'terms of service';
  static const String andTransKey = 'and';
  static const String privacyPolicyTransKey = 'privacy policy';
  static const String alreadyHaveAnAccountTransKey = 'already have an account';
  static const String auctionProductTransKey = 'auction product';
  static const String viewAllTransKey = 'view all';
  static const String popularCategoriesTransKey = 'popular categories';
  static const String endingSoonTransKey = 'ending soon';
  static const String topBrandsTransKey = 'top brands';
  static const String popularProductTransKey = 'popular product';
  static const String allProductTransKey = 'all product';
  static const String topSellerTransKey = 'top seller';
  static const String productDescriptionTransKey = 'product description';
  static const String bankNameTransKey = 'bank name';
  static const String myAccountTransKey = 'my account';
  static const String myAuctionBidTransKey = 'my auction bid';
  static const String myOrderTransKey = 'my order';
  static const String savedAddressTransKey = 'saved address';
  static const String wishlistTransKey = 'wishlist';
  static const String settingsTransKey = 'settings';
  static const String contactUsTransKey = 'contact us';
  static const String aboutUsTransKey = 'about us';
  static const String termsConditionTransKey = 'terms & conditions';
  static const String policyTransKey = 'policy';
  static const String deleteAccountTransKey = 'delete account';
  static const String signOutTransKey = 'sign out';
  static const String activeAuctionTransKey = 'active auction';
  static const String wonAuctionTransKey = 'won auction';
  static const String haveNoOrderTransKey = 'you have no order';
  static const String preferenceTransKey = 'preference';
  static const String countryTransKey = 'country';
  static const String currencyTransKey = 'currency';
  static const String languageTransKey = 'language';
  static const String applicationSettingTransKey = 'application setting';
  static const String notificationTransKey = 'notification';
  static const String addressTransKey = 'address';
  static const String getInTouchTransKey = 'get in touch';
  static const String subjectTransKey = 'subject';
  static const String messageTransKey = 'message';
  static const String sendMailTransKey = 'send mail';
  static const String returnPolicyTransKey = 'returns policy';
  static const String allOrderTransKey = 'all orders';
  static const String placedOrderTransKey = 'placed';
  static const String pendingOrderTransKey = 'pending';
  static const String confirmOrderTransKey = 'confirm';
  static const String processingOrderTransKey = 'processing';
  static const String pickedOrderTransKey = 'picked';
  static const String onWayOrderTransKey = 'on way';
  static const String deliveredOrderTransKey = 'delivered';
  static const String cancelledOrderTransKey = 'cancelled';
  static const String nextTransKey = 'next';
  static const String searchItemTransKey = 'search item or store';
  static const String noItemFoundTransKey = 'no item found!';
  static const String filterTransKey = 'filter';
  static const String sortByTransKey = 'sort by';
  static const String lowToHighTransKey = 'low to high';
  static const String highToLowTransKey = 'high to low';
  static const String aToZTransKey = 'a to z';
  static const String zToATransKey = 'z to a';
  static const String categoriesTransKey = 'categories';
  static const String subCategoriesTransKey = 'subcategories';
  static const String clearAllTransKey = 'clear all';
  static const String applyFilterTransKey = 'apply filter';
  static const String noSubCategoriesTransKey =
      'no subcategory found under this category';
  static const String categoriesToSubCategoriesTransKey =
      'please tap a category to see subcategory';
  static const String productTransKey = 'product';
  static const String specificationTransKey = 'specifications';
  static const String estimateDeliveryTransKey = 'estimated delivery';
  static const String withInDaysTransKey = 'with 5 days';
  static const String freeShippingTransKey = 'free shipping';
  static const String orderOverTransKey = r'order over 100$';
  static const String easyReturnTransKey = '7 days return';
  static const String withoutAnyDamageTransKey = 'without any damage';
  static const String reviewsTransKey = 'reviews';
  static const String similarProductTransKey = 'similar products';
  static const String totalTransKey = 'total';
  static const String removeFromCartTransKey = 'remove from cart';
  static const String addToCartCartTransKey = 'add to cart';
  static const String visitStoreTransKey = 'visit store';
  static const String bidHistoryTransKey = 'bid history';
  static const String highestBidTransKey = 'highest bid';
  static const String bidNowTransKey = 'bid now';
  static const String shoppingCartTransKey = 'shopping cart empty';
  static const String checkTradingTransKey = 'check out what\'s trending';
  static const String removeCartSmsTransKey =
      'do you want to remove product from cart ?';
  static const String couponCodeTransKey = 'coupon code';
  static const String applyTransKey = 'apply';
  static const String subTotalTransKey = 'sub total';
  static const String discountTransKey = 'discount';
  static const String vatTransKey = 'vat';
  static const String checkoutTransKey = 'checkout';
  static const String shippingAddressTransKey = 'shipping address';

  static const String homeDeliveryTransKey = 'home delivery';
  static const String pickUpPointTransKey = 'pick up point';
  static const String selectPickUpPointTransKey = 'select pickup station';
  static const String selectPointTransKey = 'select point';
  static const String preferredDeliveryTimeTransKey = 'preferred delivery time';
  static const String productDetailsTransKey = 'product details';
  static const String shippingChargeTransKey = 'shipping charge';
  static const String distanceFareTransKey = 'distance fare';
  static const String deliveryDistanceTransKey = 'delivery distance';
  static const String transactionFeeTransKey = 'transaction fare';
  static const String proceedToPaymentTransKey = 'proceed to payment';
  static const String paymentTransKey = 'payment';
  static const String finishAndPayTransKey = 'finish and pay';
  static const String skipTransKey = 'skip';
  static const String selectLanguageTransKey = 'select language';
  static const String storeReviewTransKey = 'store reviews';
  static const String basedOnTransKey = 'based on';
  static const String userReviewTransKey = 'user reviews';
  static const String mostUsefulTransKey = 'most useful';
  static const String newestTransKey = 'newest';
  static const String oldestTransKey = 'oldest';
  static const String mostRelevantTransKey = 'most relevant';
  static const String noActiveAuctionTransKey =
      'you dont have any active actions.';
  static const String noWonAuctionTransKey = 'you dont have any active actions';
  static const String noNotificationTransKey = 'you dont have any notification';
  static const String localeCodeTransKey = Constants.languageTranslationKeyCode;

  static final Map<String, String> fallBackEnglishTranslation = {
    welcomeTo01SuppliesTransKey: 'Welcome to 01 Supplies',
    helloThereSignInToContinueTransKey: 'Hello there, sign in to continue',
    emailAddressTransKey: 'Email address',
    passwordTransKey: 'Password',
    introFirstScreenTextTransKey:
        'Discover the easiest way to shop from a wide range of products across various categories. Enjoy a seamless shopping experience tailored just for you, right at your fingertips.',
    introSecondScreenTextTransKey:
        'Browse through our extensive collection of fashion, electronics, home essentials, and more. Find exclusive deals, enjoy easy returns, and track your orders with a few taps.',
    introThirdScreenTextTransKey:
        'sign up now to unlock a special welcome offer! Explore new arrivals and shop your favorite brands. Your next purchase is just a swipe away.',
    confirmPasswordTransKey: 'Confirm password',
    dontHaveAnAccountTransKey: 'Don\'t have and account?',
    signUpTransKey: 'Sign up',
    discoverSomethingNewTransKey: 'Discover something new',
    trackingYourOrderTransKey: 'Tracking your order',
    paymentMultipleGatewayTransKey: 'Payment multiple gateway',
    rememberMeTransKey: 'Remember me',
    forgotPasswordTransKey: 'Forgot password',
    signInTransKey: 'Sign in',
    orSignInWithSocialAccountTransKey: 'Or sign in with social account',
    gettingStartedTransKey: 'Getting started',
    helloThereSignUpToContinueTransKey: 'Hello there, sign up to continue',
    firstNameTransKey: 'First name',
    yourFirstNameTransKey: 'Your first name',
    lastNameTransKey: 'Last name',
    yourLastNameTransKey: 'Your last name',
    phoneTransKey: 'Phone',
    bySigningUpIAgreeToTheTransKey: 'By signing up, I agree to the',
    termsOfServiceTransKey: 'Terms of service',
    andTransKey: 'and',
    deleteAccountTransKey: 'Delete Account',
    privacyPolicyTransKey: 'Privacy policy',
    returnPolicyTransKey: 'Returns policy',
    alreadyHaveAnAccountTransKey: 'Already have an account?',
    auctionProductTransKey: 'Auction product',
    viewAllTransKey: 'View all',
    popularCategoriesTransKey: 'Popular categories',
    endingSoonTransKey: 'Ending soon',
    topBrandsTransKey: 'Top brands',
    popularProductTransKey: 'Popular product',
    allProductTransKey: 'All product',
    topSellerTransKey: 'Top seller',
    productDescriptionTransKey: 'Product description',
    bankNameTransKey: 'Bank name',
    myAccountTransKey: 'My Account',
    myAuctionBidTransKey: 'My Auction Bids',
    myOrderTransKey: 'My Order',
    savedAddressTransKey: 'Saved Address',
    wishlistTransKey: 'Wishlist',
    settingsTransKey: 'Settings',
    contactUsTransKey: 'Contact Us',
    aboutUsTransKey: 'About Us',
    termsConditionTransKey: 'Terms & Conditions',
    policyTransKey: 'Policy',
    signOutTransKey: 'Sign Out',
    activeAuctionTransKey: 'Active Auction',
    wonAuctionTransKey: 'Won Auction',
    haveNoOrderTransKey: 'You Have No Order',
    preferenceTransKey: 'Preference',
    countryTransKey: 'Country',
    currencyTransKey: 'Currency',
    languageTransKey: 'Language',
    applicationSettingTransKey: 'Application Setting',
    notificationTransKey: 'Notification',
    addressTransKey: 'Address',
    getInTouchTransKey: 'Get in Touch',
    subjectTransKey: 'Subject',
    messageTransKey: 'Message',
    sendMailTransKey: 'Send Mail',
    allOrderTransKey: 'All Orders',
    placedOrderTransKey: 'Placed',
    pendingOrderTransKey: 'Pending',
    confirmOrderTransKey: 'Confirm',
    processingOrderTransKey: 'Processing',
    pickedOrderTransKey: 'Picked',
    onWayOrderTransKey: 'On Way',
    deliveredOrderTransKey: 'Delivered',
    cancelledOrderTransKey: 'Cancelled',
    nextTransKey: 'Next',
    searchItemTransKey: 'Search item or store',
    noItemFoundTransKey: 'No item found!',
    filterTransKey: 'Filter',
    sortByTransKey: 'Sort By',
    lowToHighTransKey: 'Low to High',
    highToLowTransKey: 'High to Low',
    aToZTransKey: 'A to Z',
    zToATransKey: 'Z to A',
    categoriesTransKey: 'Categories',
    subCategoriesTransKey: 'Subcategories',
    clearAllTransKey: 'Clear All',
    applyFilterTransKey: 'Apply Filter',
    noSubCategoriesTransKey: 'No Subcategory found under this category!',
    categoriesToSubCategoriesTransKey:
        'Please tap a category to see subcategory',
    productTransKey: 'Product',
    specificationTransKey: 'Specifications',
    estimateDeliveryTransKey: 'Estimated Delivery',
    withInDaysTransKey: 'With 5 Days',
    freeShippingTransKey: 'Free Shipping',
    orderOverTransKey: r'Order over 100$',
    easyReturnTransKey: '7 Days Return',
    withoutAnyDamageTransKey: 'Without Any Damage',
    reviewsTransKey: 'Reviews',
    similarProductTransKey: 'Similar Products',
    totalTransKey: 'Total',
    removeFromCartTransKey: 'Remove from cart',
    addToCartCartTransKey: 'Add to cart',
    visitStoreTransKey: 'Visit Store',
    bidHistoryTransKey: 'Bid History',
    highestBidTransKey: 'Highest bid',
    bidNowTransKey: 'Bid Now',
    shoppingCartTransKey: 'Shopping Cart Empty',
    checkTradingTransKey: 'Check out what\'s trending',
    removeCartSmsTransKey: 'Do You Want to Remove Product From Cart ?',
    couponCodeTransKey: 'Coupon Code',
    applyTransKey: 'Apply',
    subTotalTransKey: 'Sub Total',
    discountTransKey: 'Discount',
    vatTransKey: 'Vat',
    checkoutTransKey: 'Checkout',
    shippingAddressTransKey: 'Shipping address',
    homeDeliveryTransKey: 'Home delivery',
    pickUpPointTransKey: 'Pick up point',
    selectPickUpPointTransKey: 'Select pickup station',
    selectPointTransKey: 'Select point',
    preferredDeliveryTimeTransKey: 'Preferred delivery time',
    productDetailsTransKey: 'Product details',
    shippingChargeTransKey: 'Shipping charge',
    distanceFareTransKey: 'Distance fare',
    deliveryDistanceTransKey: 'Delivery distance',
    transactionFeeTransKey: 'Transaction fee',
    proceedToPaymentTransKey: 'Proceed to payment',
    paymentTransKey: 'payment',
    finishAndPayTransKey: 'Finish and pay',
    skipTransKey: 'Skip',
    selectLanguageTransKey: 'Select language',
    storeReviewTransKey: 'Store Reviews',
    basedOnTransKey: 'Based on',
    userReviewTransKey: 'User reviews',
    mostUsefulTransKey: 'Most Useful',
    newestTransKey: 'Newest',
    oldestTransKey: 'Oldest',
    mostRelevantTransKey: 'Most relevant',
    noActiveAuctionTransKey: 'You don\'t have any active actions',
    noWonAuctionTransKey: 'You don\'t have any won actions',
    noNotificationTransKey: 'You don\'t have any notification',
    localeCodeTransKey: 'en_US',
  };

  static String currentLanguageText(String translationKey) {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(Constants.hiveDefaultLanguageKey);
    if (currentLanguageName is! String) {
      return fallbackText(translationKey);
    }
    final dynamic currentLanguageTranslations =
        AppSingleton.instance.localBox.get(currentLanguageName);
    if (currentLanguageTranslations is! Map<String, String>) {
      return fallbackText(translationKey);
    }
    final String? translatedText = currentLanguageTranslations[translationKey];
    if (translatedText == null) {
      return fallbackText(translationKey);
    }
    return translatedText;
  }

  static String fallbackText(String translationKey) =>
      AppLanguageTranslation.fallBackEnglishTranslation[translationKey] ?? '';
}
