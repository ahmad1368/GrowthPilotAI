import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_churn_retention_narrative.dart';
import 'package:growth_pilot_ai/business/compute_churn_cohort_points.dart';
import 'package:growth_pilot_ai/business/compute_churn_retention_snapshot.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

List<TransactionEntity> _txAt(List<DateTime> dates) => [
      for (final d in dates)
        TransactionEntity(amount: 10, description: 't', date: d),
    ];

void main() {
  group('ComputeChurnRetentionSnapshot', () {
    test('flags churn risk when recent volume drops sharply', () {
      final now = DateTime(2024, 3, 1);
      final transactions = _txAt([
        for (var i = 0; i < 10; i++) now.subtract(Duration(days: 35 + i)),
        for (var i = 0; i < 2; i++) now.subtract(Duration(days: i)),
      ]);

      final snapshot = ComputeChurnRetentionSnapshot.call(
          transactions, now, const Duration(days: 30));

      expect(snapshot.previousPeriodCount, 10);
      expect(snapshot.currentPeriodCount, 2);
      expect(snapshot.retentionRate, closeTo(0.2, 1e-9));
      expect(snapshot.isChurnRisk, isTrue);
    });

    test('clamps retention rate at 1.0 when current volume grows', () {
      final now = DateTime(2024, 3, 1);
      final transactions = _txAt([
        for (var i = 0; i < 5; i++) now.subtract(Duration(days: 35 + i)),
        for (var i = 0; i < 20; i++) now.subtract(Duration(days: i)),
      ]);

      final snapshot = ComputeChurnRetentionSnapshot.call(
          transactions, now, const Duration(days: 30));

      expect(snapshot.retentionRate, 1.0);
      expect(snapshot.isChurnRisk, isFalse);
    });

    test('treats no prior activity but current activity as full retention',
        () {
      final now = DateTime(2024, 3, 1);
      final transactions =
          _txAt([for (var i = 0; i < 3; i++) now.subtract(Duration(days: i))]);

      final snapshot = ComputeChurnRetentionSnapshot.call(
          transactions, now, const Duration(days: 30));

      expect(snapshot.previousPeriodCount, 0);
      expect(snapshot.retentionRate, 1.0);
      expect(snapshot.isChurnRisk, isFalse);
    });
  });

  group('ComputeChurnCohortPoints', () {
    test('buckets transactions into 8 trailing weekly cohorts', () {
      final now = DateTime(2024, 3, 1);
      final transactions = _txAt([now, now.subtract(const Duration(days: 10))]);

      final points = ComputeChurnCohortPoints.call(transactions, now);

      expect(points.length, ComputeChurnCohortPoints.weekCount);
      expect(points.last.weeksAgo, 0);
      expect(points.last.count, 1);
    });
  });

  group('BuildChurnRetentionNarrative', () {
    test('falls back when there is no transaction history', () {
      final now = DateTime(2024, 3, 1);
      final snapshot = ComputeChurnRetentionSnapshot.call(
          const [], now, const Duration(days: 30));
      expect(BuildChurnRetentionNarrative.call(snapshot),
          contains('Not enough transaction history'));
    });

    test('suggests a retention offer when churn risk is flagged', () {
      final now = DateTime(2024, 3, 1);
      final transactions = _txAt([
        for (var i = 0; i < 10; i++) now.subtract(Duration(days: 35 + i)),
      ]);
      final snapshot = ComputeChurnRetentionSnapshot.call(
          transactions, now, const Duration(days: 30));
      expect(BuildChurnRetentionNarrative.call(snapshot),
          contains('loyalty offers'));
    });
  });
}
