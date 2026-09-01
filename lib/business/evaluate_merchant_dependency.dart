import 'package:growth_pilot_ai/business/classify_merchant_dependency_tier.dart';
import 'package:growth_pilot_ai/business/compute_daily_visit_frequency.dart';
import 'package:growth_pilot_ai/business/compute_merchant_dependency_score.dart';
import 'package:growth_pilot_ai/business/compute_order_placement_volume.dart';
import 'package:growth_pilot_ai/business/is_trial_period_completed.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_activity_event_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_input_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/merchant_dependency_tier.dart';

/// Runs the full dependency-detection engine for one merchant (Issue
/// #424, acceptance criteria 1-4) — aggregates the four telemetry
/// signals, scores and classifies the account, and flags whether this
/// run crossed into a higher tier than [previousTier] so the caller
/// can trigger the automated billing-tier transition and audit log.
class EvaluateMerchantDependency {
  static MerchantDependencyEvaluationEntity call({
    required String merchantName,
    required List<WholesaleOrderEntity> orders,
    required List<MerchantActivityEventEntity> activityEvents,
    required MerchantDependencyInputEntity input,
    MerchantDependencyTier? previousTier,
    required DateTime now,
  }) {
    final orderVolume = ComputeOrderPlacementVolume.call(merchantName, orders, now);
    final dailyVisitAverage = ComputeDailyVisitFrequency.call(merchantName, activityEvents, now);
    final trialCompleted = IsTrialPeriodCompleted.call(input.trialStartedAt, now);
    final score = ComputeMerchantDependencyScore.call(
      orderVolume: orderVolume,
      dailyVisitAverage: dailyVisitAverage,
      trialCompleted: trialCompleted,
      inventoryLiquidationPercent: input.inventoryLiquidationPercent,
    );
    final tier = ClassifyMerchantDependencyTier.call(score);
    final triggeredUpgrade = previousTier != null && tier.index > previousTier.index;

    final evaluation = MerchantDependencyEvaluationEntity(
      merchantName: merchantName,
      orderVolume: orderVolume,
      dailyVisitAverage: dailyVisitAverage,
      trialCompleted: trialCompleted,
      inventoryLiquidationPercent: input.inventoryLiquidationPercent,
      dependencyScore: score,
      triggeredTierUpgrade: triggeredUpgrade,
      evaluatedAt: now,
    );
    evaluation.tier = tier;
    return evaluation;
  }
}
