import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_currency_amounts.dart';

void main() {
  group('ExtractCurrencyAmounts', () {
    test('extracts a single amount', () {
      expect(ExtractCurrencyAmounts.call('You spent \$450 at Costco.'), [450.0]);
    });

    test('extracts multiple amounts with cents', () {
      expect(ExtractCurrencyAmounts.call('\$452.80 and \$1,200.50'), [452.80, 1200.50]);
    });

    test('returns an empty list when no currency is mentioned', () {
      expect(ExtractCurrencyAmounts.call('Here is a summary of your spending.'), isEmpty);
    });
  });
}
