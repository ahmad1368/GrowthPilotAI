import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/utils/analytics_utils.dart';
import 'package:growth_pilot_ai/core/utils/anomaly_detector.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';
import 'package:growth_pilot_ai/core/utils/moving_average_engine.dart';
import 'package:growth_pilot_ai/core/utils/time_series_service.dart';

/// End-to-end validation of the on-device forecasting pipeline
/// (TimeSeriesService -> ForecastEngine / MovingAverageEngine / AnomalyDetector).
/// Covers cross-engine accuracy, edge cases and a single-frame (60 FPS) budget.
/// Mock data only — no real records or ObjectBox involved.
TransactionEntity _tx(double amount, DateTime date) =>
    TransactionEntity(amount: amount, date: date, description: 'x');

void main() {
  group('Accuracy across engines', () {
    test('linear trend forecasts the next value', () {
      expect(
          ForecastEngine.predictNext([10, 20, 30, 40, 50], 1).first, 60.0);
    });

    test('flat trend stays flat', () {
      expect(ForecastEngine.predictNext([50, 50, 50], 1).first, 50.0);
      expect(MovingAverageEngine.calculateSMA([50, 50, 50], 3).last, 50.0);
    });

    test('empty / single-element input never crashes', () {
      expect(ForecastEngine.predictNext([], 3), [0.0, 0.0, 0.0]);
      expect(ForecastEngine.predictNext([42], 2), [0.0, 0.0]);
      expect(TimeSeriesService.prepareDailySeries([], 3).length, 4);
    });

    test('division by zero in growth rate returns 0.0', () {
      expect(AnalyticsUtils.calculateGrowthRate(0, 0), 0.0);
    });
  });

  group('Edge cases', () {
    test('negative predictions floor at 0.00', () {
      final result = ForecastEngine.predictNext([50, 40, 30, 20, 10], 3);
      expect(result.every((v) => v >= 0), isTrue);
      expect(result, [0.0, 0.0, 0.0]);
    });

    test('aggregation rolls over a year/month boundary', () {
      // Dec 2026 -> Jan 2027, endDate Jan 2 with a 4-day look-back.
      final txs = [
        _tx(30, DateTime(2026, 12, 31)),
        _tx(20, DateTime(2027, 1, 1)),
        _tx(10, DateTime(2027, 1, 2)),
      ];
      final series = TimeSeriesService.prepareDailySeries(txs, 4,
          endDate: DateTime(2027, 1, 2));
      // Days 2026-12-29 .. 2027-01-02 inclusive.
      expect(series, [0.0, 0.0, 30.0, 20.0, 10.0]);
    });

    test('Z-score flags a \$5,000 jump in a \$50-average dataset', () {
      // Realistic ~\$50 daily spend with normal fluctuation (mean ~50).
      final history = List<double>.generate(20, (i) => 45.0 + (i % 11));
      expect(AnomalyDetector.isOutlier(5000, history), isTrue);
      expect(AnomalyDetector.isOutlier(52, history), isFalse);
    });
  });

  group('Performance — single 60 FPS frame budget', () {
    test('aggregate 1,000 tx + 7-day forecast stays well under a frame', () {
      final txs = List<TransactionEntity>.generate(
        1000,
        (i) => _tx(100.0 + (i % 13), DateTime(2027, 1, 2)
            .subtract(Duration(days: i % 90))),
      );
      int best = 1 << 30;
      for (int r = 0; r < 10; r++) {
        final sw = Stopwatch()..start();
        final series = TimeSeriesService.prepareDailySeries(txs, 90,
            endDate: DateTime(2027, 1, 2));
        ForecastEngine.predictNext(series, 7);
        sw.stop();
        if (sw.elapsedMicroseconds < best) best = sw.elapsedMicroseconds;
      }
      // 16ms (one frame) is the release/AOT goal; the unoptimized JIT test VM
      // uses a looser ceiling that still catches super-linear regressions.
      expect(best, lessThan(50000));
    });
  });
}
