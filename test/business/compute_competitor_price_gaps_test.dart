import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_competitor_price_narrative.dart';
import 'package:growth_pilot_ai/business/compute_competitor_price_gaps.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';

CompetitorPriceObservationEntity _observation(
  String product,
  String competitor,
  double ourPrice,
  double competitorPrice,
) =>
    CompetitorPriceObservationEntity(
      productName: product,
      competitorName: competitor,
      ourPrice: ourPrice,
      competitorPrice: competitorPrice,
      observedAt: DateTime(2024, 1, 1),
    );

void main() {
  group('ComputeCompetitorPriceGaps', () {
    test('returns empty list when no observations are logged', () {
      expect(ComputeCompetitorPriceGaps.call(const []), isEmpty);
    });

    test('flags a positive gap when priced above the competitor', () {
      final result = ComputeCompetitorPriceGaps.call(
              [_observation('Widget', 'Acme', 120, 100)])
          .single;

      expect(result.priceGap, 20);
      expect(result.gapPercent, closeTo(20, 1e-9));
      expect(result.isPricedAboveCompetitor, isTrue);
    });

    test('flags a negative gap when priced below the competitor', () {
      final result = ComputeCompetitorPriceGaps.call(
              [_observation('Widget', 'Acme', 80, 100)])
          .single;

      expect(result.priceGap, -20);
      expect(result.isPricedAboveCompetitor, isFalse);
    });

    test('guards against division by zero when competitor price is 0', () {
      final result = ComputeCompetitorPriceGaps.call(
              [_observation('Widget', 'Acme', 10, 0)])
          .single;

      expect(result.gapPercent, 0);
    });

    test('sorts observations by gap percent descending', () {
      final overpriced = _observation('Overpriced', 'Acme', 150, 100);
      final underpriced = _observation('Underpriced', 'Acme', 50, 100);

      final results =
          ComputeCompetitorPriceGaps.call([underpriced, overpriced]);
      expect(results.first.productName, 'Overpriced');
      expect(results.last.productName, 'Underpriced');
    });
  });

  group('BuildCompetitorPriceNarrative', () {
    test('falls back when no observations are logged', () {
      expect(BuildCompetitorPriceNarrative.call(const []),
          contains('No competitor prices logged'));
    });

    test('describes the single logged observation', () {
      final results = ComputeCompetitorPriceGaps.call(
          [_observation('Widget', 'Acme', 120, 100)]);
      expect(BuildCompetitorPriceNarrative.call(results), contains('Widget'));
    });

    test('names the biggest risk and best advantage when multiple exist', () {
      final overpriced = _observation('Overpriced', 'Acme', 150, 100);
      final underpriced = _observation('Underpriced', 'Acme', 50, 100);

      final results =
          ComputeCompetitorPriceGaps.call([underpriced, overpriced]);
      final narrative = BuildCompetitorPriceNarrative.call(results);
      expect(narrative, contains('Overpriced'));
      expect(narrative, contains('Underpriced'));
    });
  });
}
