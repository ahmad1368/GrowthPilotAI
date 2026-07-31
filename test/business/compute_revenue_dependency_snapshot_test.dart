import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_revenue_dependency_narrative.dart';
import 'package:growth_pilot_ai/business/compute_revenue_dependency_snapshot.dart';
import 'package:growth_pilot_ai/business/group_transactions_by_customer.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

TransactionEntity _expense(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 0);

void main() {
  group('GroupTransactionsByCustomer', () {
    test('ignores expenses and groups income by normalized description', () {
      final transactions = [
        _income('Acme Corp', 100, DateTime(2024, 1, 1)),
        _income('acme corp', 50, DateTime(2024, 1, 10)),
        _income('One-Off Buyer', 20, DateTime(2024, 1, 5)),
        _expense('Rent', 500, DateTime(2024, 1, 3)),
      ];

      final groups = GroupTransactionsByCustomer.call(transactions);

      expect(groups.length, 2);
      final acme = groups.firstWhere((g) => g.label == 'Acme Corp');
      expect(acme.totalRevenue, 150);
      expect(acme.transactionCount, 2);
      expect(acme.isRepeat, isTrue);

      final oneOff = groups.firstWhere((g) => g.label == 'One-Off Buyer');
      expect(oneOff.isRepeat, isFalse);
    });
  });

  group('ComputeRevenueDependencySnapshot', () {
    test('flags concentration risk when one buyer dominates revenue', () {
      final transactions = [
        _income('Big Client', 800, DateTime(2024, 1, 1)),
        _income('Small Buyer A', 100, DateTime(2024, 1, 2)),
        _income('Small Buyer B', 100, DateTime(2024, 1, 3)),
      ];

      final snapshot = ComputeRevenueDependencySnapshot.call(transactions);

      expect(snapshot.totalRevenue, 1000);
      expect(snapshot.topCustomerLabel, 'Big Client');
      expect(snapshot.topCustomerShare, closeTo(0.8, 1e-9));
      expect(snapshot.isConcentrationRisk, isTrue);
    });

    test('computes repeat-vs-one-time revenue share with no concentration risk',
        () {
      final transactions = [
        _income('Regular A', 20, DateTime(2024, 1, 1)),
        _income('Regular A', 20, DateTime(2024, 1, 15)),
        _income('Regular B', 20, DateTime(2024, 1, 2)),
        _income('Regular B', 20, DateTime(2024, 1, 16)),
        _income('New Visitor 1', 30, DateTime(2024, 1, 20)),
        _income('New Visitor 2', 30, DateTime(2024, 1, 21)),
        _income('New Visitor 3', 30, DateTime(2024, 1, 22)),
      ];

      final snapshot = ComputeRevenueDependencySnapshot.call(transactions);

      expect(snapshot.repeatRevenue, 80);
      expect(snapshot.oneTimeRevenue, 90);
      expect(snapshot.repeatRevenueShare, closeTo(80 / 170, 1e-9));
      expect(snapshot.isConcentrationRisk, isFalse);
    });

    test('handles no income history', () {
      final snapshot = ComputeRevenueDependencySnapshot.call(const []);
      expect(snapshot.totalRevenue, 0);
      expect(snapshot.topCustomerLabel, isNull);
      expect(snapshot.isConcentrationRisk, isFalse);
    });
  });

  group('BuildRevenueDependencyNarrative', () {
    test('falls back when there is no income history', () {
      final snapshot = ComputeRevenueDependencySnapshot.call(const []);
      expect(BuildRevenueDependencyNarrative.call(snapshot),
          contains('Not enough income history'));
    });

    test('warns about the dominant buyer when concentration risk is flagged',
        () {
      final transactions = [
        _income('Big Client', 800, DateTime(2024, 1, 1)),
        _income('Small Buyer', 200, DateTime(2024, 1, 2)),
      ];
      final snapshot = ComputeRevenueDependencySnapshot.call(transactions);
      expect(
          BuildRevenueDependencyNarrative.call(snapshot), contains('Big Client'));
    });
  });
}
