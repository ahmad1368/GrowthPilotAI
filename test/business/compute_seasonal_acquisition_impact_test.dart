import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_seasonal_acquisition_narrative.dart';
import 'package:growth_pilot_ai/business/compute_seasonal_acquisition_impact.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(String description, DateTime date) => TransactionEntity(
    amount: 10, description: description, date: date, dbType: 1);

void main() {
  group('ComputeSeasonalAcquisitionImpact', () {
    test('counts new buyers acquired around a holiday and tracks retention',
        () {
      final transactions = [
        _income('A', DateTime(2024, 12, 25)),
        _income('A', DateTime(2025, 1, 10)),
        _income('B', DateTime(2024, 12, 24)),
        _income('C', DateTime(2024, 11, 1)),
      ];

      final impacts = ComputeSeasonalAcquisitionImpact.call(transactions);
      final christmas =
          impacts.firstWhere((i) => i.holidayName == 'Christmas Day');

      expect(christmas.newCustomersAcquired, 2);
      expect(christmas.retainedCustomers, 1);
      expect(christmas.retentionRate, closeTo(0.5, 1e-9));
    });

    test('excludes holidays with no acquisitions', () {
      final transactions = [_income('A', DateTime(2024, 11, 1))];
      final impacts = ComputeSeasonalAcquisitionImpact.call(transactions);
      expect(impacts, isEmpty);
    });

    test('sorts by most new buyers acquired first', () {
      final transactions = [
        _income('A', DateTime(2024, 12, 25)),
        _income('B', DateTime(2024, 12, 25)),
        _income('C', DateTime(2024, 1, 1)),
      ];

      final impacts = ComputeSeasonalAcquisitionImpact.call(transactions);
      expect(impacts.first.holidayName, 'Christmas Day');
    });
  });

  group('BuildSeasonalAcquisitionNarrative', () {
    test('falls back when there is no acquisition history', () {
      expect(BuildSeasonalAcquisitionNarrative.call(const []),
          contains('Not enough purchase history'));
    });

    test('names the top holiday and its retention rate', () {
      final transactions = [
        _income('A', DateTime(2024, 12, 25)),
        _income('A', DateTime(2025, 1, 10)),
      ];
      final impacts = ComputeSeasonalAcquisitionImpact.call(transactions);
      expect(BuildSeasonalAcquisitionNarrative.call(impacts),
          contains('Christmas Day'));
    });
  });
}
