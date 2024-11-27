import 'package:ecomik/utils/helpers/helpers.dart';

extension CurrencyText on double {
  String get toCurrencyAmountText =>
      Helper.getCurrencyFormattedAmountText(this);
}
