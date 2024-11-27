import 'dart:convert';
import 'dart:developer';

import 'package:ecomik/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:ecomik/models/api_responses/user_notification_response.dart';
import 'package:ecomik/models/enums.dart';
import 'package:ecomik/utils/api_repo.dart';
import 'package:ecomik/utils/constants/app_language_translations.dart';
import 'package:ecomik/utils/constants/app_page_names.dart';
import 'package:ecomik/utils/extensions/string.dart';
import 'package:ecomik/utils/helpers/api_helper.dart';
import 'package:ecomik/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UserNotificationScreenController extends GetxController {
  final PagingController<int, UserNotificationDocResponse>
      userNotificationPagingController = PagingController(firstPageKey: 1);
  RxBool hasBackButton = false.obs;
  UserNotificationDocResponse? previousNotification(
      int currentIndex, UserNotificationDocResponse notification) {
    final previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      return null;
    }
    UserNotificationDocResponse? previousNotification =
        userNotificationPagingController.value.itemList?[previousIndex];
    return previousNotification;
    // return notification.previousNotification;
  }

  bool isNotificationDateChanges(UserNotificationDocResponse notification,
      UserNotificationDocResponse? previousNotification) {
    if (previousNotification == null) {
      return true;
    }
    Duration dateDifference =
        notification.createdAt.difference(previousNotification.createdAt);
    return (dateDifference.inDays >= 1 || (dateDifference.inDays <= -1));
  }

  void onNotificationTap(UserNotificationDocResponse notification) {
    readNotification(notification.id);
    switch (notification.notificationType) {
      case NotificationType.confirmOrder:
        Get.toNamed(AppPageNames.myOrdersScreen, arguments: 3);
        break;
      case NotificationType.delivery:
        Get.toNamed(AppPageNames.myOrdersScreen, arguments: 7);
        break;
      case NotificationType.order:
        Get.toNamed(AppPageNames.myOrdersScreen);
        break;
      default:
        Get.toNamed(AppPageNames.myOrdersScreen);
    }
  }

  Future<void> readNotification(String notificationID) async {
    final Map<String, Object> requestBody = {
      'notification_id': notificationID,
      'read': true,
    };
    String requestBodyJson = jsonEncode(requestBody);
    RawAPIResponse? response = await APIRepo.readNotification(requestBodyJson);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessReadNotification(response);
  }

  void _onSuccessReadNotification(RawAPIResponse response) {
    // Helper.showSnackBar(response.msg);
    userNotificationPagingController.refresh();
  }

  Future<void> getNotifications(int currentPageNumber) async {
    UserNotificationResponse? response =
        await APIRepo.getUserNotifications(currentPageNumber);
    if (response == null) {
      AppDialogs.showErrorDialog(
          messageText:
              AppLanguageTranslation.noResponseTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      AppDialogs.showErrorDialog(messageText: response.msg);
      return;
    }
    // log(response.toJson().toString());
    _onSuccessRetrievingResponse(response);
  }

  _onSuccessRetrievingResponse(UserNotificationResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      userNotificationPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    userNotificationPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is bool) {
      hasBackButton.value = true;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    userNotificationPagingController.addPageRequestListener((pageKey) {
      getNotifications(pageKey);
    });

    super.onInit();
  }
}
