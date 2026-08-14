import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_local_benchmark.dart';
import 'package:growth_pilot_ai/core/models/local_benchmark_params.dart';

void main() {
  group('ComputeLocalBenchmark', () {
    test('returns null percentile/mean when there is no target price position', () {
      final result = ComputeLocalBenchmark.call(
        const LocalBenchmarkParams(targetPricePosition: null, peerPricePositions: [0.1, 0.2, 0.3]),
      );
      expect(result.percentile, isNull);
      expect(result.marketMean, isNull);
      expect(result.peerCount, 3);
    });

    test('returns null percentile/mean when there are no local peers', () {
      final result = ComputeLocalBenchmark.call(
        const LocalBenchmarkParams(targetPricePosition: 0.5, peerPricePositions: []),
      );
      expect(result.percentile, isNull);
      expect(result.marketMean, isNull);
      expect(result.peerCount, 0);
    });

    test('computes the percentile and mean against the local peer set', () {
      final result = ComputeLocalBenchmark.call(
        const LocalBenchmarkParams(
          targetPricePosition: 0.5,
          peerPricePositions: [0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8],
        ),
      );
      expect(result.percentile, isNotNull);
      expect(result.marketMean, closeTo(0.443, 1e-3));
      expect(result.peerCount, 7);
    });
  });
}
