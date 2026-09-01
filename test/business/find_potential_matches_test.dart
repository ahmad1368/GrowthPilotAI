import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_potential_matches.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

void main() {
  UnifiedTransactionEntity tx(
    String id,
    TransactionSource source, {
    double amount = 450,
    required DateTime date,
    String merchant = 'Home Depot',
    bool merged = false,
  }) =>
      UnifiedTransactionEntity(
        externalId: id,
        dbSource: source.index,
        amount: amount,
        date: date,
        merchantName: merchant,
        mergeGroupId: merged ? 'group' : null,
      );

  group('FindPotentialMatches.call', () {
    test('returns the high-confidence cross-source candidate', () {
      final plaidTx = tx('p1', TransactionSource.plaid, date: DateTime(2026, 7, 1));
      final qboTx = tx('q1', TransactionSource.quickbooks, date: DateTime(2026, 7, 1));

      final match = FindPotentialMatches.call(plaidTx, [plaidTx, qboTx]);

      expect(match?.externalId, 'q1');
    });

    test('ignores same-source candidates', () {
      final plaidTx = tx('p1', TransactionSource.plaid, date: DateTime(2026, 7, 1));
      final otherPlaidTx = tx('p2', TransactionSource.plaid, date: DateTime(2026, 7, 1));

      expect(FindPotentialMatches.call(plaidTx, [plaidTx, otherPlaidTx]), isNull);
    });

    test('ignores already-merged candidates and low-confidence matches', () {
      final plaidTx = tx('p1', TransactionSource.plaid, date: DateTime(2026, 7, 1));
      final mergedQbo = tx('q1', TransactionSource.quickbooks,
          date: DateTime(2026, 7, 1), merged: true);
      final farQbo = tx('q2', TransactionSource.quickbooks,
          amount: 999, date: DateTime(2026, 12, 1), merchant: 'Unrelated');

      expect(FindPotentialMatches.call(plaidTx, [plaidTx, mergedQbo, farQbo]), isNull);
    });
  });
}
