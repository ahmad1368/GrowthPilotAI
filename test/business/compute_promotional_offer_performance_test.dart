import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_promotional_offer_narrative.dart';
import 'package:growth_pilot_ai/business/compute_promotional_offer_performance.dart';
import 'package:growth_pilot_ai/core/data/entities/promotional_offer_entity.dart';

PromotionalOfferEntity _offer({
  String offerText = '20% off',
  String targetFilter = 'Downtown',
  required int sentCount,
  int openedCount = 0,
  int usedCount = 0,
  DateTime? dispatchedAt,
}) =>
    PromotionalOfferEntity(
      offerText: offerText,
      targetFilter: targetFilter,
      sentCount: sentCount,
      openedCount: openedCount,
      usedCount: usedCount,
      dispatchedAt: dispatchedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputePromotionalOfferPerformance', () {
    test('returns empty list when no offers are logged', () {
      expect(ComputePromotionalOfferPerformance.call(const []), isEmpty);
    });

    test('computes open and usage rates from logged counts', () {
      final result = ComputePromotionalOfferPerformance.call(
          [_offer(sentCount: 100, openedCount: 40, usedCount: 10)]).single;

      expect(result.openRatePercent, closeTo(40.0, 1e-9));
      expect(result.usageRatePercent, closeTo(10.0, 1e-9));
    });

    test('avoids division by zero when no merchants were sent the offer', () {
      final result = ComputePromotionalOfferPerformance.call(
          [_offer(sentCount: 0, openedCount: 0, usedCount: 0)]).single;

      expect(result.openRatePercent, 0);
      expect(result.usageRatePercent, 0);
    });

    test('sorts offers by usage rate descending', () {
      final results = ComputePromotionalOfferPerformance.call([
        _offer(offerText: 'Low', sentCount: 100, usedCount: 5),
        _offer(offerText: 'High', sentCount: 100, usedCount: 50),
      ]);

      expect(results.first.offerText, 'High');
      expect(results.last.offerText, 'Low');
    });
  });

  group('BuildPromotionalOfferNarrative', () {
    test('falls back when no offers are logged', () {
      expect(BuildPromotionalOfferNarrative.call(const []),
          contains('No offers dispatched'));
    });

    test('names the best-performing offer and its target', () {
      final results = ComputePromotionalOfferPerformance.call([
        _offer(
            offerText: 'Grand Reopening',
            targetFilter: 'Kitsilano',
            sentCount: 100,
            openedCount: 60,
            usedCount: 30),
      ]);

      final narrative = BuildPromotionalOfferNarrative.call(results);
      expect(narrative, contains('Grand Reopening'));
      expect(narrative, contains('Kitsilano'));
    });
  });
}
