import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/anomaly_detector.dart';

void main() {
  group('AnomalyDetector.standardDeviation', () {
    test('matches the textbook population standard deviation', () {
      // [2,4,4,4,5,5,7,9] -> mean 5, variance 4, stdDev 2.
      expect(
        AnomalyDetector.standardDeviation([2, 4, 4, 4, 5, 5, 7, 9]),
        2.0,
      );
    });

    test('is 0 for empty input', () {
      expect(AnomalyDetector.standardDeviation([]), 0.0);
    });
  });

  group('AnomalyDetector.isOutlier', () {
    final baseline = <double>[
      100, 102, 98, 101, 99, 100, 103, 97, 100, 101,
    ];

    test('flags a value far beyond mean + 2 sigma', () {
      expect(AnomalyDetector.isOutlier(500, baseline), isTrue);
    });

    test('does not flag a value within the normal range', () {
      expect(AnomalyDetector.isOutlier(101, baseline), isFalse);
    });

    test('never flags before 10 baseline points exist', () {
      expect(AnomalyDetector.isOutlier(9999, [100, 100, 100]), isFalse);
    });
  });

  group('AnomalyDetector.detectAnomalies', () {
    test('returns the index of a clear spike', () {
      final series = <double>[
        100, 101, 99, 100, 102, 98, 100, 101, 99, 100, 100, 900,
      ];
      final anomalies = AnomalyDetector.detectAnomalies(series);
      expect(anomalies, contains(11));
      expect(anomalies, isNot(contains(0)));
    });

    test('returns empty below the baseline threshold', () {
      expect(AnomalyDetector.detectAnomalies([1, 2, 3]), isEmpty);
    });
  });

  group('AnomalyDetector performance', () {
    test('scans 1,000 days efficiently', () {
      final data = List<double>.generate(1000, (i) => 100.0 + (i % 7));
      int best = 1 << 30;
      for (int r = 0; r < 10; r++) {
        final sw = Stopwatch()..start();
        AnomalyDetector.detectAnomalies(data);
        sw.stop();
        if (sw.elapsedMicroseconds < best) best = sw.elapsedMicroseconds;
      }
      // <5ms is the release/AOT goal; JIT VM uses a looser ceiling.
      expect(best, lessThan(30000));
    });
  });
}
