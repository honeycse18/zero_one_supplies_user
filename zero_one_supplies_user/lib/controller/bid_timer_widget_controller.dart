import 'dart:async';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class BidCountdownTimerWidgetController extends GetxController {
  DateTime bidEndDateTime = AppComponents.defaultUnsetDateTime;

  Duration differenceAsDuration(DateTime startDateTime, DateTime endDateTime) =>
      endDateTime.difference(startDateTime);

  int get remainingDays {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInDays = remainingDuration.inDays;
    if (differenceInDays.isNegative) {
      return 0;
    }
    return differenceInDays;
  }

  String get remainingDaysText {
    return '$remainingDays';
  }

  int get remainingHours {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInHours = Helper.durationInHours(remainingDuration);
    // differenceAsDuration(DateTime.now(), bidEndDateTime) .inHours .remainder(24);
    if (differenceInHours.isNegative) {
      return 0;
    }
    return differenceInHours;
  }

  String get remainingHoursText {
    return '$remainingHours'.padLeft(2, '0');
  }

  int get remainingMinutes {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInMinutes = Helper.durationInMinutes(remainingDuration);
    if (differenceInMinutes.isNegative) {
      return 0;
    }
    return differenceInMinutes;
  }

  String get remainingMinutesText {
    return '$remainingMinutes'.padLeft(2, '0');
  }

  int get remainingSeconds {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInSeconds = Helper.durationInSeconds(remainingDuration);
    if (differenceInSeconds.isNegative) {
      return 0;
    }
    return differenceInSeconds;
  }

  String get remainingSecondsText {
    return '$remainingSeconds'.padLeft(2, '0');
  }

  Timer timer = Timer(
    const Duration(seconds: 1),
    () {},
  );

  @override
  void onInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.onClose();
  }
}
