import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/banking_gateway_transaction_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/escrow_account_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';

/// Bundles the repositories the banking gateway orchestration
/// simulation needs (Issue #421) — reuses [EscrowAccountRepository]
/// (#415) as the crypto "smart contract escrow" backing for Issue
/// #423, acceptance criterion 2, and [InboxNotificationRepository]
/// (#71) as the settlement-alert sink for Issue #426, acceptance
/// criterion 3.
class BankingGatewayRepos {
  final store = Get.find<ObjectBox>().store;

  late final transactions =
      BankingGatewayTransactionRepository(store.box<BankingGatewayTransactionEntity>());
  late final escrowAccounts = EscrowAccountRepository(store.box<EscrowAccountEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
  late final notifications = InboxNotificationRepository(store.box<InboxNotificationEntity>());
}
