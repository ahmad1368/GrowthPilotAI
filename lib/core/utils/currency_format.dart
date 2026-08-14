/// Formats amounts as Canadian dollars with thousands separators, e.g.
/// 1250.0 -> "$1,250.00". Pure and allocation-light — avoids pulling in intl
/// just for a single grouped-currency string.
class CurrencyFormat {
  static String cad(double amount) {
    final negative = amount < 0;
    final parts = amount.abs().toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final grouped = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) grouped.write(',');
      grouped.write(intPart[i]);
    }
    return '${negative ? '-' : ''}\$$grouped.${parts[1]}';
  }
}
