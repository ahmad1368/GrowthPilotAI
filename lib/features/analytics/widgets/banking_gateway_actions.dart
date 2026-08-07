import 'package:growth_pilot_ai/business/authorize_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/capture_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/open_escrow_account.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_repos.dart';

/// Authorization and capture (Issue #421, acceptance criteria 1-2) —
/// capturing a crypto/stablecoin transaction also locks a real
/// [EscrowAccountEntity] (#415) as its "smart contract escrow" (Issue
/// #423, acceptance criterion 2), matched later by
/// [BankingGatewaySettlementActions.settle] via the `gateway-tx-{id}`
/// item description rather than a new FK column. Split out of
/// [BankingGatewayBody].
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
    if (transaction.provider.isCrypto) {
      repos.escrowAccounts.save(OpenEscrowAccount.call(
        buyerName: transaction.merchantName,
        sellerName: transaction.counterpartyName,
        itemDescription: 'gateway-tx-${transaction.id}',
        amount: transaction.convertedAmount,
        now: DateTime.now(),
      ));
      repos.auditLogs.record(BuildAuditLogEntry.call(
        changeType: 'locked smart contract escrow',
        targetMerchant: transaction.merchantName,
        newValue: '${transaction.provider.name} tx #${transaction.id} locked pending delivery',
      ));
    }
    return updated;
  }
}
