import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_delivery_date_term.dart';

void main() {
  final now = DateTime(2026, 3, 10, 14, 30);

  test('resolves "today"', () {
    expect(ExtractDeliveryDateTerm.call('Can you deliver today?', now), DateTime(2026, 3, 10));
  });

  test('resolves "tomorrow"', () {
    expect(ExtractDeliveryDateTerm.call('Tomorrow works for me', now), DateTime(2026, 3, 11));
  });

  test('resolves "next week"', () {
    expect(ExtractDeliveryDateTerm.call('Let\'s do next week', now), DateTime(2026, 3, 17));
  });

  test('returns null when no date language is present', () {
    expect(ExtractDeliveryDateTerm.call('What is your best price?', now), isNull);
  });
}
