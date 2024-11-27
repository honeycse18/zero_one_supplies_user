import 'package:ecomik/utils/helpers/api_helper.dart';

extension ServerDateTime on DateTime {
  String get toServerDateTimeFormatted =>
      APIHelper.toServerDateTimeFormattedStringFromDateTime(this);
}
