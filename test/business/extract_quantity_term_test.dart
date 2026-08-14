import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_quantity_term.dart';

void main() {
  test('parses "N units"', () {
    expect(ExtractQuantityTerm.call('I need 10 units by Friday'), 10);
  });

  test('parses "qty N"', () {
    expect(ExtractQuantityTerm.call('qty 20 please'), 20);
  });

  test('parses "Nx" shorthand', () {
    expect(ExtractQuantityTerm.call('Can you do 5x for a discount?'), 5);
  });

  test('returns null when no quantity is mentioned', () {
    expect(ExtractQuantityTerm.call('Sounds good, deal!'), isNull);
  });
}
