import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';

/// Checks one campaign's time/impression/click caps in that priority
/// order (Issue #409, acceptance criteria 1-3) — time expiry is
/// checked first since an expired-but-under-cap campaign should still
/// read as expired, not active.
class EvaluateCampaignConstraint {
  static CampaignConstraintStatus call({
    required DateTime requestedAt,
    required AdCampaignConstraintEntity constraint,
    required int impressionCount,
    required int clickCount,
    required DateTime now,
  }) {
    final expiresAt = requestedAt.add(Duration(days: constraint.maxDurationDays));
    if (!now.isBefore(expiresAt)) return CampaignConstraintStatus.expiredByTime;
    if (impressionCount >= constraint.maxImpressions) {
      return CampaignConstraintStatus.cappedByImpressions;
    }
    if (clickCount >= constraint.maxClicks) return CampaignConstraintStatus.cappedByClicks;
    return CampaignConstraintStatus.active;
  }
}
