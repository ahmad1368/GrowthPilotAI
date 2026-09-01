import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/calculate_match_score.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

void main() {
  UnifiedTransactionEntity tx({
    required double amount,
    required DateTime date,
    required String merchant,
  }) =>
      UnifiedTransactionEntity(
        externalId: 'x',
        dbSource: TransactionSource.plaid.index,
        amount: amount,
        date: date,
        merchantName: merchant,
      );

  group('CalculateMatchScore.call', () {
    test('scores a near-identical same-day pair near 1.0', () {
      final a = tx(amount: 450, date: DateTime(2026, 7, 1), merchant: 'HOME DEPOT #451');
      final b = tx(amount: 450, date: DateTime(2026, 7, 1), merchant: 'Home Depot');

      expect(CalculateMatchScore.call(a, b), greaterThan(0.92));
    });

    test('drops the amount weight when amounts differ by even a cent', () {
      final a = tx(amount: 450.00, date: DateTime(2026, 7, 1), merchant: 'Home Depot');
      final b = tx(amount: 450.01, date: DateTime(2026, 7, 1), merchant: 'Home Depot');

      expect(CalculateMatchScore.call(a, b), lessThan(0.6));
    });

    test('gives partial date credit for a 2-day gap, none beyond 3 days', () {
      final a = tx(amount: 100, date: DateTime(2026, 7, 1), merchant: 'X');
      final within3 = tx(amount: 100, date: DateTime(2026, 7, 3), merchant: 'X');
      final beyond3 = tx(amount: 100, date: DateTime(2026, 7, 5), merchant: 'X');

      expect(CalculateMatchScore.call(a, within3), greaterThan(CalculateMatchScore.call(a, beyond3)));
    });
  });
}
