import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_price_term.dart';

void main() {
  test('parses a dollar-sign price', () {
    expect(ExtractPriceTerm.call('I can do \$150 for the lot'), 150.0);
  });

  test('parses an exact-cents price with no dollar sign', () {
    expect(ExtractPriceTerm.call('Final offer is 120.00'), 120.0);
  });

  test('returns null when no price is mentioned', () {
    expect(ExtractPriceTerm.call('Can you deliver tomorrow?'), isNull);
  });
}
