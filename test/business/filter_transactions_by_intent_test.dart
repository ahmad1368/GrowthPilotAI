import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_intent.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

TransactionEntity _tx(String desc, DateTime date, double amount) =>
    TransactionEntity(amount: amount, date: date, description: desc);

void main() {
  group('FilterTransactionsByIntent', () {
    final transactions = [
      _tx('Rogers utilities bill', DateTime(2026, 1, 5), 120),
      _tx('Fuel for delivery van', DateTime(2026, 1, 10), 60),
      _tx('Office rent', DateTime(2026, 2, 1), 2000),
    ];

    test('filters by date range', () {
      final intent = QueryIntent(rangeStart: DateTime(2026, 1, 1), rangeEnd: DateTime(2026, 1, 31));
      final result = FilterTransactionsByIntent.call(transactions, intent);

      expect(result.length, 2);
    });

    test('filters by category keyword against description', () {
      const intent = QueryIntent(category: 'utilities');
      final result = FilterTransactionsByIntent.call(transactions, intent);

      expect(result.length, 1);
      expect(result.first.description, 'Rogers utilities bill');
    });

    test('no filters returns everything', () {
      expect(FilterTransactionsByIntent.call(transactions, const QueryIntent()).length, 3);
    });
  });
}
