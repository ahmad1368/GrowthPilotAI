import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/evaluate_merchant_dependency.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_input_entity.dart';
import 'package:growth_pilot_ai/core/enum/merchant_dependency_tier.dart';

void main() {
  final now = DateTime(2026, 6, 1);

  test('flags a tier upgrade when the new tier outranks the previous one', () {
    final input = MerchantDependencyInputEntity(
      merchantName: 'Alpha',
      trialStartedAt: now.subtract(const Duration(days: 200)),
      inventoryLiquidationPercent: 40,
      updatedAt: now,
    );
    final evaluation = EvaluateMerchantDependency.call(
      merchantName: 'Alpha',
      orders: const [],
      activityEvents: const [],
      input: input,
      previousTier: MerchantDependencyTier.standard,
      now: now,
    );
    expect(evaluation.tier, MerchantDependencyTier.engaged);
    expect(evaluation.triggeredTierUpgrade, true);
  });

  test('does not flag an upgrade when there is no prior evaluation', () {
    final input = MerchantDependencyInputEntity(
      merchantName: 'Alpha',
      trialStartedAt: now,
      updatedAt: now,
    );
    final evaluation = EvaluateMerchantDependency.call(
      merchantName: 'Alpha',
      orders: const [],
      activityEvents: const [],
      input: input,
      previousTier: null,
      now: now,
    );
    expect(evaluation.triggeredTierUpgrade, false);
  });

  test('does not flag an upgrade when the tier stays the same or drops', () {
    final input = MerchantDependencyInputEntity(
      merchantName: 'Alpha',
      trialStartedAt: now,
      updatedAt: now,
    );
    final evaluation = EvaluateMerchantDependency.call(
      merchantName: 'Alpha',
      orders: const [],
      activityEvents: const [],
      input: input,
      previousTier: MerchantDependencyTier.highDependency,
      now: now,
    );
    expect(evaluation.triggeredTierUpgrade, false);
  });
}
