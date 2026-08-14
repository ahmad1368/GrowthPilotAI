import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_activity_event_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_input_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_activity_event_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_dependency_evaluation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_dependency_input_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/wholesale_order_repository.dart';

/// Bundles the repositories the dependency-detection engine needs
/// (Issue #424) — reuses [WholesaleOrderRepository] (#411) as the
/// order-volume source, mirroring [FeeWaiverRepos]'s cross-feature
/// reuse pattern.
class MerchantDependencyRepos {
  final store = Get.find<ObjectBox>().store;

  late final orders = WholesaleOrderRepository(store.box<WholesaleOrderEntity>());
  late final activityEvents =
      MerchantActivityEventRepository(store.box<MerchantActivityEventEntity>());
  late final inputs = MerchantDependencyInputRepository(store.box<MerchantDependencyInputEntity>());
  late final evaluations =
      MerchantDependencyEvaluationRepository(store.box<MerchantDependencyEvaluationEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
