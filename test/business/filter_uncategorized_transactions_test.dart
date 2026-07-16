import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_uncategorized_transactions.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

void main() {
  group('FilterUncategorizedTransactions.call', () {
    test('excludes soft-deleted and already-confirmed transactions', () {
      final kept = TransactionEntity(amount: 10, date: DateTime(2026), description: 'A')..id = 1;
      final deleted = TransactionEntity(
          amount: 10, date: DateTime(2026), description: 'B', isDeleted: true)
        ..id = 2;
      final confirmed = TransactionEntity(amount: 10, date: DateTime(2026), description: 'C')
        ..id = 3;

      final result = FilterUncategorizedTransactions.call(
        [kept, deleted, confirmed],
        {3},
      );

      expect(result, [kept]);
    });
  });
}
