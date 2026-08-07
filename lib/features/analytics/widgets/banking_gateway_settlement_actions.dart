import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/fail_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/refund_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/settle_gateway_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_repos.dart';

/// Settlement, failure, and refund handling (Issue #421, acceptance
/// criteria 3 and 5) — split out of [BankingGatewayBody].
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
    return updated;
  }

  BankingGatewayTransactionEntity fail(BankingGatewayTransactionEntity transaction) {
    final updated = FailGatewayTransaction.call(transaction);
    repos.transactions.save(updated);
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
    return updated;
  }
}
