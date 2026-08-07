import 'package:growth_pilot_ai/business/authorize_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/route_gateway_fallback.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_repos.dart';

/// Fallback-retry handling (Issue #422, acceptance criteria 3-4) —
/// split out of [BankingGatewaySettlementActions] to stay under the
/// file line cap.
class BankingGatewayFallbackActions {
  final BankingGatewayRepos repos;

  BankingGatewayFallbackActions(this.repos);

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
}
