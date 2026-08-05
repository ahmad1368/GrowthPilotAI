import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_campaign_alert_narrative.dart';
import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';

void main() {
  test('comfortably under every threshold returns no alert', () {
    final result = BuildCampaignAlertNarrative.call(
      CampaignConstraintStatus.active,
      (timePercent: 0.2, impressionPercent: 0.3, clickPercent: 0.1),
    );

    expect(result, isNull);
  });

  test('approaching a threshold returns a consumption alert', () {
    final result = BuildCampaignAlertNarrative.call(
      CampaignConstraintStatus.active,
      (timePercent: 0.85, impressionPercent: 0.3, clickPercent: 0.1),
    );

    expect(result, contains('85%'));
  });

  test('an expired campaign returns an expiry alert regardless of consumption', () {
    final result = BuildCampaignAlertNarrative.call(
      CampaignConstraintStatus.expiredByTime,
      (timePercent: 1.0, impressionPercent: 0.1, clickPercent: 0.1),
    );

    expect(result, contains('expired'));
  });

  test('a click-capped campaign returns a deactivation alert', () {
    final result = BuildCampaignAlertNarrative.call(
      CampaignConstraintStatus.cappedByClicks,
      (timePercent: 0.5, impressionPercent: 0.5, clickPercent: 1.0),
    );

    expect(result, contains('Click cap'));
  });
}
