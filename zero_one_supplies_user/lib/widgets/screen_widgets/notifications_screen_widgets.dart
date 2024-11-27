import 'package:ecomik/models/enums.dart';
import 'package:ecomik/models/fake_models/notification_model.dart';
import 'package:ecomik/utils/constants/app_constants_import.dart';
import 'package:ecomik/utils/constants/app_text_styles.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:ecomik/widgets/core_widgets.dart';
import 'package:flutter/material.dart';

/// Single notification entry widget from notification group
class SingleNotificationWidget extends StatelessWidget {
  final FakeNotificationModel notification;
  const SingleNotificationWidget({
    super.key,
    required this.notification,
  });

  TextStyle? _getTextStyle(FakeNotificationTextModel notificationText) {
    if (notificationText.isBoldText) {
      return const TextStyle(fontWeight: FontWeight.w600);
    } else if (notificationText.isHashText) {
      return const TextStyle(
          color: AppColors.primaryColor, fontWeight: FontWeight.w600);
    } else if (notificationText.isColoredText) {
      return const TextStyle(color: AppColors.primaryColor);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: notification.isRead
                    ? AppColors.bodyTextColor
                    : AppColors.primaryColor),
          ),
          AppGaps.wGap16,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: notification.isRead
                              ? AppColors.bodyTextColor
                              : AppColors.darkColor,
                          height: 1.5),
                      children: notification.texts
                          .map((notificationText) => TextSpan(
                              text: notificationText.text,
                              style: _getTextStyle(notificationText)))
                          .toList()),
                ),
                AppGaps.hGap8,
                Text(notification.timeText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.bodyTextColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Notification group widget from date wise
/* class NotificationDateGroupWidget extends StatelessWidget {
  const NotificationDateGroupWidget({
    Key? key,
    required this.notificationDateGroup,
    required this.outerIndex,
  }) : super(key: key);

  final FakeNotificationDateGroupModel notificationDateGroup;
  final int outerIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(notificationDateGroup.dateHumanReadableText,
            style: Theme.of(context).textTheme.labelLarge),
        AppGaps.hGap24,
        /* <---- Notification list under a date 
                 category ----> */
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (context, index) => AppGaps.hGap24,
          itemCount: FakeData
              .fakeNotificationDateGroups[outerIndex].groupNotifications.length,
          itemBuilder: (context, index) {
            /// Single notification
            final notification = FakeData.fakeNotificationDateGroups[outerIndex]
                .groupNotifications[index];
            return SingleNotificationWidget(notification: notification);
          },
        ),
      ],
    );
  }
} */

class NotificationWidget extends StatelessWidget {
  final bool isRead;
  final NotificationType notificationType;
  final NotificationTypeStatus status;
  final String orderNumber;
  final String deliveryNumber;
  final DateTime dateTime;
  final bool isDateChanged;
  final void Function()? onTap;

  const NotificationWidget({
    super.key,
    this.isRead = true,
    required this.notificationType,
    required this.status,
    this.onTap,
    required this.dateTime,
    required this.isDateChanged,
    this.orderNumber = '',
    this.deliveryNumber = '',
  });

  @override
  Widget build(BuildContext context) {
    if (isDateChanged) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              dayText,
              style: AppTextStyles.notificationDateSection,
            ),
          ),
          AppGaps.hGap24,
          _NotificationWidget(
              isRead: isRead,
              notificationType: notificationType,
              status: status,
              dateTime: dateTime,
              orderNumber: orderNumber,
              deliveryNumber: deliveryNumber,
              isDateChanged: isDateChanged,
              onTap: onTap),
        ],
      );
    }
    return _NotificationWidget(
        isRead: isRead,
        notificationType: notificationType,
        status: status,
        dateTime: dateTime,
        isDateChanged: isDateChanged,
        deliveryNumber: deliveryNumber,
        orderNumber: orderNumber,
        onTap: onTap);
  }

  String get dayText {
    if (Helper.isToday(dateTime)) {
      return 'Today';
    }
    if (Helper.wasYesterday(dateTime)) {
      return 'Yesterday';
    }
    if (Helper.isTomorrow(dateTime)) {
      return 'Tomorrow';
    }
    return Helper.ddMMMyyyyFormattedDateTime(dateTime);
  }
}

class _NotificationWidget extends StatelessWidget {
  final bool isRead;
  final NotificationType notificationType;
  final NotificationTypeStatus status;
  final DateTime dateTime;
  final bool isDateChanged;
  final String orderNumber;
  final String deliveryNumber;
  final void Function()? onTap;
  const _NotificationWidget({
    this.isRead = true,
    required this.notificationType,
    required this.status,
    required this.dateTime,
    required this.isDateChanged,
    this.onTap,
    required this.orderNumber,
    required this.deliveryNumber,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRawListTileWidget(
        onTap: onTap,
        borderRadiusRadiusValue: AppComponents.defaultBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: NotificationDotWidget(isRead: isRead),
            ),
            AppGaps.wGap16,
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text:
                              notificationText /* 'Your order #$theNumber is arrived Railstation by Michle Leo Hunter' */),
                    ]),
                    style: AppTextStyles.bodyLargeTextStyle.copyWith(
                        color: isRead ? AppColors.bodyTextColor : null)),
                AppGaps.hGap8,
                Text(
                  Helper.hhmmFormattedDateTime(dateTime),
                  style: const TextStyle(
                    color: AppColors.bodyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ))
          ]),
        ));
  }

  String get notificationText {
    StringBuffer textBuffer = StringBuffer();
    textBuffer.write('Your ');
    // log('NotificationType: ${notificationType.stringValue} __ StatusType: ${notificationTypeStatus.stringValue} \n Order Number: $orderNumber __ Delivery Number: $deliveryNumber');
    switch (notificationType) {
      case NotificationType.order:
      case NotificationType.confirmOrder:
        textBuffer.write('order $orderNumber is ${status.stringValueForView}');
        break;
      case NotificationType.delivery:
        textBuffer.write(
            'deliver order $deliveryNumber is ${status.stringValueForView}');
        break;
      default:
    }
    /* if (notificationType == NotificationType.delivery) {
      return 'Your delivery of ID #$deliveryNumber is delivered successfully!';
    } else if (notificationType == NotificationType.confirmOrder) {
      return 'Your order of ID #$orderNumber is confirmed successfully.';
    } else {
      return 'Your order of ID #$orderNumber is ${notificationTypeStatus.stringValueForView} successfully!';
    } */
    return textBuffer.toString();
  }
}
