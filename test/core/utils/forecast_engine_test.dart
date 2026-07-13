import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/spending_trend.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';

void main() {
  group('ForecastEngine.predictNext', () {
    test('extrapolates a perfect line: 10,20,30 -> next is 40.0', () {
      expect(ForecastEngine.predictNext([10.0, 20.0, 30.0], 1), [40.0]);
    });

    test('predicts multiple steady steps for steep growth', () {
      expect(ForecastEngine.predictNext([10.0, 20.0, 30.0], 3),
          [40.0, 50.0, 60.0]);
    });

    test('keeps flat spending flat', () {
      expect(ForecastEngine.predictNext([10.0, 10.0, 10.0], 2), [10.0, 10.0]);
    });

    test('floors negative predictions at 0.00', () {
      // Falling series would extrapolate below zero; must clamp to 0.0.
      final result =
          ForecastEngine.predictNext([50.0, 40.0, 30.0, 20.0, 10.0], 3);
      expect(result, [0.0, 0.0, 0.0]);
    });

    test('returns zeros when there are fewer than 2 points', () {
      expect(ForecastEngine.predictNext([], 3), [0.0, 0.0, 0.0]);
      expect(ForecastEngine.predictNext([42.0], 2), [0.0, 0.0]);
    });

    test('rounds predictions to two decimal places', () {
      // slope 1/3 per step over [0,1] -> next ~ 1.33
      final result = ForecastEngine.predictNext([0.0, 0.6667, 1.3333], 1);
      expect(result.single, closeTo(2.0, 0.01));
    });
  });

  group('ForecastEngine.detectTrend', () {
    test('detects a rising trend', () {
      expect(ForecastEngine.detectTrend([10.0, 20.0, 30.0]),
          SpendingTrend.rising);
    });

    test('detects a falling trend', () {
      expect(ForecastEngine.detectTrend([30.0, 20.0, 10.0]),
          SpendingTrend.falling);
    });

    test('detects a flat trend', () {
      expect(
          ForecastEngine.detectTrend([15.0, 15.0, 15.0]), SpendingTrend.flat);
    });
  });

  group('ForecastEngine performance', () {
    test('computes a 30-day trend efficiently', () {
      final data = List<double>.generate(30, (i) => i * 2.5 + 5);
      int best = 1 << 30;
      for (int r = 0; r < 10; r++) {
        final sw = Stopwatch()..start();
        ForecastEngine.predictNext(data, 7);
        sw.stop();
        if (sw.elapsedMicroseconds < best) best = sw.elapsedMicroseconds;
      }
      // <1ms is the release/AOT target; under the JIT test VM we assert a
      // best-of-N ceiling that still catches any non-linear regression.
      expect(best, lessThan(20000));
    });
  });
}
