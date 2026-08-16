import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sanitize_transaction_text_for_embedding.dart';

void main() {
  group('SanitizeTransactionTextForEmbedding', () {
    test('joins merchant, date, and line items into one normalized string', () {
      final result = SanitizeTransactionTextForEmbedding.call(
        merchantName: 'ABC Logistics',
        date: DateTime(2026, 3, 5),
        lineItems: ['Freight', 'Fuel surcharge'],
      );

      expect(result, 'ABC Logistics, 2026-03-05, Freight, Fuel surcharge');
    });

    test('appends GST/HST when provided', () {
      final result = SanitizeTransactionTextForEmbedding.call(
        merchantName: 'ABC Logistics',
        date: DateTime(2026, 3, 5),
        lineItems: const [],
        gstHst: 25.5,
      );

      expect(result, contains('GST/HST: \$25.50'));
    });

    test('drops empty line items and collapses whitespace', () {
      final result = SanitizeTransactionTextForEmbedding.call(
        merchantName: '  ABC Logistics  ',
        date: DateTime(2026, 3, 5),
        lineItems: ['', '  Freight  ', '   '],
      );

      expect(result, 'ABC Logistics, 2026-03-05, Freight');
    });
  });
}
