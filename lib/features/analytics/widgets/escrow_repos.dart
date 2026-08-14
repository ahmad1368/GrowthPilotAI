import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/dispute_evidence_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/escrow_account_repository.dart';

/// Bundles the repositories the smart escrow engine needs (Issue
/// #415) — split out of the actions classes. [DisputeEvidenceRepository]
/// backs the dispute dossier from Issue #427.
class EscrowRepos {
  final store = Get.find<ObjectBox>().store;

  late final accounts = EscrowAccountRepository(store.box<EscrowAccountEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
  late final evidence = DisputeEvidenceRepository(store.box<DisputeEvidenceEntity>());
}
