import 'package:growth_pilot_ai/business/build_campaign_alert_narrative.dart';
import 'package:growth_pilot_ai/business/compute_campaign_consumption.dart';
import 'package:growth_pilot_ai/business/evaluate_campaign_constraint.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';
import 'package:growth_pilot_ai/core/models/campaign_constraint_snapshot.dart';

/// Builds one request's evaluated snapshot (Issue #409) — split out of
/// [BuildCampaignConstraintSnapshots] to stay under the file line cap.
class EvaluateCampaignSnapshot {
  static CampaignConstraintSnapshot call(AdvertisingRequestEntity request,
      AdCampaignConstraintEntity constraint, PromoCardMetricsEntity? metrics, DateTime now) {
    final impressions = metrics?.impressionCount ?? 0;
    final clicks = metrics?.clickCount ?? 0;
    final status = EvaluateCampaignConstraint.call(
        requestedAt: request.requestedAt,
        constraint: constraint,
        impressionCount: impressions,
        clickCount: clicks,
        now: now);
    final consumption = ComputeCampaignConsumption.call(
        requestedAt: request.requestedAt,
        constraint: constraint,
        impressionCount: impressions,
        clickCount: clicks,
        now: now);
    return CampaignConstraintSnapshot(
      request: request,
      status: status,
      timePercent: consumption.timePercent,
      impressionPercent: consumption.impressionPercent,
      clickPercent: consumption.clickPercent,
      alert: BuildCampaignAlertNarrative.call(status, consumption),
    );
  }
}
