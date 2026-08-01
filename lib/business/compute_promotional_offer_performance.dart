import 'package:growth_pilot_ai/core/data/entities/promotional_offer_entity.dart';
import 'package:growth_pilot_ai/core/models/promotional_offer_performance.dart';

/// Derives each logged offer's open/usage rate among the merchants it was
/// dispatched to (Issue #335) — this app has no backend
/// directory/messaging service, so dispatch volume and engagement are
/// logged manually instead.
class ComputePromotionalOfferPerformance {
  static List<PromotionalOfferPerformance> call(List<PromotionalOfferEntity> offers) {
    final results = offers.map((o) {
      final openRate =
          o.sentCount == 0 ? 0.0 : (o.openedCount / o.sentCount) * 100;
      final usageRate =
          o.sentCount == 0 ? 0.0 : (o.usedCount / o.sentCount) * 100;

      return PromotionalOfferPerformance(
        offerText: o.offerText,
        targetFilter: o.targetFilter,
        sentCount: o.sentCount,
        openRatePercent: double.parse(openRate.toStringAsFixed(2)),
        usageRatePercent: double.parse(usageRate.toStringAsFixed(2)),
        dispatchedAt: o.dispatchedAt,
      );
    }).toList();

    results.sort((a, b) => b.usageRatePercent.compareTo(a.usageRatePercent));
    return results;
  }
}
