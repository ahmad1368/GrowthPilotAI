import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_loyalty_program_narrative.dart';
import 'package:growth_pilot_ai/business/compute_loyalty_program_effectiveness.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

void main() {
  group('ComputeLoyaltyProgramEffectiveness', () {
    test('flags the program as effective when repeat revenue covers liability',
        () {
      final transactions = [
        _income('A', 300, DateTime(2024, 1, 1)),
        _income('A', 300, DateTime(2024, 1, 15)),
        _income('B', 100, DateTime(2024, 1, 20)),
      ];

      final result = ComputeLoyaltyProgramEffectiveness.call(transactions);

      expect(result.pointsIssued, 700);
      expect(result.liabilityCost, closeTo(7, 1e-9));
      expect(result.repeatCustomerRevenue, 600);
      expect(result.roiRatio, closeTo(600 / 7, 1e-9));
      expect(result.isEffective, isTrue);
    });

    test('flags the program as ineffective with no repeat buyers', () {
      final transactions = [
        _income('A', 5000, DateTime(2024, 1, 1)),
        _income('B', 5000, DateTime(2024, 1, 2)),
      ];

      final result = ComputeLoyaltyProgramEffectiveness.call(transactions);

      expect(result.repeatCustomerRevenue, 0);
      expect(result.roiRatio, 0);
      expect(result.isEffective, isFalse);
    });

    test('handles no income history', () {
      final result = ComputeLoyaltyProgramEffectiveness.call(const []);
      expect(result.pointsIssued, 0);
      expect(result.liabilityCost, 0);
      expect(result.isEffective, isFalse);
    });
  });

  group('BuildLoyaltyProgramNarrative', () {
    test('falls back when there is no income history', () {
      final result = ComputeLoyaltyProgramEffectiveness.call(const []);
      expect(BuildLoyaltyProgramNarrative.call(result),
          contains('Not enough income history'));
    });

    test('states the program is paying for itself when effective', () {
      final transactions = [
        _income('A', 300, DateTime(2024, 1, 1)),
        _income('A', 300, DateTime(2024, 1, 15)),
      ];
      final result = ComputeLoyaltyProgramEffectiveness.call(transactions);
      expect(BuildLoyaltyProgramNarrative.call(result),
          contains('paying for itself'));
    });

    test('suggests reconsidering the reward rate when ineffective', () {
      final transactions = [
        _income('A', 5000, DateTime(2024, 1, 1)),
        _income('B', 5000, DateTime(2024, 1, 2)),
      ];
      final result = ComputeLoyaltyProgramEffectiveness.call(transactions);
      expect(BuildLoyaltyProgramNarrative.call(result),
          contains('reconsider'));
    });
  });
}
