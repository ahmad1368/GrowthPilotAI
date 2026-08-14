import 'package:growth_pilot_ai/core/data/repositories/integration_connection_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/mapping_rule_repository.dart';
import 'package:growth_pilot_ai/core/models/disconnect_integration_plan.dart';

/// Executes a [DisconnectIntegrationPlan] against ObjectBox (Issue #61):
/// persists the reset connection row, plus clears auto-map rules when the
/// plan calls for it.
class DisconnectIntegrationExecutor {
  final IntegrationConnectionRepository connectionRepo;
  final MappingRuleRepository ruleRepo;

  DisconnectIntegrationExecutor(this.connectionRepo, this.ruleRepo);

  void execute(DisconnectIntegrationPlan plan) {
    connectionRepo.upsert(plan.updatedEntity);
    if (plan.clearsMappingRules) ruleRepo.removeAll();
  }
}
