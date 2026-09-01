import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_negotiation_terms.dart';

void main() {
  final now = DateTime(2026, 3, 10);

  test('combines the latest mention of each field across the window', () {
    final terms = ExtractNegotiationTerms.call([
      'How about \$100 for 10 units?',
      'I can do \$90 instead',
      'Can you deliver tomorrow?',
    ], now);

    expect(terms.price, 90.0);
    expect(terms.quantity, 10);
    expect(terms.deliveryDate, DateTime(2026, 3, 11));
  });

  test('only scans the last 20 messages', () {
    final messages = [
      'Price is \$500', // outside the window, should be ignored
      ...List.filled(20, 'no terms here'),
    ];
    final terms = ExtractNegotiationTerms.call(messages, now);
    expect(terms.price, isNull);
  });

  test('returns all-null terms for an empty conversation', () {
    final terms = ExtractNegotiationTerms.call([], now);
    expect(terms.price, isNull);
    expect(terms.quantity, isNull);
    expect(terms.deliveryDate, isNull);
  });
}
