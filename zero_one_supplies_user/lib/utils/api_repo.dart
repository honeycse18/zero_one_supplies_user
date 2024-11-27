import 'dart:convert';
import 'dart:io';

import 'package:ecomik/models/api_responses/about_us_response.dart';
import 'package:ecomik/models/api_responses/active_auction_response.dart';
import 'package:ecomik/models/api_responses/auction_product_details_response.dart';
import 'package:ecomik/models/api_responses/auctions_response.dart';
import 'package:ecomik/models/api_responses/bid_details_response.dart';
import 'package:ecomik/models/api_responses/brands_response.dart';
import 'package:ecomik/models/api_responses/carts_response.dart';
import 'package:ecomik/models/api_responses/cash_on_delivery_order_response.dart';
import 'package:ecomik/models/api_responses/categories_response.dart';
import 'package:ecomik/models/api_responses/chat_recipients.dart';
import 'package:ecomik/models/api_responses/checkout_details_response.dart';
import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/coupon_applied_response.dart';
import 'package:ecomik/models/api_responses/dash_board_response.dart';
import 'package:ecomik/models/api_responses/delivery_requests_response.dart';
import 'package:ecomik/models/api_responses/distance_calculation_result_response.dart';
import 'package:ecomik/models/api_responses/edit_accound_response.dart';
import 'package:ecomik/models/api_responses/ending_soon_response.dart';
import 'package:ecomik/models/api_responses/home_auction_response.dart';
import 'package:ecomik/models/api_responses/language_translations_response.dart';
import 'package:ecomik/models/api_responses/languages_response.dart';
import 'package:ecomik/models/api_responses/mixed_product_auction_response.dart';
import 'package:ecomik/models/api_responses/my_order_response.dart';
import 'package:ecomik/models/api_responses/order_create_response.dart';
import 'package:ecomik/models/api_responses/otp_verify_response.dart';
import 'package:ecomik/models/api_responses/payment_credentials.dart';
import 'package:ecomik/models/api_responses/pickup_stations_response.dart';
import 'package:ecomik/models/api_responses/pickup_stations_with_cost_response.dart';
import 'package:ecomik/models/api_responses/product_details_response.dart';
import 'package:ecomik/models/api_responses/product_order_response.dart';
import 'package:ecomik/models/api_responses/product_page_response.dart';
import 'package:ecomik/models/api_responses/product_tag.dart';
import 'package:ecomik/models/api_responses/products_with_tags_response.dart';
import 'package:ecomik/models/api_responses/remove_favorite_response.dart';
import 'package:ecomik/models/api_responses/reset_pass_create_new_pass_response.dart';
import 'package:ecomik/models/api_responses/reset_password_otp_response.dart';
import 'package:ecomik/models/api_responses/review_count_response.dart';
import 'package:ecomik/models/api_responses/saved_address_response.dart';
import 'package:ecomik/models/api_responses/saved_addresses_with_cost_response.dart';
import 'package:ecomik/models/api_responses/seller_list_response.dart';
import 'package:ecomik/models/api_responses/send_an_offer_list_response.dart';
import 'package:ecomik/models/api_responses/send_otp_response.dart';
import 'package:ecomik/models/api_responses/sign_up_otp_verification_response.dart';
import 'package:ecomik/models/api_responses/signin_response.dart';
import 'package:ecomik/models/api_responses/single_brand_by_id_response.dart';
import 'package:ecomik/models/api_responses/single_image_upload_response.dart';
import 'package:ecomik/models/api_responses/single_order_response.dart';
import 'package:ecomik/models/api_responses/single_product_order_response.dart';
import 'package:ecomik/models/api_responses/single_product_review_response.dart';
import 'package:ecomik/models/api_responses/single_seller_response.dart';
import 'package:ecomik/models/api_responses/site_settings_response.dart';
import 'package:ecomik/models/api_responses/store_reviews_response.dart';
import 'package:ecomik/models/api_responses/store_wise_carts_response.dart';
import 'package:ecomik/models/api_responses/stored_grouped_carts_response.dart';
import 'package:ecomik/models/api_responses/subcategory_children_response.dart';
import 'package:ecomik/models/api_responses/subcategory_response.dart';
import 'package:ecomik/models/api_responses/toogle_add_to_favourite_response.dart';
import 'package:ecomik/models/api_responses/user_notification_response.dart';
import 'package:ecomik/models/api_responses/user_sign_up_response.dart';
import 'package:ecomik/models/api_responses/vendor_details_response.dart';
import 'package:ecomik/models/api_responses/wishlist_response.dart';
import 'package:ecomik/models/api_responses/won_auction_response.dart';
import 'package:ecomik/models/bottom_sheet_parameters/auction_bid_filter_parameter.dart';
import 'package:ecomik/utils/api_client.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class APIRepo {
  static Future<SignInResponse?> login(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response =
          await apiHttpClient.post('api/user/login', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SignInResponse responseModel =
          SignInResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> logout(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient.post('api/user/logout',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SignInResponse?> googleLogin(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/social-login', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SignInResponse responseModel =
          SignInResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UserSignUpResponse?> signUp(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await apiHttpClient.post('api/user/signup', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserSignUpResponse responseModel =
          UserSignUpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UserDetailsResponse?> getUserDetails(
      {String token = ''}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/user/verify',
          headers: token.isNotEmpty
              ? {'Authorization': 'Bearer $token'}
              : APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserDetailsResponse responseModel =
          UserDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ReviewCountResponse?> getReviewCount(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/store',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ReviewCountResponse responseModel =
          ReviewCountResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SingleProductReviewResponse?> getSingleProductReview(
      int page, String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'product': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/reviews',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SingleProductReviewResponse responseModel =
          SingleProductReviewResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<StoreReviewsResponse?> getStoreReview(
      int page, String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$page', '_id': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/store/product-reviews',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final StoreReviewsResponse responseModel =
          StoreReviewsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SingleProductReviewResponse?> getSingleProductReviewResponse(
      int page, String product) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$page', 'product': product};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/reviews',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SingleProductReviewResponse responseModel =
          SingleProductReviewResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SiteSettingsResponse?> getSiteSettings() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/settings/site');

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SiteSettingsResponse responseModel =
          SiteSettingsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<PaymentCredentialsResponse?> getPaymentCredentials() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/settings/payment-credentials',
          headers:
              Helper.isUserLoggedIn() ? APIHelper.getAuthHeaderMap() : null);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final PaymentCredentialsResponse responseModel =
          PaymentCredentialsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SavedAddressResponse?> getSavedAddress() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient
          .get('api/user/address-books', headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SavedAddressResponse responseModel =
          SavedAddressResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> removeSavedAddress(String addressID) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': addressID};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.delete(
          'api/user/address-book',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AuctionsResponse?> getAuctions(
      int page, String search, String isAuction,
      {AuctionBidFilterParameter? filterOptions}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$page',
        'is_auction': isAuction
      };
      if (search.isNotEmpty) {
        queries['search'] = search;
      }
      if (filterOptions != null) {
        if (filterOptions.selectedCategoryOption.id.isNotEmpty) {
          queries['category'] = filterOptions.selectedCategoryOption.id;
        }
        if (filterOptions.selectedSubCategoryOption.id.isNotEmpty) {
          queries['subcategory'] = filterOptions.selectedSubCategoryOption.id;
        }
        if (filterOptions.selectedOptions.isNotEmpty) {
          String filter = filterOptions.selectedOptions;
          if (filterOptions.selectedOptions == 'highToLow') {
            filter = 'high_price';
          } else if (filterOptions.selectedOptions == 'lowToHigh') {
            filter = 'low_price';
          }
          queries[filter] = 'true';
          // queries['filtering'] = filterOptions
          //     .selectedOptions;
          //1. highToLow 2. lowToHigh 3. a2z 4. z2a
        }
        if (filterOptions.selectedRangeValues.start != 0 ||
            filterOptions.selectedRangeValues.end < 100000) {
          queries['price_from'] =
              filterOptions.selectedRangeValues.start.toString();
          queries['price_to'] =
              filterOptions.selectedRangeValues.end.toString();
        }
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          // 'api/product/auction/all',
          'api/product/all',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AuctionsResponse responseModel =
          AuctionsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<HomeAuctionsResponse?> getHomeAuctions(
      [String search = '', String endAuctionList = '']) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'limit': '10',
        'ending_soon': endAuctionList
      };
      if (search.isNotEmpty) {
        queries['search'] = search;
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          // 'api/product/auction/all',
          'api/frontend/auction-products',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final HomeAuctionsResponse responseModel =
          HomeAuctionsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<HomeAuctionsResponse?> getEndingHomeAuctions(
      [String search = '']) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'limit': '10',
        'ending_soon': 'true'
      };
      if (search.isNotEmpty) {
        queries['search'] = search;
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          // 'api/product/auction/all',
          'api/frontend/auction-products',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final HomeAuctionsResponse responseModel =
          HomeAuctionsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ActiveAuctionResponse?> getActiveAuctions(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/auction/user-bids',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ActiveAuctionResponse responseModel =
          ActiveAuctionResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WonAuctionResponse?> getWonAuctions(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/auction/user-winning-bids',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final WonAuctionResponse responseModel =
          WonAuctionResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductAuctionMixedResponse?> getProducts(
      int page, String search,
      {AuctionBidFilterParameter? filterOptions}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};
      if (search.isNotEmpty) {
        queries['search'] = search;
      }
      if (filterOptions != null) {
        if (filterOptions.selectedCategoryOption.id.isNotEmpty) {
          queries['category'] = filterOptions.selectedCategoryOption.id;
        }
        if (filterOptions.selectedSubCategoryOption.id.isNotEmpty) {
          queries['subcategory'] = filterOptions.selectedSubCategoryOption.id;
        }
        if (filterOptions.selectedOptions.isNotEmpty) {
          queries['filtering'] = filterOptions
              .selectedOptions; //1. highToLow 2. lowToHigh 3. a2z 4. z2a
        }
        if (filterOptions.selectedRangeValues.start != 0 ||
            filterOptions.selectedRangeValues.end < 100000) {
          queries['price_from'] =
              filterOptions.selectedRangeValues.start.toString();
          queries['price_to'] =
              filterOptions.selectedRangeValues.end.toString();
        }
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/all',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductAuctionMixedResponse responseModel =
          ProductAuctionMixedResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductPageResponse?> getSimpleProducts(int page, String search,
      {AuctionBidFilterParameter? filterOptions}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};
      if (search.isNotEmpty) {
        queries['search'] = search;
      }
      if (filterOptions != null) {
        if (filterOptions.selectedCategoryOption.id.isNotEmpty) {
          queries['category'] = filterOptions.selectedCategoryOption.id;
        }
        if (filterOptions.selectedSubCategoryOption.id.isNotEmpty) {
          queries['subcategory'] = filterOptions.selectedSubCategoryOption.id;
        }
        if (filterOptions.selectedOptions.isNotEmpty) {
          queries['filtering'] = filterOptions
              .selectedOptions; //1. highToLow 2. lowToHigh 3. a2z 4. z2a
        }
        if (filterOptions.selectedRangeValues.start != 0 ||
            filterOptions.selectedRangeValues.end < 100000) {
          queries['price_from'] =
              filterOptions.selectedRangeValues.start.toString();
          queries['price_to'] =
              filterOptions.selectedRangeValues.end.toString();
        }
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/all',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductPageResponse responseModel =
          ProductPageResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductsWithTagsResponse?> getProductsWithTags(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/list/tags-products',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductsWithTagsResponse responseModel =
          ProductsWithTagsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductPageResponse?> getProductsUnderCriteria(
    int page,
    String search, {
    String? brandId,
    String? sellerId,
    String? flashDeal,
    String? childCategory,
  }) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};
      if (search.isNotEmpty) {
        queries['search'] = search;
      }

      if (brandId != null) {
        queries['brand'] = brandId;
      }
      // This parameter call is changed to getProductsUnderStore() now  DON'T USE this param
      if (sellerId != null) {
        queries['seller'] = sellerId;
      }
      if (flashDeal != null) {
        queries['flash_deal'] = 'true';
      }
      if (childCategory != null) {
        queries['child_category'] = childCategory;
      }
      /* if (filterOptions.selectedRangeValues.start != 0 ||
            filterOptions.selectedRangeValues.end < 100000) {
          queries['price_from'] =
              filterOptions.selectedRangeValues.start.toString();
          queries['price_to'] =
              filterOptions.selectedRangeValues.end.toString();
        } */
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/all',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductPageResponse responseModel =
          ProductPageResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductPageResponse?> getProductsUnderStore(int page,
      {String? sellerId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};
      if (sellerId != null) {
        queries['_id'] = sellerId;
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/store/products',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductPageResponse responseModel =
          ProductPageResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<EndingSoonResponse?> getEndingSoon(
      int page, String search, String isAuction) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$page',
        'is_auction': isAuction
      };
      if (search.isNotEmpty) {
        queries['search'] = search;
      }

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/all',
          // api/product/auction/all?ending_soon=true
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final EndingSoonResponse responseModel =
          EndingSoonResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SendAnOfferListResponse?> getSendOfferList(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/make-an-offer/user-list',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SendAnOfferListResponse responseModel =
          SendAnOfferListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DashBoardResponse?> getDashBoardResponse() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found

      await APIHelper.preAPICallCheck();
      // final Map<String, String> queries = {'page': '$page'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/frontend/dashboard-app',
          headers:
              Helper.isUserLoggedIn() ? APIHelper.getAuthHeaderMap() : null);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final DashBoardResponse responseModel =
          DashBoardResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SingleProductOrderResponse?> getSingleOrder(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found

      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};
      // final Map<String, String> queries = {'page': '$page'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/order/by-id',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SingleProductOrderResponse responseModel =
          SingleProductOrderResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SingleBrandByIdResponse?> getTopBrand(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/brands',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SingleBrandByIdResponse responseModel =
          SingleBrandByIdResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductDetailsResponse?> getProductDetails(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/details',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      jsonEncode(response.body);
      APIHelper.postAPICallCheck(response);
      // jsonEncode(response);
      final ProductDetailsResponse responseModel =
          ProductDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AboutUsResponse?> getAboutUs(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/about-us/get-one',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> postReview(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/rating',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> sendAnOffer(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/product/make-an-offer',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AboutUsResponse?> getTermsCondition(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/about-us/get-one',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> deleteAccount() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.delete(
          'api/user/temporary-delete',
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AboutUsResponse?> getReturnPolicy(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/about-us/get-one',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AboutUsResponse?> getPrivacyPolicy(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/about-us/get-one',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  // static Future<FlashSellsResponse?> getFlashSell(int page) async {
  //   try {
  //     // Before calling API method, checks for any issues, errors and throw if
  //     // found
  //     await APIHelper.preAPICallCheck();
  //     final Map<String, String> queries = {'page': '$page'};

  //     final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
  //     final Response response = await apiHttpClient.get(
  //         'api/product/all?flash_deal=true',
  //         query: queries,
  //         headers: APIHelper.getAuthHeaderMap());

  //     // After post API call checking, any issues, errors found throw exception
  //     APIHelper.postAPICallCheck(response);
  //     final FlashSellsResponse responseModel =
  //         FlashSellsResponse.getAPIResponseObjectSafeValue(response.body);
  //     if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
  //       responseModel.error = true;
  //     }
  //     return responseModel;
  //   } catch (exception) {
  //     APIHelper.handleExceptions(exception);
  //     return null;
  //   }
  // }

  static Future<SellerListResponse?> getTopSeller(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/store/list-short-info',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SellerListResponse responseModel =
          SellerListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<BrandListsResponse?> getTopBrands(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/brands',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final BrandListsResponse responseModel =
          BrandListsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ResetPasswordOtpResponse?> sendResetOtp(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/send-reset-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ResetPasswordOtpResponse responseModel =
          ResetPasswordOtpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductDetailsResponse?> getProductDetailsResponse(
      String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/details-app',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductDetailsResponse responseModel =
          ProductDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<OtpVerifyResponse?> verifyOtpForResetPass(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/verify-reset-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpVerifyResponse responseModel =
          OtpVerifyResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SendOtpResponse?> sendVerifyUserOTP(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/signup-resend-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SendOtpResponse responseModel =
          SendOtpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SignUpOtpVerificationResponse?> signUpOtpVerification(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/signup-otp-verify', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SignUpOtpVerificationResponse responseModel =
          SignUpOtpVerificationResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SendOtpResponse?> sendVerifyVendorOTP(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient
          .post('api/user/signup-resend-otp', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SendOtpResponse responseModel =
          SendOtpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AuctionProductDetailsResponse?> fetchAuctionDetails(
      String bidID) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      // final Map<String, String> queries = {'_id': bidID};
      final Map<String, String> queries = {'product': bidID};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          /* 'api/product/auction/details', */
          'api/product/auction',
          headers: APIHelper.getAuthHeaderMap(),
          query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AuctionProductDetailsResponse responseModel =
          AuctionProductDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> applyBid(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/product/auction/bid-apply',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ResetPassCreateNewPassResponse?> resetPassCreateNewPass(
      String requestJsonString, String authToken) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      final Response response = await apiHttpClient.post(
          'api/user/password-reset-by-otp',
          body: requestJsonString,
          headers: {'Authorization': 'Bearer $authToken'});

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ResetPassCreateNewPassResponse responseModel =
          ResetPassCreateNewPassResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CouponAppliedResponse?> applyCoupon(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/coupon/apply',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CouponAppliedResponse responseModel =
          CouponAppliedResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<StoreWiseCartsResponse?> applyStoreWiseCartCoupon(
      String requestCouponsJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/cart/list/store-wise',
          query: {'coupons': requestCouponsJsonString},
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final StoreWiseCartsResponse responseModel =
          StoreWiseCartsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<OrderCreateResponse?> createOrder(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/order/create',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OrderCreateResponse responseModel =
          OrderCreateResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WishlistResponse?> getWishlist(
      int page, bool isAuctionSelected) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$page',
        'isAuction': isAuctionSelected.toString()
      };

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/favorite/list',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final WishlistResponse responseModel =
          WishlistResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RemoveFavoriteResponse?> removeFromWishlist(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.delete('api/favorite',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RemoveFavoriteResponse responseModel =
          RemoveFavoriteResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ToggleAddToFavoriteResponse?> toggleAddToFav(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/favorite',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ToggleAddToFavoriteResponse responseModel =
          ToggleAddToFavoriteResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CategoriesResponse?> getCategoriesAPICall(int pageNumber,
      {int? size}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$pageNumber'};
      if (size != null) {
        queries['size'] = '$size';
      }

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/categories',
          headers: APIHelper.getAuthHeaderMap(),
          query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CategoriesResponse responseModel =
          CategoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductTagResponse?> getTagsAPICall(
    int pageNumber,
  ) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$pageNumber'};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/product/tags',
          headers: APIHelper.getAuthHeaderMap(), query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductTagResponse responseModel =
          ProductTagResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SubcategoryResponse?> getSubcategoriesAPICall(
      int pageNumber, String parentId,
      {int? size}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$pageNumber',
        'parent': parentId
      };
      if (size != null) {
        queries['size'] = '$size';
      }

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/categories',
          headers: APIHelper.getAuthHeaderMap(),
          query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SubcategoryResponse responseModel =
          SubcategoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SubcategoryChildrenResponse?> getSubcategoryChildren(
      int pageNumber, String parentId) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$pageNumber',
        'subcategory': parentId
      };

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/product/child-categories',
          headers: APIHelper.getAuthHeaderMap(),
          query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SubcategoryChildrenResponse responseModel =
          SubcategoryChildrenResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> submitAddress(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/user/address-book',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> submitContactUsMassage(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/contact-us',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ProductOrderResponse?> getMyOrderResponses(
      int pageNumber, String filter) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$pageNumber',
        'status': filter
      };
      /*  if (filter.isNotEmpty) {
        queries[filter] = 'true';
      } */

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/order/get-user-wise/product-orders',
          headers: APIHelper.getAuthHeaderMap(),
          query: queries);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ProductOrderResponse responseModel =
          ProductOrderResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UserNotificationResponse?> getUserNotifications(
      int pageNumber) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$pageNumber'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/notification/user/list',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserNotificationResponse responseModel =
          UserNotificationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readNotification(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/notification/update-read',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SingleImageUploadResponse?> uploadImage(File imageFile,
      {String imageFileName = '', String id = ''}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final String fileName;
      final formDataMap = <String, dynamic>{};
      if (imageFileName.isNotEmpty) {
        formDataMap['image_name'] =
            path.basenameWithoutExtension(imageFileName);
        fileName = imageFileName;
      } else {
        fileName = path.basename(imageFile.path);
      }
      if (id.isNotEmpty) {
        formDataMap['_id'] = id;
      }
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      FormData formData = FormData({
        ...formDataMap,
        'image': MultipartFile(imageFile, filename: fileName),
      });
      final Response response = await apiHttpClient.post(
          'api/file/single-image-aws',
          body: formData,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SingleImageUploadResponse responseModel =
          SingleImageUploadResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DeliveryRequestsResponse?> getDeliveryRequestsList(
      int pageNumber) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Map<String, String> queries = {'page': '$pageNumber'};
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
          'api/delivery-request/user/list',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final DeliveryRequestsResponse responseModel =
          DeliveryRequestsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<EditAccountResponse?> editAccount(String requestJsonString,
      {String token = ''}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/user/update',
          body: requestJsonString,
          headers: token.isNotEmpty
              ? {'Authorization': 'Bearer $token'}
              : APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final EditAccountResponse responseModel =
          EditAccountResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CashOnDeliveryOrderResponse?> submitCashOnDeliveryOrder(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/payment/cash-on-delivery',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CashOnDeliveryOrderResponse responseModel =
          CashOnDeliveryOrderResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SingleSellerResponse?> getSingleSeller(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/store',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SingleSellerResponse responseModel =
          SingleSellerResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<PickupStationsResponse?> getPickupStations(int page) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$page',
        'size': '${100}',
      };

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/pickup-station',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final PickupStationsResponse responseModel =
          PickupStationsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DistanceCalculationResultResponse?>
      getDistanceCalculationResult(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/order/distance-calculation',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final DistanceCalculationResultResponse responseModel =
          DistanceCalculationResultResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguagesResponse?> fetchLanguages() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        'api/settings/all-languages',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguagesResponse responseModel =
          LanguagesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguageTranslationsResponse?>
      fetchLanguageTranslations() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        'api/settings/language/translations',
        headers: Helper.isUserLoggedIn() ? APIHelper.getAuthHeaderMap() : null,
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguageTranslationsResponse responseModel =
          LanguageTranslationsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addAProductToCart(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/cart',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateAProductFromCart(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/cart',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateAProductFromStoreWiseCart(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/cart',
          body: requestJsonString, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> removeAProductFromStoreWiseCart(
      String cartID, String productID) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.delete('api/cart',
          query: {'cart_id': cartID, 'product': productID},
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> removeAProductFromCart(String cartID) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.delete('api/cart',
          query: {'_id': cartID}, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

/*   static Future<RawAPIResponse?> removeAProductFromStoreWiseCart(
      String cartID, String productID) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final requestMap = <String, dynamic>{
        'cart_id': cartID,
        'decrease': true,
        'product': productID
      };
      final requestJson = jsonEncode(requestMap);
      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/cart',
          body: requestJson, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  } */

  static Future<CartsResponse?> getCartList() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        'api/cart/list',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CartsResponse responseModel =
          CartsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<StoreWiseCartsResponse?> getStoreWiseCarts() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        'api/cart/list/store-wise',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final StoreWiseCartsResponse responseModel =
          StoreWiseCartsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<StoredGroupedCartsResponse?> getStoreGroupedCartList(
      {Map<String, String>? queries}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        'api/cart/list/store-wise',
        query: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final StoredGroupedCartsResponse responseModel =
          StoredGroupedCartsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatRecipients?> getChatList({String vendorID = ''}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      Map<String, String>? queries;
      if (vendorID.isNotEmpty) {
        queries = {'vendor': vendorID};
      }
      final Response response = await apiHttpClient.get(
        'api/user/chat-list',
        query: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatRecipients responseModel =
          ChatRecipients.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> verifyStripePayment(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/payment/stripe-payment-verify',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> verifyPaypalPayment(
      String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
          'api/payment/paypal-payment-verify',
          body: requestJsonString,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SavedAddressesWithCostResponse?>
      getSavedAddressesWithCost() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // Map<String, String>? queries;
      final Response response = await apiHttpClient.get(
        'api/user/address-books/list/with-price-location',
        // query: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SavedAddressesWithCostResponse responseModel =
          SavedAddressesWithCostResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<PickupStationsWithCostResponse?>
      getPickupStationsWithCost() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      // Map<String, String>? queries;
      final Response response = await apiHttpClient.get(
        'api/pickup-station/list/calculated-delivery-fee',
        // query: queries,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final PickupStationsWithCostResponse responseModel =
          PickupStationsWithCostResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> uploadChatImage(String requestBodyJson) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post(
        'api/user/message/attach-file-send',
        headers: APIHelper.getAuthHeaderMap(),
        body: requestBodyJson,
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse objectResponse =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      return objectResponse;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> checkout(
      Map<String, dynamic> requestMap) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.post('api/cart/checkout',
          body: jsonEncode({'cartData': requestMap}),
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> clearCart() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.delete(
          'api/cart/clear-user-wise',
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> clearOfferItem(String offerId) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      final Map<String, String> queries = {
        '_id': offerId,
      };
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.delete(
          'api/product/make-an-offer/by-user',
          query: queries,
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CheckoutDetailsResponse?> getCheckoutDetails() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('api/cart/checkout',
          headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CheckoutDetailsResponse responseModel =
          CheckoutDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
}
