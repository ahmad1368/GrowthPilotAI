import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_merchant_dependency_verified.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';

MerchantDependencyEvaluationEntity _evaluation(String merchant) {
  return MerchantDependencyEvaluationEntity(
    merchantName: merchant,
    orderVolume: 0,
    dailyVisitAverage: 0,
    trialCompleted: false,
    inventoryLiquidationPercent: 0,
    dependencyScore: 0,
    evaluatedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('verified once at least one evaluation exists for the merchant', () {
    expect(IsMerchantDependencyVerified.call('Alpha', [_evaluation('Alpha')]), true);
  });

  test('not verified when no evaluation exists for the merchant', () {
    expect(IsMerchantDependencyVerified.call('Beta', [_evaluation('Alpha')]), false);
    expect(IsMerchantDependencyVerified.call('Beta', []), false);
  });
}
