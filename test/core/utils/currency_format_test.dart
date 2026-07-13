import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

void main() {
  group('CurrencyFormat.cad', () {
    test('formats a plain amount with two decimals', () {
      expect(CurrencyFormat.cad(1250.0), r'$1,250.00');
    });

    test('groups thousands correctly for large amounts', () {
      expect(CurrencyFormat.cad(1234567.5), r'$1,234,567.50');
    });

    test('handles zero', () {
      expect(CurrencyFormat.cad(0), r'$0.00');
    });

    test('handles values below 1,000 without a separator', () {
      expect(CurrencyFormat.cad(42.1), r'$42.10');
    });

    test('prefixes negatives with a minus sign', () {
      expect(CurrencyFormat.cad(-2500.75), r'-$2,500.75');
    });
  });
}
