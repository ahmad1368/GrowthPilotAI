import 'package:growth_pilot_ai/business/authorize_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/fail_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/refund_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/route_gateway_fallback.dart';
import 'package:growth_pilot_ai/business/settle_gateway_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_repos.dart';

/// Settlement, failure, refund, and fallback-retry handling (Issue
/// #421, acceptance criteria 3 and 5; retry added for Issue #422,
/// acceptance criteria 3-4) — split out of [BankingGatewayBody].
class BankingGatewaySettlementActions {
  final BankingGatewayRepos repos;

  BankingGatewaySettlementActions(this.repos);

  BankingGatewayTransactionEntity retryWithFallback(BankingGatewayTransactionEntity failed) {
    final fallbackProvider = RouteGatewayFallback.call(failed.provider);
    final retry = AuthorizeGatewayTransaction.call(
      provider: fallbackProvider,
      merchantName: failed.merchantName,
      counterpartyName: failed.counterpartyName,
      amount: failed.amount,
      currency: failed.currency,
      now: DateTime.now(),
    );
    repos.transactions.save(retry);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'routed gateway fallback',
      targetMerchant: failed.merchantName,
      previousValue: failed.provider.name,
      newValue: '${fallbackProvider.name} (retry after failure)',
    ));
    return retry;
  }

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
