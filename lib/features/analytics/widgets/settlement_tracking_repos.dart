import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/banking_gateway_transaction_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/escrow_account_repository.dart';

/// Bundles the repositories the settlement tracking dashboard needs
/// (Issue #426) — purely a read layer over the existing banking
/// gateway (#421-423) and escrow (#415) data, mirroring
/// [BankingGatewayRepos]'s reuse pattern.
class SettlementTrackingRepos {
  final store = Get.find<ObjectBox>().store;

  late final transactions =
      BankingGatewayTransactionRepository(store.box<BankingGatewayTransactionEntity>());
  late final escrowAccounts = EscrowAccountRepository(store.box<EscrowAccountEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
