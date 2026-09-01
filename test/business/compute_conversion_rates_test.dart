import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_conversion_narrative.dart';
import 'package:growth_pilot_ai/business/compute_conversion_rates.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/visitor_count_entity.dart';

TransactionEntity _txn(String description, double amount, DateTime date) =>
    TransactionEntity(
        amount: amount, description: description, date: date, dbType: 1);

void main() {
  group('ComputeConversionRates', () {
    test('returns empty list when no visitor counts are logged', () {
      expect(
          ComputeConversionRates.call(
              const [], [_txn('A', 10, DateTime(2024, 3, 1))]),
          isEmpty);
    });

    test('matches only same-day transactions against the visitor count', () {
      final count = VisitorCountEntity(
          visitorCount: 100, date: DateTime(2024, 3, 1));
      final transactions = [
        _txn('In day', 10, DateTime(2024, 3, 1, 14, 0)),
        _txn('In day 2', 20, DateTime(2024, 3, 1, 16, 0)),
        _txn('Other day', 30, DateTime(2024, 3, 2)),
      ];

      final result = ComputeConversionRates.call([count], transactions).single;

      expect(result.transactionCount, 2);
      expect(result.conversionPercent, closeTo(2.0, 1e-9));
    });

    test('guards against division by zero when visitor count is 0', () {
      final count =
          VisitorCountEntity(visitorCount: 0, date: DateTime(2024, 3, 1));
      final result = ComputeConversionRates.call(
              [count], [_txn('A', 10, DateTime(2024, 3, 1))])
          .single;

      expect(result.conversionPercent, 0);
    });

    test('sorts days by conversion percent descending', () {
      final high = VisitorCountEntity(
          visitorCount: 10, date: DateTime(2024, 3, 1));
      final low = VisitorCountEntity(
          visitorCount: 100, date: DateTime(2024, 3, 2));
      final transactions = [
        _txn('A', 10, DateTime(2024, 3, 1)),
        _txn('B', 10, DateTime(2024, 3, 2)),
      ];

      final results = ComputeConversionRates.call([low, high], transactions);
      expect(results.first.date, DateTime(2024, 3, 1));
      expect(results.last.date, DateTime(2024, 3, 2));
    });
  });

  group('BuildConversionNarrative', () {
    test('falls back when no visitor counts are logged', () {
      expect(BuildConversionNarrative.call(const []),
          contains('No visitor counts logged'));
    });

    test('describes a single logged day', () {
      final count = VisitorCountEntity(
          visitorCount: 100, date: DateTime(2024, 3, 1));
      final results = ComputeConversionRates.call(
          [count], [_txn('A', 10, DateTime(2024, 3, 1))]);
      expect(BuildConversionNarrative.call(results), contains('1.0%'));
    });

    test('names the best and worst day when multiple exist', () {
      final high = VisitorCountEntity(
          visitorCount: 10, date: DateTime(2024, 3, 1));
      final low = VisitorCountEntity(
          visitorCount: 100, date: DateTime(2024, 3, 2));
      final transactions = [
        _txn('A', 10, DateTime(2024, 3, 1)),
        _txn('B', 10, DateTime(2024, 3, 2)),
      ];

      final results = ComputeConversionRates.call([low, high], transactions);
      final narrative = BuildConversionNarrative.call(results);
      expect(narrative, contains('Best conversion day'));
      expect(narrative, contains('worst dropped'));
    });
  });
}
