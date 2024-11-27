import 'dart:async';
import 'package:ecomik/utils/constants/app_components.dart';
import 'package:ecomik/utils/helpers/helpers.dart';
import 'package:get/get.dart';

class BidWidgetController extends GetxController {
  DateTime bidEndDateTime = AppComponents.defaultUnsetDateTime;

  Duration differenceAsDuration(DateTime startDateTime, DateTime endDateTime) =>
      endDateTime.difference(startDateTime);

  int remainingDays() {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInDays = remainingDuration.inDays;
    if (differenceInDays.isNegative) {
      return 0;
    }
    return differenceInDays;
  }

  int remainingHours() {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInHours = Helper.durationInHours(remainingDuration);
    // differenceAsDuration(DateTime.now(), bidEndDateTime) .inHours .remainder(24);
    if (differenceInHours.isNegative) {
      return 0;
    }
    return differenceInHours;
  }

  int remainingMinutes() {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInMinutes = Helper.durationInMinutes(remainingDuration);
    if (differenceInMinutes.isNegative) {
      return 0;
    }
    return differenceInMinutes;
  }

  int remainingSeconds() {
    final Duration remainingDuration =
        differenceAsDuration(DateTime.now(), bidEndDateTime);
    final int differenceInSeconds = Helper.durationInSeconds(remainingDuration);
    if (differenceInSeconds.isNegative) {
      return 0;
    }
    return differenceInSeconds;
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
