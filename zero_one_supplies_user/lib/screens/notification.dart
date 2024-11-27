import 'package:ecomik/controller/user_notification_screen_controller.dart';
import 'package:ecomik/models/api_responses/user_notification_response.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/helpers/language_helper.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:ecomik/widgets/screen_widgets/notifications_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserNotificationScreenController>(
        init: UserNotificationScreenController(),
        builder: (controller) => DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image:
                          Image.asset(AppAssetImages.backgroundFullPng).image,
                      fit: BoxFit.fill)),
              child: Scaffold(
                  appBar: CoreWidgets.appBarWidget(
                      hasBackButton:
                          controller.hasBackButton.value ? true : false,
                      screenContext: context,
                      titleWidget: Text(
                        LanguageHelper.currentLanguageText(
                            LanguageHelper.notificationTransKey),
                      )),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RefreshIndicator(
                        onRefresh: () async => controller
                            .userNotificationPagingController
                            .refresh(),
                        child: PagedListView.separated(
                          pagingController:
                              controller.userNotificationPagingController,
                          builderDelegate:
                              CoreWidgets.pagedChildBuilderDelegate<
                                  UserNotificationDocResponse>(
                            noItemFoundIndicatorBuilder: (context) {
                              return EmptyScreenWidget(
                                localImageAssetURL:
                                    AppAssetImages.noNotificationFound,
                                title: LanguageHelper.currentLanguageText(
                                    LanguageHelper.noNotificationTransKey),
                                shortTitle: '',
                              );
                            },
                            itemBuilder: (context, item, index) {
                              final notification = item;
                              final previousNotification =
                                  controller.previousNotification(index, item);
                              final bool isNotificationDateChanges =
                                  controller.isNotificationDateChanges(
                                      item, previousNotification);
                              return NotificationWidget(
                                status: notification
                                    .notificationData.notificationStatus,
                                orderNumber:
                                    notification.notificationData.orderNumber,
                                deliveryNumber: notification
                                    .notificationData.deliveryNumber,
                                dateTime: notification.createdAt,
                                isDateChanged: isNotificationDateChanges,
                                notificationType: notification.notificationType,
                                isRead: notification.read,
                                onTap: () =>
                                    controller.onNotificationTap(notification),
                              );
                            },
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              AppGaps.hGap24,
                        ),
                      ),
                    ),
                  )),
            ));
  }
}
