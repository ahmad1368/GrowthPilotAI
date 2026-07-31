import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_clv_narrative.dart';
import 'package:growth_pilot_ai/business/compute_cohort_clv_comparison.dart';
import 'package:growth_pilot_ai/business/compute_customer_lifetime_values.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/customer_cohort.dart';

TransactionEntity _income(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

void main() {
  final now = DateTime(2024, 3, 1);

  group('ComputeCustomerLifetimeValues', () {
    test('projects CLV for a recent single-purchase buyer as new cohort', () {
      final transactions = [
        _income('A', 120, now.subtract(const Duration(days: 30))),
      ];

      final clvs = ComputeCustomerLifetimeValues.call(transactions, now);

      expect(clvs.single.averagePurchaseValue, 120);
      expect(clvs.single.purchaseFrequencyPerMonth, 1.0);
      expect(clvs.single.lifetimeValue, closeTo(4320, 1e-6));
      expect(clvs.single.cohort, CustomerCohort.newCustomer);
    });

    test('projects CLV for a long-tenured repeat buyer as established cohort',
        () {
      final transactions = [
        _income('B', 150, now.subtract(const Duration(days: 200))),
        _income('B', 150, now),
      ];

      final clvs = ComputeCustomerLifetimeValues.call(transactions, now);

      expect(clvs.single.averagePurchaseValue, 150);
      expect(clvs.single.purchaseFrequencyPerMonth, closeTo(0.3, 1e-6));
      expect(clvs.single.lifetimeValue, closeTo(1620, 1e-3));
      expect(clvs.single.cohort, CustomerCohort.established);
    });
  });

  group('ComputeCohortClvComparison', () {
    test('averages CLV within each cohort', () {
      final transactions = [
        _income('A', 120, now.subtract(const Duration(days: 30))),
        _income('B', 150, now.subtract(const Duration(days: 200))),
        _income('B', 150, now),
      ];

      final clvs = ComputeCustomerLifetimeValues.call(transactions, now);
      final comparison = ComputeCohortClvComparison.call(clvs);

      expect(comparison.newCohortCount, 1);
      expect(comparison.establishedCohortCount, 1);
      expect(comparison.newCohortAverageClv, closeTo(4320, 1e-6));
      expect(comparison.establishedCohortAverageClv, closeTo(1620, 1e-3));
    });
  });

  group('BuildClvNarrative', () {
    test('falls back when one cohort has no buyers yet', () {
      final comparison = ComputeCohortClvComparison.call(const []);
      expect(BuildClvNarrative.call(comparison),
          contains('Not enough purchase history'));
    });

    test('names both cohort values when both are populated', () {
      final transactions = [
        _income('A', 120, now.subtract(const Duration(days: 30))),
        _income('B', 150, now.subtract(const Duration(days: 200))),
        _income('B', 150, now),
      ];
      final clvs = ComputeCustomerLifetimeValues.call(transactions, now);
      final comparison = ComputeCohortClvComparison.call(clvs);

      expect(BuildClvNarrative.call(comparison), contains('lifetime value'));
    });
  });
}
