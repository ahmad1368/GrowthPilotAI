import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

/// Marks a captured transaction settled (Issue #421, acceptance
/// criteria 3 and 5) — this app has no backend to receive a real
/// gateway webhook, so "the webhook landed" is this manual
/// confirmation, the same simplification [ConfirmEscrowDelivery]
/// (#415) uses for its own settlement step.
class SettleGatewayTransaction {
  static BankingGatewayTransactionEntity call(
      BankingGatewayTransactionEntity transaction, DateTime now) {
    return BankingGatewayTransactionEntity(
      id: transaction.id,
      dbProvider: transaction.dbProvider,
      merchantName: transaction.merchantName,
      counterpartyName: transaction.counterpartyName,
      amount: transaction.amount,
      currency: transaction.currency,
      convertedAmount: transaction.convertedAmount,
      exchangeRate: transaction.exchangeRate,
      feeAmount: transaction.feeAmount,
      dbStatus: GatewayTransactionStatus.settled.index,
      initiatedAt: transaction.initiatedAt,
      settledAt: now,
    );
  }
}
