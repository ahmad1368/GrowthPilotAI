import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/financial_comparison.dart';
import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';

/// Unit tests for [AnalyticsUtils] — the pure numerical engine described in
/// Issue #29. These verify the acceptance criteria directly against the
/// utility methods (no ObjectBox / repositories involved, so no mocking is
/// required — all math runs in RAM).
void main() {
  group('AnalyticsUtils.calculateGrowthRate', () {
    test('should return exactly 50.0 when value moves from \$100 to \$150', () {
      expect(AnalyticsUtils.calculateGrowthRate(150.0, 100.0), 50.0);
    });

    test('should return a negative rate when spending decreases', () {
      expect(AnalyticsUtils.calculateGrowthRate(80.0, 100.0), -20.0);
    });

    test('should return 100.0 when previous is 0 and current is positive', () {
      // Division-by-zero guard: a jump from \$0 is treated as 100% growth.
      expect(AnalyticsUtils.calculateGrowthRate(250.0, 0.0), 100.0);
    });

    test('should return 0.0 when both previous and current are 0', () {
      expect(AnalyticsUtils.calculateGrowthRate(0.0, 0.0), 0.0);
    });

    test('should round the growth rate to exactly 2 decimal places', () {
      // 100 -> 133.333... = 33.333...%  ->  rounded to 33.33
      expect(AnalyticsUtils.calculateGrowthRate(133.3333, 100.0), 33.33);
    });
  });

  group('AnalyticsUtils.calculateAverage', () {
    test('should return the arithmetic mean of the values', () {
      expect(AnalyticsUtils.calculateAverage([10.0, 20.0, 30.0]), 20.0);
    });

    test('should return 0.0 for an empty list without crashing', () {
      expect(AnalyticsUtils.calculateAverage([]), 0.0);
    });

    test('should round the average to 2 decimal places', () {
      // (10 + 20 + 25) / 3 = 18.333... -> 18.33
      expect(AnalyticsUtils.calculateAverage([10.0, 20.0, 25.0]), 18.33);
    });
  });

  group('AnalyticsUtils.movingAverage', () {
    test('should smooth a series using the given window size', () {
      // window of 2 over [10,20,30,40] -> [15, 25, 35]
      expect(
        AnalyticsUtils.movingAverage([10.0, 20.0, 30.0, 40.0], 2),
        [15.0, 25.0, 35.0],
      );
    });

    test('should return an empty list when the data is empty', () {
      expect(AnalyticsUtils.movingAverage([], 3), isEmpty);
    });

    test('should return an empty list when window is larger than the data', () {
      expect(AnalyticsUtils.movingAverage([1.0, 2.0], 5), isEmpty);
    });

    test('should return an empty list for a non-positive window size', () {
      expect(AnalyticsUtils.movingAverage([1.0, 2.0, 3.0], 0), isEmpty);
    });
  });

  group('AnalyticsUtils.comparePeriods', () {
    test('should flag an expense increase as a negative (red) trend', () {
      final result =
          AnalyticsUtils.comparePeriods([150.0], [100.0], /*isExpense*/ true);

      expect(result.totalDifference, 50.0);
      expect(result.percentageChange, 50.0);
      expect(result.isNegativeTrend, isTrue);
    });

    test('should flag an income increase as a positive (green) trend', () {
      final result =
          AnalyticsUtils.comparePeriods([150.0], [100.0], /*isExpense*/ false);

      expect(result.totalDifference, 50.0);
      expect(result.percentageChange, 50.0);
      expect(result.isNegativeTrend, isFalse);
    });

    test('should handle empty period lists without a division error', () {
      final result = AnalyticsUtils.comparePeriods([], [], true);

      expect(result.totalDifference, 0.0);
      expect(result.percentageChange, 0.0);
      expect(result.isNegativeTrend, isFalse);
    });
  });

  group('AnalyticsUtils performance', () {
    test('should process 1,000 transaction amounts in under 10ms', () {
      // Build two realistic 1,000-element periods of transaction amounts.
      final current =
          List<double>.generate(1000, (i) => (i + 1) * 1.5);
      final previous =
          List<double>.generate(1000, (i) => (i + 1) * 1.0);

      final stopwatch = Stopwatch()..start();
      final FinancialComparison result =
          AnalyticsUtils.comparePeriods(current, previous, true);
      stopwatch.stop();

      // Sanity-check the math actually ran.
      expect(result.percentageChange, greaterThan(0));
      expect(
        stopwatch.elapsedMicroseconds,
        lessThan(10000), // 10ms == 10,000 microseconds
        reason: 'Aggregating 1,000 amounts must stay under the 10ms budget',
      );
    });
  });
}
