import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_merchant_dependency_score.dart';

void main() {
  test('scores zero when no signal is present', () {
    final score = ComputeMerchantDependencyScore.call(
      orderVolume: 0,
      dailyVisitAverage: 0,
      trialCompleted: false,
      inventoryLiquidationPercent: 0,
    );
    expect(score, 0);
  });

  test('scores 100 when every signal maxes out', () {
    final score = ComputeMerchantDependencyScore.call(
      orderVolume: 40,
      dailyVisitAverage: 10,
      trialCompleted: true,
      inventoryLiquidationPercent: 50,
    );
    expect(score, 100);
  });

  test('awards partial credit proportionally below the caps', () {
    final score = ComputeMerchantDependencyScore.call(
      orderVolume: 10,
      dailyVisitAverage: 2.5,
      trialCompleted: false,
      inventoryLiquidationPercent: 0,
    );
    expect(score, 25);
  });

  test('liquidation and trial are all-or-nothing milestones', () {
    final belowThreshold = ComputeMerchantDependencyScore.call(
      orderVolume: 0,
      dailyVisitAverage: 0,
      trialCompleted: false,
      inventoryLiquidationPercent: 29.9,
    );
    final atThreshold = ComputeMerchantDependencyScore.call(
      orderVolume: 0,
      dailyVisitAverage: 0,
      trialCompleted: false,
      inventoryLiquidationPercent: 30,
    );
    expect(belowThreshold, 0);
    expect(atThreshold, 25);
  });
}
