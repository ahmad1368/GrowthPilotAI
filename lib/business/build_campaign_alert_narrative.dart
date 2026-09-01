import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';

/// Merchant-facing alert text for a campaign approaching or past a cap
/// (Issue #409, acceptance criterion 5) — returns null when there is
/// nothing worth surfacing (comfortably under every threshold).
class BuildCampaignAlertNarrative {
  static const _nearThreshold = 0.8;

  static String? call(
    CampaignConstraintStatus status,
    ({double timePercent, double impressionPercent, double clickPercent}) consumption,
  ) {
    if (status == CampaignConstraintStatus.expiredByTime) {
      return 'Campaign window has expired.';
    }
    if (status == CampaignConstraintStatus.cappedByImpressions) {
      return 'Impression cap reached; campaign deactivated.';
    }
    if (status == CampaignConstraintStatus.cappedByClicks) {
      return 'Click cap reached; campaign deactivated.';
    }
    final maxPercent = [
      consumption.timePercent,
      consumption.impressionPercent,
      consumption.clickPercent,
    ].reduce((a, b) => a > b ? a : b);

    if (maxPercent < _nearThreshold) return null;
    return 'Approaching cap: ${(maxPercent * 100).round()}% consumed.';
  }
}
