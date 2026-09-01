import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_repos.dart';

/// Snapshot of everything [SettlementTrackingView] needs to render
/// (Issue #426), plus the lookups joining a transaction to its
/// matching escrow (#415, via the `gateway-tx-{id}` convention #421
/// already established) and admin history (#343).
class SettlementTrackingViewState {
  final List<BankingGatewayTransactionEntity> transactions;
  final List<EscrowAccountEntity> escrowAccounts;
  final List<AuditLogEntity> auditLogs;

  const SettlementTrackingViewState({
    required this.transactions,
    required this.escrowAccounts,
    required this.auditLogs,
  });

  factory SettlementTrackingViewState.load(SettlementTrackingRepos repos) {
    return SettlementTrackingViewState(
      transactions: repos.transactions.getAll(),
      escrowAccounts: repos.escrowAccounts.getAll(),
      auditLogs: repos.auditLogs.getAll(),
    );
  }

  EscrowAccountEntity? escrowFor(BankingGatewayTransactionEntity tx) =>
      escrowAccounts.where((e) => e.itemDescription == 'gateway-tx-${tx.id}').firstOrNull;

  List<AuditLogEntity> historyFor(BankingGatewayTransactionEntity tx) =>
      auditLogs.where((l) => l.targetMerchant == tx.merchantName).toList();
}
