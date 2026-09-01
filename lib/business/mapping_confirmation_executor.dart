import 'package:growth_pilot_ai/core/data/repositories/mapping_rule_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_mapping_status_repository.dart';
import 'package:growth_pilot_ai/core/models/mapping_confirmation_plan.dart';

/// Executes a [MappingConfirmationPlan] against ObjectBox (Issue #58):
/// writes every confirmed transaction status, plus the new auto-map rule
/// when the user opted in via "Always map...".
class MappingConfirmationExecutor {
  final MappingRuleRepository ruleRepo;
  final TransactionMappingStatusRepository statusRepo;

  MappingConfirmationExecutor(this.ruleRepo, this.statusRepo);

  void execute(MappingConfirmationPlan plan) {
    for (final status in plan.statuses) {
      statusRepo.confirm(status);
    }
    if (plan.newRule != null) ruleRepo.add(plan.newRule!);
  }
}
