import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/bucket_transactions_by_period.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/margin_period.dart';

TransactionEntity _tx(DateTime date, {double amount = 10}) =>
    TransactionEntity(amount: amount, date: date, description: 'x');

void main() {
  test('daily buckets key by midnight of each calendar day', () {
    final buckets = BucketTransactionsByPeriod.call([
      _tx(DateTime(2026, 3, 5, 9)),
      _tx(DateTime(2026, 3, 5, 21)),
      _tx(DateTime(2026, 3, 6, 1)),
    ], MarginPeriod.daily);

    expect(buckets.keys, containsAll([DateTime(2026, 3, 5), DateTime(2026, 3, 6)]));
    expect(buckets[DateTime(2026, 3, 5)], hasLength(2));
  });

  test('weekly buckets key by the Monday of that ISO week', () {
    // 2026-03-05 is a Thursday; the Monday of that week is 2026-03-02.
    final buckets = BucketTransactionsByPeriod.call(
        [_tx(DateTime(2026, 3, 5))], MarginPeriod.weekly);

    expect(buckets.keys.single, DateTime(2026, 3, 2));
  });

  test('monthly buckets key by the 1st of that month', () {
    final buckets = BucketTransactionsByPeriod.call(
        [_tx(DateTime(2026, 3, 17)), _tx(DateTime(2026, 3, 30))],
        MarginPeriod.monthly);

    expect(buckets.keys.single, DateTime(2026, 3, 1));
    expect(buckets.values.single, hasLength(2));
  });
}
