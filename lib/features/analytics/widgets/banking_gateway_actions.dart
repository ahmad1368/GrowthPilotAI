import 'package:growth_pilot_ai/business/authorize_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/capture_gateway_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_repos.dart';

/// Authorization and capture (Issue #421, acceptance criteria 1-2) —
/// split out of [BankingGatewayBody].
class BankingGatewayActions {
  final BankingGatewayRepos repos;

  BankingGatewayActions(this.repos);

  BankingGatewayTransactionEntity authorize(BankingGatewayProvider provider, String merchantName,
      String counterpartyName, double amount, String currency) {
    final transaction = AuthorizeGatewayTransaction.call(
      provider: provider,
      merchantName: merchantName,
      counterpartyName: counterpartyName,
      amount: amount,
      currency: currency,
      now: DateTime.now(),
    );
    repos.transactions.save(transaction);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'authorized gateway transaction',
      targetMerchant: merchantName,
      newValue: '${provider.name}: $currency ${amount.toStringAsFixed(2)} to $counterpartyName',
    ));
    return transaction;
  }

  BankingGatewayTransactionEntity capture(BankingGatewayTransactionEntity transaction) {
    final updated = CaptureGatewayTransaction.call(transaction);
    repos.transactions.save(updated);
    return updated;
  }
}
