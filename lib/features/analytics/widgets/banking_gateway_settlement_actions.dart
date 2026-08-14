import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/build_settlement_notification.dart';
import 'package:growth_pilot_ai/business/confirm_escrow_delivery.dart';
import 'package:growth_pilot_ai/business/fail_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/refund_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/settle_gateway_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_repos.dart';

/// Settlement, failure, and refund handling (Issue #421, acceptance
/// criteria 3 and 5) — settling a crypto/stablecoin transaction also
/// releases its matching held [EscrowAccountEntity] (#415), the
/// "smart contract" release for Issue #423, acceptance criterion 2.
/// Every terminal transition also fires an Inbox alert (Issue #426,
/// acceptance criterion 3).
class BankingGatewaySettlementActions {
  final BankingGatewayRepos repos;

  BankingGatewaySettlementActions(this.repos);

  BankingGatewayTransactionEntity settle(BankingGatewayTransactionEntity transaction) {
    final updated = SettleGatewayTransaction.call(transaction, DateTime.now());
    repos.transactions.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'settled gateway transaction',
      targetMerchant: transaction.merchantName,
      previousValue: 'captured',
      newValue: 'settled',
    ));
    if (transaction.provider.isCrypto) _releaseEscrow(transaction);
    repos.notifications.upsert(BuildSettlementNotification.call(updated, DateTime.now()));
    return updated;
  }

  void _releaseEscrow(BankingGatewayTransactionEntity transaction) {
    final held = repos.escrowAccounts
        .getAll()
        .where((e) =>
            e.itemDescription == 'gateway-tx-${transaction.id}' && e.status == EscrowStatus.held)
        .firstOrNull;
    if (held == null) return;
    repos.escrowAccounts.save(ConfirmEscrowDelivery.call(held));
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'released smart contract escrow',
      targetMerchant: transaction.merchantName,
      newValue: '${transaction.provider.name} tx #${transaction.id} released to seller',
    ));
  }

  BankingGatewayTransactionEntity fail(BankingGatewayTransactionEntity transaction) {
    final updated = FailGatewayTransaction.call(transaction);
    repos.transactions.save(updated);
    repos.notifications.upsert(BuildSettlementNotification.call(updated, DateTime.now()));
    return updated;
  }

  BankingGatewayTransactionEntity refund(BankingGatewayTransactionEntity transaction) {
    final updated = RefundGatewayTransaction.call(transaction);
    repos.transactions.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'refunded gateway transaction',
      targetMerchant: transaction.merchantName,
      newValue: '${transaction.currency} ${transaction.amount.toStringAsFixed(2)} refunded',
    ));
    repos.notifications.upsert(BuildSettlementNotification.call(updated, DateTime.now()));
    return updated;
  }
}
