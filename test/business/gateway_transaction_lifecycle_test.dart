import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/capture_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/fail_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/refund_gateway_transaction.dart';
import 'package:growth_pilot_ai/business/settle_gateway_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

BankingGatewayTransactionEntity _transaction() {
  return BankingGatewayTransactionEntity(
    id: 5,
    dbProvider: 0,
    merchantName: 'Merchant',
    counterpartyName: 'Supplier',
    amount: 100,
    currency: 'USD',
    convertedAmount: 135,
    exchangeRate: 1.35,
    feeAmount: 4.2,
    initiatedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('capturing marks the transaction captured', () {
    final updated = CaptureGatewayTransaction.call(_transaction());
    expect(updated.status, GatewayTransactionStatus.captured);
    expect(updated.id, 5);
  });

  test('settling marks the transaction settled and stamps settledAt', () {
    final updated = SettleGatewayTransaction.call(_transaction(), DateTime(2026, 1, 5));
    expect(updated.status, GatewayTransactionStatus.settled);
    expect(updated.settledAt, DateTime(2026, 1, 5));
  });

  test('failing marks the transaction failed', () {
    final updated = FailGatewayTransaction.call(_transaction());
    expect(updated.status, GatewayTransactionStatus.failed);
  });

  test('refunding marks the transaction refunded', () {
    final updated = RefundGatewayTransaction.call(_transaction());
    expect(updated.status, GatewayTransactionStatus.refunded);
  });
}
