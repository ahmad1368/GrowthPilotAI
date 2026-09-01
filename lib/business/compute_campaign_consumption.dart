import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';

/// Consumption percentages (0.0-1.0) against each configured cap
/// (Issue #409) — surfaced on the admin dashboard so remaining
/// capacity is visible before a campaign hits a hard limit.
class ComputeCampaignConsumption {
  static ({double timePercent, double impressionPercent, double clickPercent}) call({
    required DateTime requestedAt,
    required AdCampaignConstraintEntity constraint,
    required int impressionCount,
    required int clickCount,
    required DateTime now,
  }) {
    final elapsedDays = now.difference(requestedAt).inHours / 24;
    return (
      timePercent: (elapsedDays / constraint.maxDurationDays).clamp(0.0, 1.0),
      impressionPercent: (impressionCount / constraint.maxImpressions).clamp(0.0, 1.0),
      clickPercent: (clickCount / constraint.maxClicks).clamp(0.0, 1.0),
    );
  }
}
