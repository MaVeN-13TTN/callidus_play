import 'package:intl/intl.dart';

class CurrencyHelper {
  static String formatPrice(double price, {String symbol = '\$'}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 2,
    ).format(price);
  }

  static String formatPriceCompact(double price, {String symbol = '\$'}) {
    return NumberFormat.compactCurrency(
      symbol: symbol,
      decimalDigits: 2,
    ).format(price);
  }
}
