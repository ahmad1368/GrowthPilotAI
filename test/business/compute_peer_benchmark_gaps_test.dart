import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_peer_benchmark_growth_tips.dart';
import 'package:growth_pilot_ai/business/compute_peer_benchmark_gaps.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';

void main() {
  group('ComputePeerBenchmarkGaps', () {
    test('flags axes below and at/above the sector benchmark', () {
      const user = BusinessCompassMetrics(
        liquidityRatio: 0.40,
        burnVelocity: 0.60,
        vendorDiversity: 0.85,
        paymentPunctuality: 0.70,
        profitMargin: 0.25,
      );
      const sector = BusinessCompassMetrics(
        liquidityRatio: 0.62,
        burnVelocity: 0.55,
        vendorDiversity: 0.70,
        paymentPunctuality: 0.80,
        profitMargin: 0.35,
      );

      final gaps = ComputePeerBenchmarkGaps.call(user, sector);

      expect(gaps.length, 5);
      final liquidity = gaps.firstWhere((g) => g.metricLabel == 'Liquidity');
      expect(liquidity.gap, closeTo(-0.22, 1e-9));
      expect(liquidity.isAboveBenchmark, isFalse);

      final vendorDiversity =
          gaps.firstWhere((g) => g.metricLabel == 'Vendor Diversity');
      expect(vendorDiversity.gap, closeTo(0.15, 1e-9));
      expect(vendorDiversity.isAboveBenchmark, isTrue);
    });

    test('treats an equal value as at-benchmark', () {
      const metrics = BusinessCompassMetrics(
        liquidityRatio: 0.5,
        burnVelocity: 0.5,
        vendorDiversity: 0.5,
        paymentPunctuality: 0.5,
        profitMargin: 0.5,
      );

      final gaps = ComputePeerBenchmarkGaps.call(metrics, metrics);

      expect(gaps.every((g) => g.isAboveBenchmark), isTrue);
      expect(gaps.every((g) => g.gap == 0), isTrue);
    });
  });

  group('BuildPeerBenchmarkGrowthTips', () {
    test('returns a tip only for below-benchmark axes', () {
      const user = BusinessCompassMetrics(
        liquidityRatio: 0.40,
        burnVelocity: 0.60,
        vendorDiversity: 0.85,
        paymentPunctuality: 0.70,
        profitMargin: 0.25,
      );
      const sector = BusinessCompassMetrics(
        liquidityRatio: 0.62,
        burnVelocity: 0.55,
        vendorDiversity: 0.70,
        paymentPunctuality: 0.80,
        profitMargin: 0.35,
      );

      final gaps = ComputePeerBenchmarkGaps.call(user, sector);
      final tips = BuildPeerBenchmarkGrowthTips.call(gaps);

      expect(tips.length, 3);
    });

    test('returns no tips when every axis is at or above benchmark', () {
      const metrics = BusinessCompassMetrics(
        liquidityRatio: 0.5,
        burnVelocity: 0.5,
        vendorDiversity: 0.5,
        paymentPunctuality: 0.5,
        profitMargin: 0.5,
      );

      final gaps = ComputePeerBenchmarkGaps.call(metrics, metrics);
      expect(BuildPeerBenchmarkGrowthTips.call(gaps), isEmpty);
    });
  });
}
