import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/moving_average_engine.dart';

void main() {
  group('MovingAverageEngine.calculateSMA', () {
    test('smooths with a 2-day window and keeps the input length', () {
      final sma = MovingAverageEngine.calculateSMA([10.0, 20.0, 30.0, 40.0], 2);
      expect(sma, [10.0, 15.0, 25.0, 35.0]);
    });

    test('handles startup by averaging only available points', () {
      // First point equals the raw value (window of 1 so far).
      final sma =
          MovingAverageEngine.calculateSMA([12.0, 18.0, 24.0], 7);
      expect(sma.length, 3);
      expect(sma.first, 12.0);
      expect(sma[1], 15.0); // (12 + 18) / 2
    });

    test('returns an empty list for empty data', () {
      expect(MovingAverageEngine.calculateSMA([], 7), isEmpty);
    });
  });

  group('MovingAverageEngine.calculateWMA', () {
    test('divides by the triangular weight sum (3-day divisor = 6)', () {
      // (1*1 + 2*2 + 3*3) / 6 = 14 / 6 = 2.33
      final wma = MovingAverageEngine.calculateWMA([1.0, 2.0, 3.0], 3);
      expect(wma, [1.0, 2.0, 2.33]);
    });

    test('reacts faster than SMA to a spike on the most recent day', () {
      final data = [10.0, 10.0, 10.0, 10.0, 10.0, 10.0, 100.0];
      final sma = MovingAverageEngine.calculateSMA(data, 7);
      final wma = MovingAverageEngine.calculateWMA(data, 7);
      // WMA weights the fresh spike more heavily than the SMA.
      expect(wma.last, greaterThan(sma.last));
    });

    test('returns an empty list for empty data', () {
      expect(MovingAverageEngine.calculateWMA([], 7), isEmpty);
    });
  });

  group('MovingAverageEngine performance', () {
    test('smooths a 365-day dataset efficiently', () {
      final data = List<double>.generate(365, (i) => (i % 30) * 3.0 + 5);
      int best = 1 << 30;
      for (int r = 0; r < 10; r++) {
        final sw = Stopwatch()..start();
        MovingAverageEngine.calculateSMA(data, 7);
        MovingAverageEngine.calculateWMA(data, 7);
        sw.stop();
        if (sw.elapsedMicroseconds < best) best = sw.elapsedMicroseconds;
      }
      // <2ms is the release/AOT target; JIT test VM uses a looser ceiling
      // that still fails on a super-linear regression.
      expect(best, lessThan(30000));
    });
  });
}
