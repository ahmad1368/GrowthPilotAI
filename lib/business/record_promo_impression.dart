import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';

/// Builds the updated telemetry row after a sponsored card crosses the
/// viewability threshold (Issue #402, acceptance criterion 3) — pure
/// construction, the caller persists the result.
class RecordPromoImpression {
  static PromoCardMetricsEntity call(
      PromoCardMetricsEntity? existing, int advertisingRequestId, DateTime now) {
    return PromoCardMetricsEntity(
      id: existing?.id ?? 0,
      advertisingRequestId: advertisingRequestId,
      impressionCount: (existing?.impressionCount ?? 0) + 1,
      clickCount: existing?.clickCount ?? 0,
      lastImpressionAt: now,
    );
  }
}
