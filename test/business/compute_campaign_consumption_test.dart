import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_campaign_consumption.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';

void main() {
  final requestedAt = DateTime(2026, 1, 1);
  final constraint = AdCampaignConstraintEntity(
    advertisingRequestId: 1,
    maxDurationDays: 10,
    maxImpressions: 1000,
    maxClicks: 100,
    createdAt: requestedAt,
  );

  test('consumption percentages reflect elapsed time and counters', () {
    final result = ComputeCampaignConsumption.call(
      requestedAt: requestedAt,
      constraint: constraint,
      impressionCount: 500,
      clickCount: 50,
      now: requestedAt.add(const Duration(days: 5)),
    );

    expect(result.timePercent, closeTo(0.5, 0.01));
    expect(result.impressionPercent, closeTo(0.5, 0.01));
    expect(result.clickPercent, closeTo(0.5, 0.01));
  });

  test('percentages never exceed 1.0 once past a cap', () {
    final result = ComputeCampaignConsumption.call(
      requestedAt: requestedAt,
      constraint: constraint,
      impressionCount: 5000,
      clickCount: 500,
      now: requestedAt.add(const Duration(days: 30)),
    );

    expect(result.timePercent, 1.0);
    expect(result.impressionPercent, 1.0);
    expect(result.clickPercent, 1.0);
  });
}
