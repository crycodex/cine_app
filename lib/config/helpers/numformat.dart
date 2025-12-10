import 'package:intl/intl.dart';

class Numformat {
  static String number(double num) {
    final formattedNumer = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en',
    ).format(num);

    return formattedNumer;
  }

  static String numerlarge(double num) {
    final formattedNumer = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(num);

    return formattedNumer;
  }
}
