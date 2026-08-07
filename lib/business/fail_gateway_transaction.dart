import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

/// Marks a transaction failed (Issue #421, acceptance criterion 3) —
/// the failure counterpart to [SettleGatewayTransaction] for a
/// simulated settlement/failure webhook event.
class FailGatewayTransaction {
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
      dbStatus: GatewayTransactionStatus.failed.index,
      transactionHash: transaction.transactionHash,
      initiatedAt: transaction.initiatedAt,
    );
  }
}
