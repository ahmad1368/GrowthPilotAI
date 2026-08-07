import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

/// Refunds a settled transaction (Issue #421, acceptance criterion 1)
/// — the standard capture/refund pair every major gateway exposes.
class RefundGatewayTransaction {
  static BankingGatewayTransactionEntity call(BankingGatewayTransactionEntity transaction) {
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
      dbStatus: GatewayTransactionStatus.refunded.index,
      transactionHash: transaction.transactionHash,
      initiatedAt: transaction.initiatedAt,
      settledAt: transaction.settledAt,
    );
  }
}
