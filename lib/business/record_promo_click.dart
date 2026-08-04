import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';

/// Builds the updated telemetry row after a sponsored card is tapped
/// (Issue #402, acceptance criterion 4) — pure construction, the caller
/// persists the result.
class RecordPromoClick {
  static PromoCardMetricsEntity call(PromoCardMetricsEntity existing) {
    return PromoCardMetricsEntity(
      id: existing.id,
      advertisingRequestId: existing.advertisingRequestId,
      impressionCount: existing.impressionCount,
      clickCount: existing.clickCount + 1,
      lastImpressionAt: existing.lastImpressionAt,
    );
  }
}
