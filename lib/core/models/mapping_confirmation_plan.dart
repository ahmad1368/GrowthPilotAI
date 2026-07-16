import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_mapping_status_entity.dart';

/// What to persist when the user confirms a [MerchantMappingGroup] mapping
/// (Issue #58): one confirmed status per transaction, plus an optional new
/// auto-map rule if "Always map..." was toggled on.
@immutable
class MappingConfirmationPlan {
  final List<TransactionMappingStatusEntity> statuses;
  final MappingRuleEntity? newRule;

  const MappingConfirmationPlan({required this.statuses, this.newRule});
}
