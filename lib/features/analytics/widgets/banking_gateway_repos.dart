import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/banking_gateway_transaction_repository.dart';

/// Bundles the repositories the banking gateway orchestration
/// simulation needs (Issue #421) — split out of the actions classes.
class BankingGatewayRepos {
  final store = Get.find<ObjectBox>().store;

  late final transactions =
      BankingGatewayTransactionRepository(store.box<BankingGatewayTransactionEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
