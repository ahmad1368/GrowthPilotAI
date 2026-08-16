import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/group_transactions_by_day.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _tx(DateTime date, double amount) =>
    TransactionEntity(amount: amount, date: date, description: 'x');

void main() {
  group('GroupTransactionsByDay', () {
    test('sums same-day transactions into one point', () {
      final points = GroupTransactionsByDay.call([
        _tx(DateTime(2026, 1, 5, 9), 10),
        _tx(DateTime(2026, 1, 5, 18), 5),
        _tx(DateTime(2026, 1, 6), 20),
      ]);

      expect(points.length, 2);
      expect(points.first.total, 15);
      expect(points.last.total, 20);
    });

    test('sorts points chronologically', () {
      final points = GroupTransactionsByDay.call([
        _tx(DateTime(2026, 1, 10), 1),
        _tx(DateTime(2026, 1, 1), 1),
      ]);

      expect(points.first.day, DateTime(2026, 1, 1));
      expect(points.last.day, DateTime(2026, 1, 10));
    });
  });
}
