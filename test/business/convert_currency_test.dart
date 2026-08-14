import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/convert_currency.dart';

void main() {
  test('applies the 0.5% platform buffer on top of the raw rate', () {
    final result = ConvertCurrency.call(100, 1.37);
    expect(result, closeTo(100 * 1.37 * 1.005, 0.01));
  });

  test('rounds to 2 decimal places', () {
    final result = ConvertCurrency.call(33.333, 1.0);
    expect(result, 33.5); // 33.333 * 1.005 = 33.499665 -> 33.5 rounded
  });
}
