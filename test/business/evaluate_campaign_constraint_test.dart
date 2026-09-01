import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/evaluate_campaign_constraint.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';

AdCampaignConstraintEntity _constraint({
  int maxDurationDays = 7,
  int maxImpressions = 1000,
  int maxClicks = 100,
}) =>
    AdCampaignConstraintEntity(
      advertisingRequestId: 1,
      maxDurationDays: maxDurationDays,
      maxImpressions: maxImpressions,
      maxClicks: maxClicks,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  final requestedAt = DateTime(2026, 1, 1);

  test('a campaign under every threshold is active', () {
    final result = EvaluateCampaignConstraint.call(
      requestedAt: requestedAt,
      constraint: _constraint(),
      impressionCount: 10,
      clickCount: 1,
      now: requestedAt.add(const Duration(days: 1)),
    );

    expect(result, CampaignConstraintStatus.active);
  });

  test('a campaign past its duration window is expired, even under caps', () {
    final result = EvaluateCampaignConstraint.call(
      requestedAt: requestedAt,
      constraint: _constraint(maxDurationDays: 7),
      impressionCount: 0,
      clickCount: 0,
      now: requestedAt.add(const Duration(days: 8)),
    );

    expect(result, CampaignConstraintStatus.expiredByTime);
  });

  test('reaching the impression cap deactivates before the click cap is checked', () {
    final result = EvaluateCampaignConstraint.call(
      requestedAt: requestedAt,
      constraint: _constraint(maxImpressions: 1000, maxClicks: 100),
      impressionCount: 1000,
      clickCount: 5,
      now: requestedAt.add(const Duration(days: 1)),
    );

    expect(result, CampaignConstraintStatus.cappedByImpressions);
  });

  test('reaching the click cap deactivates the campaign', () {
    final result = EvaluateCampaignConstraint.call(
      requestedAt: requestedAt,
      constraint: _constraint(maxClicks: 100),
      impressionCount: 10,
      clickCount: 100,
      now: requestedAt.add(const Duration(days: 1)),
    );

    expect(result, CampaignConstraintStatus.cappedByClicks);
  });
}
