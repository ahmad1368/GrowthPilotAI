import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_contribution_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/group_purchase_contribution_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/group_purchase_repository.dart';

/// Bundles the repositories the group-buying coordinator needs
/// (Issue #414) — split out of the actions classes.
class GroupPurchaseRepos {
  final store = Get.find<ObjectBox>().store;

  late final purchases = GroupPurchaseRepository(store.box<GroupPurchaseEntity>());
  late final contributions =
      GroupPurchaseContributionRepository(store.box<GroupPurchaseContributionEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
