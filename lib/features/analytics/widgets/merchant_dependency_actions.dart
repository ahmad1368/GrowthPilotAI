import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/derive_trial_start_date.dart';
import 'package:growth_pilot_ai/business/evaluate_merchant_dependency.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_activity_event_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/core/enum/merchant_activity_event_type.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_repos.dart';

/// Telemetry logging, scoring, and audit logging for the merchant
/// dependency engine (Issue #424, acceptance criteria 1, 4 and 5) —
/// split out of [MerchantDependencyBody].
class MerchantDependencyActions {
  final MerchantDependencyRepos repos;

  MerchantDependencyActions(this.repos);

  void logVisit(String merchantName) {
    repos.activityEvents.record(MerchantActivityEventEntity(
      merchantName: merchantName,
      occurredAt: DateTime.now(),
    )..dbEventType = MerchantActivityEventType.dashboardVisit.index);
  }

  void setLiquidationPercent(String merchantName, double percent) {
    final orders = repos.orders.getAll();
    final input = repos.inputs.getOrCreate(
      merchantName,
      DeriveTrialStartDate.call(merchantName, orders, DateTime.now()),
    );
    input.inventoryLiquidationPercent = percent;
    input.updatedAt = DateTime.now();
    repos.inputs.save(input);
  }

  MerchantDependencyEvaluationEntity evaluate(String merchantName) {
    final now = DateTime.now();
    final orders = repos.orders.getAll();
    final input = repos.inputs.getOrCreate(
      merchantName,
      DeriveTrialStartDate.call(merchantName, orders, now),
    );
    final previous = repos.evaluations.latestForMerchant(merchantName);

    final evaluation = EvaluateMerchantDependency.call(
      merchantName: merchantName,
      orders: orders,
      activityEvents: repos.activityEvents.forMerchant(merchantName),
      input: input,
      previousTier: previous?.tier,
      now: now,
    );
    repos.evaluations.save(evaluation);

    if (evaluation.triggeredTierUpgrade) {
      repos.auditLogs.record(BuildAuditLogEntry.call(
        changeType: 'merchant dependency tier upgrade',
        targetMerchant: merchantName,
        previousValue: (previous?.tier ?? evaluation.tier).name,
        newValue: '${evaluation.tier.name} (score ${evaluation.dependencyScore})',
      ));
    }
    return evaluation;
  }
}
