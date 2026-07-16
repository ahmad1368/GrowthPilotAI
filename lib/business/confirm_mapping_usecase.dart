import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_mapping_status_entity.dart';
import 'package:growth_pilot_ai/core/models/mapping_confirmation_plan.dart';
import 'package:growth_pilot_ai/core/models/merchant_mapping_group.dart';

/// Pure decision logic for confirming a mapping (Issue #58): builds the plan
/// of entities to persist without touching ObjectBox directly, so it stays
/// unit-testable. The controller executes the plan via the repositories.
class ConfirmMappingUseCase {
  static MappingConfirmationPlan call({
    required MerchantMappingGroup group,
    required String selectedAccountId,
    required String selectedAccountName,
    required bool createRule,
  }) {
    final now = DateTime.now();
    final statuses = group.transactions
        .map((t) => TransactionMappingStatusEntity(
              transactionId: t.id,
              confirmedAccountId: selectedAccountId,
              confirmedAccountName: selectedAccountName,
              confirmedAt: now,
            ))
        .toList();

    final rule = createRule
        ? MappingRuleEntity(
            merchantPattern: group.merchantName,
            targetAccountId: selectedAccountId,
            targetAccountName: selectedAccountName,
          )
        : null;

    return MappingConfirmationPlan(statuses: statuses, newRule: rule);
  }
}
