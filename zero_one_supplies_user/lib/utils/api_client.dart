import 'package:ecomik/utils/constants/app_constants.dart';
import 'package:get/get.dart';

// class APIClient extends GetConnect {
class APIClient {
  static APIClient? _instance;
  GetHttpClient _appAPIClient = GetHttpClient();

  APIClient._() {
    _appAPIClient = GetHttpClient(
      timeout: const Duration(minutes: 1),
      baseUrl: Constants.appBaseURL,
    );
  }

  static APIClient get instance => _instance ??= APIClient._();

  GetHttpClient getAPIClient() => _appAPIClient;
}
