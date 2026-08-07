import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tier_override_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/commission_tier_record_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_dependency_evaluation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_tier_override_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/wholesale_order_repository.dart';

/// Bundles the repositories the tiered commission engine needs (Issue
/// #425) — reuses [WholesaleOrderRepository] (#411) as the settlement
/// source and [MerchantDependencyEvaluationRepository] (#424) as the
/// verification gate, mirroring [FeeWaiverRepos]'s cross-feature
/// reuse pattern.
class TieredCommissionRepos {
  final store = Get.find<ObjectBox>().store;

  late final orders = WholesaleOrderRepository(store.box<WholesaleOrderEntity>());
  late final dependencyEvaluations =
      MerchantDependencyEvaluationRepository(store.box<MerchantDependencyEvaluationEntity>());
  late final records = CommissionTierRecordRepository(store.box<CommissionTierRecordEntity>());
  late final overrides = MerchantTierOverrideRepository(store.box<MerchantTierOverrideEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
