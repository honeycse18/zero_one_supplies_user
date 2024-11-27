import 'package:ecomik/screens/Support_ticket_screen.dart';
import 'package:ecomik/screens/about_us_screen.dart';
import 'package:ecomik/screens/action_bids.dart';
import 'package:ecomik/screens/add_address_screen.dart';
import 'package:ecomik/screens/add_money_screen.dart';
import 'package:ecomik/screens/add_new_card_screen.dart';
import 'package:ecomik/screens/add_review_screen.dart';
import 'package:ecomik/screens/all_help_tickets.dart';
import 'package:ecomik/screens/all_pickup.dart';
import 'package:ecomik/screens/auction_product.dart';
import 'package:ecomik/screens/bid_details.dart';
import 'package:ecomik/screens/bid_filter.dart';
import 'package:ecomik/screens/bid_popup.dart';
import 'package:ecomik/screens/bid_product_details.dart';
import 'package:ecomik/screens/bid_walet_screen.dart';
import 'package:ecomik/screens/call_screen.dart';
import 'package:ecomik/screens/cancalationpolicy.dart';
import 'package:ecomik/screens/checkout_screen.dart';
import 'package:ecomik/screens/contact_us.dart';
import 'package:ecomik/screens/country_screen.dart';
import 'package:ecomik/screens/create_delivery_request_screen.dart';
import 'package:ecomik/screens/currency_screen.dart';
import 'package:ecomik/screens/delete_account.dart';
import 'package:ecomik/screens/delivery_info_screen.dart';
import 'package:ecomik/screens/delivery_request_details_screen.dart';
import 'package:ecomik/screens/delivery_request_list_screen.dart';
import 'package:ecomik/screens/delivery_request_screen.dart';
import 'package:ecomik/screens/delivery_set_location_screen.dart';
import 'package:ecomik/screens/demochat.dart';
import 'package:ecomik/screens/edit_my_account_screen.dart';
import 'package:ecomik/screens/ending_soon_screen.dart';
import 'package:ecomik/screens/enter_phone_number_for_google_screen.dart';
import 'package:ecomik/screens/enter_phone_number_screen.dart';
import 'package:ecomik/screens/flash_sell.dart';
import 'package:ecomik/screens/home_navigator_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/cart_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/categories.dart';
import 'package:ecomik/screens/home_navigator_screens/chat_deliveryman_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/home_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/message_recipients_screen.dart';
import 'package:ecomik/screens/home_navigator_screens/my_account_screen.dart';
import 'package:ecomik/screens/image_zoom.dart';
import 'package:ecomik/screens/intro_screen.dart';
import 'package:ecomik/screens/langauge_screen.dart';
import 'package:ecomik/screens/my_orders_screen.dart';
import 'package:ecomik/screens/my_wallet_screen.dart';
import 'package:ecomik/screens/notification.dart';
import 'package:ecomik/screens/order_placed_success_screen.dart';
import 'package:ecomik/screens/order_status.dart';
import 'package:ecomik/screens/password_change_success_screen.dart';
import 'package:ecomik/screens/password_recovery_screens/password_recovery_create_password_screen.dart';
import 'package:ecomik/screens/password_recovery_screens/password_recovery_email_prompt_screen.dart';
import 'package:ecomik/screens/password_recovery_screens/password_recovery_prompt_screen.dart';
import 'package:ecomik/screens/password_recovery_screens/password_recovery_select_screen.dart';
import 'package:ecomik/screens/password_recovery_screens/password_recovery_verification_screen.dart';
import 'package:ecomik/screens/policy.dart';
import 'package:ecomik/screens/privacypolicy.dart';
import 'package:ecomik/screens/product_detail_screen.dart';
import 'package:ecomik/screens/product_page.dart';
import 'package:ecomik/screens/product_page_two.dart';
import 'package:ecomik/screens/returnpolicy.dart';
import 'package:ecomik/screens/review_success_screen.dart';
import 'package:ecomik/screens/saved_address_screen.dart';
import 'package:ecomik/screens/saved_address_select_manual_location_second.dart';
import 'package:ecomik/screens/seller_single.dart';
import 'package:ecomik/screens/send_offer_list.dart';
import 'package:ecomik/screens/set_new_address_location.dart';
import 'package:ecomik/screens/settings_screen.dart';
import 'package:ecomik/screens/shipping_address_1st.dart';
import 'package:ecomik/screens/shipping_address_2nd.dart';
import 'package:ecomik/screens/shoppingpolicy.dart';
import 'package:ecomik/screens/sign_in_screen.dart';
import 'package:ecomik/screens/sign_up_screen.dart';
import 'package:ecomik/screens/sign_up_success_screen.dart';
import 'package:ecomik/screens/single_product_review_screen.dart';
import 'package:ecomik/screens/storeShortrReview.dart';
import 'package:ecomik/screens/store_reviews_screen.dart';
import 'package:ecomik/screens/support_Ticket_create.dart';
import 'package:ecomik/screens/terms_condition.dart';
import 'package:ecomik/screens/top_brand_single.dart';
import 'package:ecomik/screens/top_brands.dart';
import 'package:ecomik/screens/top_sellers.dart';
import 'package:ecomik/screens/track_recent_delivery_request_screen.dart';
import 'package:ecomik/screens/unknown_screen.dart';
import 'package:ecomik/screens/wishlist_screen.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:get/get.dart';

import '../screens/splash_screen.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(name: AppPageNames.rootScreen, page: () => const SplashScreen()),
    GetPage(name: AppPageNames.splashScreen, page: () => const SplashScreen()),
    GetPage(name: AppPageNames.introScreen, page: () => const IntroScreen()),
    GetPage(name: AppPageNames.signInScreen, page: () => const SignInScreen()),
    GetPage(name: AppPageNames.signUpScreen, page: () => const SignUpScreen()),
    GetPage(
        name: AppPageNames.saveManualAddressSecondScreen,
        page: () => const SaveManualAddressSecondScreen()),
    GetPage(
        name: AppPageNames.setNewAddressLocationScreen,
        page: () => const SetNewAddressLocationScreen()),
    GetPage(
        name: AppPageNames.signUpSuccessScreen,
        page: () => const SignUpSuccessScreen()),
    GetPage(
        name: AppPageNames.passwordChangeSuccessScreen,
        page: () => const SignUpScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryPromptScreen,
        page: () => const PasswordRecoveryPromptScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryEmailScreen,
        page: () => const PasswordRecoveryEmailPromptScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryVerificationScreen,
        page: () => const PasswordRecoveryVerificationScreen()),
    GetPage(
        name: AppPageNames.passwordRecoverySelectScreen,
        page: () => const PasswordRecoverySelectScreen()),
    GetPage(
        name: AppPageNames.passwordRecoveryCreateScreen,
        page: () => const PasswordRecoveryCreatePasswordScreen()),
    GetPage(
        name: AppPageNames.deleteAccountScreen,
        page: () => const DeleteAccountScreen()),
    GetPage(
        name: AppPageNames.sendOfferListScreen,
        page: () => const SendOfferListScreen()),
    GetPage(
        name: AppPageNames.contactUsScreen,
        page: () => const ContactUsScreen()),
    GetPage(
        name: AppPageNames.countryScreen, page: () => const CountryScreen()),
    GetPage(
        name: AppPageNames.notificationScreen,
        page: () => const NotificationScreen()),
    GetPage(
        name: AppPageNames.aboutUsScreen, page: () => const AboutUsScreen()),
    // GetPage(
    //     name: AppPageNames.productsScreen, page: () => const ProductsScreen()),
    GetPage(
        name: AppPageNames.orderSuccessScreen,
        page: () => const OrderPlacedSuccessScreen()),
    GetPage(
        name: AppPageNames.supportScreen, page: () => const SupportScreen()),
    GetPage(
        name: AppPageNames.addReviewScreen,
        page: () => const AddReviewScreen()),
    GetPage(
        name: AppPageNames.reviewSuccessScreen,
        page: () => const ReviewSuccessScreen()),
    GetPage(
        name: AppPageNames.termsConditionScreen,
        page: () => const TermsConditionScreen()),
    GetPage(
        name: AppPageNames.editMyAccountScreen,
        page: () => const EditMyAccountScreen()),
    GetPage(
        name: AppPageNames.endingSoonScreen,
        page: () => const EndingSoonScreen()),
    GetPage(
        name: AppPageNames.soppingPolicyScreen,
        page: () => const SoppingPolicyScreen()),
    GetPage(
        name: AppPageNames.returnPolicyScreen,
        page: () => const ReturnPolicyScreen()),
    GetPage(name: AppPageNames.policyScreen, page: () => const PolicyScreen()),
    GetPage(
        name: AppPageNames.cancellationScreen,
        page: () => const CancellationScreen()),
    GetPage(
        name: AppPageNames.addAddressScreen,
        page: () => const AddAddressScreen()),
    GetPage(
        name: AppPageNames.addMoneyScreen, page: () => const AddMoneyScreen()),
    GetPage(
        name: AppPageNames.currencyScreen, page: () => const CurrencyScreen()),
    GetPage(
        name: AppPageNames.settingsScreen, page: () => const SettingsScreen()),
    GetPage(
        name: AppPageNames.languageScreen, page: () => const LanguageScreen()),
    GetPage(
        name: AppPageNames.myWalletScreen, page: () => const MyWalletScreen()),
    GetPage(
        name: AppPageNames.supportTicketScreen,
        page: () => const SupportTicketCreateScreen()),
    GetPage(
        name: AppPageNames.passwordChangSuccessScreen,
        page: () => const PasswordChangSuccessScreen()),
    GetPage(
        name: AppPageNames.ticketStatusScreen,
        page: () => const TicketStatusScreen()),
    GetPage(
        name: AppPageNames.privacyPolicyScreen,
        page: () => const PrivacyPolicyScreen()),
    GetPage(
        name: AppPageNames.savedAddressScreen,
        page: () => const SavedAddressScreen()),
    GetPage(
        name: AppPageNames.sellerShortReviewScreenPage,
        page: () => const SellerShortReviewScreenPage()),
    GetPage(
        name: AppPageNames.storeReviewsScreen,
        page: () => const StoreReviewsScreen()),
    GetPage(
        name: AppPageNames.sellerSingleScreenPage,
        page: () => const SellerSingleScreenPage()),
    GetPage(
        name: AppPageNames.orderStatusScreen,
        page: () => const OrderStatusScreen()),
    GetPage(
        name: AppPageNames.productDetailsScreen,
        page: () => const ProductDetailsScreen()),
    GetPage(
        name: AppPageNames.productPageTwo, page: () => const ProductPageTwo()),
    GetPage(
        name: AppPageNames.checkoutScreen, page: () => const CheckoutScreen()),
    GetPage(
        name: AppPageNames.addNewCardScreen,
        page: () => const AddNewCardScreen()),
    GetPage(
        name: AppPageNames.deliverySetLocationScreen,
        page: () => const DeliverySetLocationScreen()),
    GetPage(
        name: AppPageNames.demoChatScreen, page: () => const DemoChatScreen()),
    GetPage(
        name: AppPageNames.deliveryInfoScreen,
        page: () => const DeliveryInfoScreen()),
    GetPage(
        name: AppPageNames.chatWithDeliverymanScreen,
        page: () => const ChatDeliverymanScreen()),

    GetPage(name: AppPageNames.callScreen, page: () => const CallScreen()),
    GetPage(
        name: AppPageNames.deliveryRequestListScreen,
        page: () => const DeliveryRequestListScreen()),
    GetPage(
        name: AppPageNames.homeNavigatorScreen,
        page: () => const HomeNavigatorScreen()),
    GetPage(
        name: AppPageNames.singleProductReviewsScreen,
        page: () => const SingleProductReviewsScreen()),
    GetPage(
        name: AppPageNames.categoryScreen, page: () => const CategoriesPage()),
    GetPage(name: AppPageNames.auctionPage, page: () => const AuctionProduct()),
    GetPage(
        name: AppPageNames.productDetailsScreen,
        page: () => const ProductDetailsScreen()),
    GetPage(
        name: AppPageNames.bidDetails, page: () => const BidDetailsScreen()),
    GetPage(name: AppPageNames.bidFilter, page: () => const BidFilter()),
    GetPage(name: AppPageNames.bidPopup, page: () => const BidPopup()),
    GetPage(
        name: AppPageNames.bidProductDetailsScreen,
        page: () => const BidProductDetailsScreen()),
    GetPage(
        name: AppPageNames.bidWaletScreen, page: () => const BidWaletScreen()),
    GetPage(
        name: AppPageNames.productDetailsScreen,
        page: () => const ProductDetailsScreen()),
    GetPage(name: AppPageNames.cartScreen, page: () => const CartScreen()),
    GetPage(
        name: AppPageNames.flashSellScreen,
        page: () => const FlashSellScreen()),
    GetPage(name: AppPageNames.homeScreen, page: () => const HomeScreen()),
    GetPage(
        name: AppPageNames.myAccountScreen,
        page: () => const MyAccountScreen()),
    GetPage(
        name: AppPageNames.myOrdersScreen, page: () => const MyOrdersScreen()),
    GetPage(
        name: AppPageNames.topBrandsPage, page: () => const TopBrandsPage()),
    GetPage(
        name: AppPageNames.deliveryRequestScreen,
        page: () => const DeliveryRequestScreen()),
    GetPage(
        name: AppPageNames.deliveryRequestDetailsScreen,
        page: () => const DeliveryRequestDetailsScreen()),
    GetPage(
        name: AppPageNames.createDeliveryRequestScreen,
        page: () => const CreateDeliveryRequestScreen()),
    GetPage(
        name: AppPageNames.topBrandSingle, page: () => const TopBrandSingle()),
    GetPage(
        name: AppPageNames.topSellersScreenPage,
        page: () => const TopSellersScreenPage()),
    GetPage(
        name: AppPageNames.wishlistScreen, page: () => const WishlistScreen()),
    GetPage(name: AppPageNames.bidAuction, page: () => const BidAuction()),
    GetPage(
        name: AppPageNames.trackRecentDeliveryRequestScreen,
        page: () => const TrackRecentDeliveryRequestScreen()),
    GetPage(
        name: AppPageNames.shipping1stScreen,
        page: () => const ShippingAddress1stScreen()),
    GetPage(
        name: AppPageNames.shipping2ndScreen,
        page: () => const ShippingAddress2ndScreen()),
    GetPage(
        name: AppPageNames.allPickupScreen,
        page: () => const AllPickupScreen()),
    GetPage(name: AppPageNames.productPage, page: () => const ProductPage()),
    GetPage(
        name: AppPageNames.imageScreen, page: () => const ImageZoomScreen()),
    GetPage(
        name: AppPageNames.enterPhoneNumberScreen,
        page: () => const EnterPhoneNumberScreen()),
    GetPage(
        name: AppPageNames.chatRecipientsScreen,
        page: () => const MessageRecipientsScreen()),
    GetPage(
        name: AppPageNames.enterPhoneNumberForGoogleLoginScreen,
        page: () => const EnterPhoneNumberForGoogleLoginScreen()),
  ];

  static final GetPage<dynamic> unknownScreenPageRoute = GetPage(
      name: AppPageNames.unknownScreen, page: () => const UnknownScreen());
}
