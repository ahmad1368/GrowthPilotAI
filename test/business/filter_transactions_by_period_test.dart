import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_period.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/compass_period.dart';

TransactionEntity _tx(DateTime date) =>
    TransactionEntity(amount: 10, date: date, description: 'x');

void main() {
  final now = DateTime(2026, 1, 30);

  test('monthly keeps only the trailing 30 days', () {
    final transactions = [
      _tx(now.subtract(const Duration(days: 5))),
      _tx(now.subtract(const Duration(days: 60))),
    ];

    final result =
        FilterTransactionsByPeriod.call(transactions, CompassPeriod.monthly, now);

    expect(result, hasLength(1));
  });

  test('annual keeps a transaction from 200 days ago', () {
    final transactions = [_tx(now.subtract(const Duration(days: 200)))];

    final result =
        FilterTransactionsByPeriod.call(transactions, CompassPeriod.annual, now);

    expect(result, hasLength(1));
  });

  test('quarterly excludes a transaction from 200 days ago', () {
    final transactions = [_tx(now.subtract(const Duration(days: 200)))];

    final result = FilterTransactionsByPeriod.call(
        transactions, CompassPeriod.quarterly, now);

    expect(result, isEmpty);
  });
}
