import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_price_volatility_narrative.dart';
import 'package:growth_pilot_ai/business/compute_price_volatility_alerts.dart';
import 'package:growth_pilot_ai/business/dispatch_price_volatility_alerts.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';

CompetitorPriceObservationEntity _observation({
  String productName = 'Milk 2L',
  double ourPrice = 4,
  DateTime? observedAt,
}) =>
    CompetitorPriceObservationEntity(
      productName: productName,
      competitorName: 'N/A',
      ourPrice: ourPrice,
      competitorPrice: 0,
      observedAt: observedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputePriceVolatilityAlerts', () {
    test('returns empty list when no observations are logged', () {
      expect(ComputePriceVolatilityAlerts.call(const [], 10), isEmpty);
    });

    test('ignores products with only one logged observation', () {
      expect(
          ComputePriceVolatilityAlerts.call([_observation()], 10), isEmpty);
    });

    test('computes percent change between the two most recent readings', () {
      final result = ComputePriceVolatilityAlerts.call([
        _observation(ourPrice: 4, observedAt: DateTime(2024, 1, 1)),
        _observation(ourPrice: 5, observedAt: DateTime(2024, 2, 1)),
      ], 10).single;

      expect(result.changePercent, closeTo(25.0, 1e-9));
      expect(result.isBreached, isTrue);
    });

    test('does not flag a swing under the threshold', () {
      final result = ComputePriceVolatilityAlerts.call([
        _observation(ourPrice: 4, observedAt: DateTime(2024, 1, 1)),
        _observation(ourPrice: 4.1, observedAt: DateTime(2024, 2, 1)),
      ], 10).single;

      expect(result.isBreached, isFalse);
    });

    test('sorts by absolute change magnitude descending', () {
      final results = ComputePriceVolatilityAlerts.call([
        _observation(productName: 'Small', ourPrice: 10, observedAt: DateTime(2024, 1, 1)),
        _observation(productName: 'Small', ourPrice: 10.5, observedAt: DateTime(2024, 2, 1)),
        _observation(productName: 'Big', ourPrice: 10, observedAt: DateTime(2024, 1, 1)),
        _observation(productName: 'Big', ourPrice: 15, observedAt: DateTime(2024, 2, 1)),
      ], 10);

      expect(results.first.productName, 'Big');
      expect(results.last.productName, 'Small');
    });
  });

  group('DispatchPriceVolatilityAlerts', () {
    test('only dispatches breached alerts not already notified', () {
      final results = ComputePriceVolatilityAlerts.call([
        _observation(productName: 'Milk 2L', ourPrice: 4, observedAt: DateTime(2024, 1, 1)),
        _observation(productName: 'Milk 2L', ourPrice: 5, observedAt: DateTime(2024, 2, 1)),
        _observation(productName: 'Bread', ourPrice: 3, observedAt: DateTime(2024, 1, 1)),
        _observation(productName: 'Bread', ourPrice: 3.05, observedAt: DateTime(2024, 2, 1)),
      ], 10);

      final dispatched = DispatchPriceVolatilityAlerts.call(results, {});
      expect(dispatched, hasLength(1));
      expect(dispatched.single.title, contains('Milk 2L'));
    });

    test('skips alerts already present in alreadyDispatchedIds', () {
      final results = ComputePriceVolatilityAlerts.call([
        _observation(ourPrice: 4, observedAt: DateTime(2024, 1, 1)),
        _observation(ourPrice: 5, observedAt: DateTime(2024, 2, 1)),
      ], 10);
      final key = 'Milk 2L|${DateTime(2024, 2, 1).toIso8601String()}';

      expect(DispatchPriceVolatilityAlerts.call(results, {key}), isEmpty);
    });
  });

  group('BuildPriceVolatilityNarrative', () {
    test('falls back when no observations are logged', () {
      expect(BuildPriceVolatilityNarrative.call(const []),
          contains('No price observations logged'));
    });

    test('names the most severe swing', () {
      final results = ComputePriceVolatilityAlerts.call([
        _observation(ourPrice: 4, observedAt: DateTime(2024, 1, 1)),
        _observation(ourPrice: 6, observedAt: DateTime(2024, 2, 1)),
      ], 10);

      final narrative = BuildPriceVolatilityNarrative.call(results);
      expect(narrative, contains('Milk 2L'));
      expect(narrative, contains('up'));
    });
  });
}
