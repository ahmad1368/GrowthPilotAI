import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_exchange_rate_narrative.dart';
import 'package:growth_pilot_ai/business/compute_exchange_rate_impacts.dart';
import 'package:growth_pilot_ai/core/data/entities/exchange_rate_observation_entity.dart';

ExchangeRateObservationEntity _obs({
  String currencyPair = 'USD/CAD',
  String productName = 'Widget',
  required double baselineRate,
  required double currentRate,
  double importCostForeign = 100,
  DateTime? observedAt,
}) =>
    ExchangeRateObservationEntity(
      currencyPair: currencyPair,
      productName: productName,
      baselineRate: baselineRate,
      currentRate: currentRate,
      importCostForeign: importCostForeign,
      observedAt: observedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeExchangeRateImpacts', () {
    test('returns empty list when no observations are logged', () {
      expect(ComputeExchangeRateImpacts.call(const []), isEmpty);
    });

    test('computes landed cost impact from baseline to current rate', () {
      final result = ComputeExchangeRateImpacts.call(
              [_obs(baselineRate: 1.30, currentRate: 1.43, importCostForeign: 100)])
          .single;

      expect(result.landedCostBaseline, closeTo(130, 1e-9));
      expect(result.landedCostCurrent, closeTo(143, 1e-9));
      expect(result.costImpact, closeTo(13, 1e-9));
      expect(result.costImpactPercent, closeTo(10.0, 1e-9));
      expect(result.costIncreased, isTrue);
    });

    test('flags a falling rate as a cost decrease', () {
      final result = ComputeExchangeRateImpacts.call(
              [_obs(baselineRate: 1.40, currentRate: 1.26, importCostForeign: 100)])
          .single;

      expect(result.costImpact, lessThan(0));
      expect(result.costIncreased, isFalse);
    });

    test('guards against division by zero when import cost is 0', () {
      final result = ComputeExchangeRateImpacts.call(
              [_obs(baselineRate: 1.30, currentRate: 1.43, importCostForeign: 0)])
          .single;

      expect(result.costImpactPercent, 0);
    });

    test('sorts observations by cost impact percent descending', () {
      final low = _obs(
          productName: 'Low Risk', baselineRate: 1.30, currentRate: 1.32);
      final high = _obs(
          productName: 'High Risk', baselineRate: 1.30, currentRate: 1.60);

      final results = ComputeExchangeRateImpacts.call([low, high]);
      expect(results.first.productName, 'High Risk');
      expect(results.last.productName, 'Low Risk');
    });
  });

  group('BuildExchangeRateNarrative', () {
    test('falls back when no observations are logged', () {
      expect(BuildExchangeRateNarrative.call(const []),
          contains('No exchange rate checks logged'));
    });

    test('describes a single logged rate increase', () {
      final results = ComputeExchangeRateImpacts.call(
          [_obs(productName: 'Widget', baselineRate: 1.30, currentRate: 1.43)]);
      final narrative = BuildExchangeRateNarrative.call(results);
      expect(narrative, contains('Widget'));
      expect(narrative, contains('rose'));
    });

    test('describes a single logged rate decrease', () {
      final results = ComputeExchangeRateImpacts.call(
          [_obs(productName: 'Widget', baselineRate: 1.40, currentRate: 1.26)]);
      final narrative = BuildExchangeRateNarrative.call(results);
      expect(narrative, contains('fell'));
    });

    test('names the biggest risk and safest product when multiple exist', () {
      final low = _obs(
          productName: 'Low Risk', baselineRate: 1.30, currentRate: 1.32);
      final high = _obs(
          productName: 'High Risk', baselineRate: 1.30, currentRate: 1.60);

      final results = ComputeExchangeRateImpacts.call([low, high]);
      final narrative = BuildExchangeRateNarrative.call(results);
      expect(narrative, contains('High Risk'));
      expect(narrative, contains('Low Risk'));
    });
  });
}
