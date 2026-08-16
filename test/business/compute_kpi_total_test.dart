import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_kpi_total.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

void main() {
  group('ComputeKpiTotal', () {
    test('sums transaction amounts', () {
      final transactions = [
        TransactionEntity(amount: 100, date: DateTime(2026, 1, 1), description: 'a'),
        TransactionEntity(amount: 50.5, date: DateTime(2026, 1, 2), description: 'b'),
      ];

      expect(ComputeKpiTotal.call(transactions), 150.5);
    });

    test('empty list totals zero', () {
      expect(ComputeKpiTotal.call([]), 0);
    });
  });
}
