import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/authorize_gateway_transaction.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

void main() {
  test('authorizing builds a transaction with converted amount and fee applied', () {
    final transaction = AuthorizeGatewayTransaction.call(
      provider: BankingGatewayProvider.stripe,
      merchantName: 'Merchant',
      counterpartyName: 'Supplier',
      amount: 100,
      currency: 'usd',
      now: DateTime(2026, 1, 1),
    );

    expect(transaction.status, GatewayTransactionStatus.authorized);
    expect(transaction.currency, 'USD');
    expect(transaction.convertedAmount, closeTo(135.0, 0.001));
    expect(transaction.feeAmount, closeTo(135.0 * 0.029 + 0.30, 0.001));
    expect(transaction.settledAt, isNull);
    expect(transaction.transactionHash, '');
  });

  test('authorizing a crypto transaction stamps a simulated transaction hash (Issue #423)', () {
    final transaction = AuthorizeGatewayTransaction.call(
      provider: BankingGatewayProvider.usdt,
      merchantName: 'Merchant',
      counterpartyName: 'Supplier',
      amount: 100,
      currency: 'usdt',
      now: DateTime(2026, 1, 1),
    );

    expect(transaction.transactionHash, isNotEmpty);
    expect(transaction.transactionHash.startsWith('0x'), true);
  });
}
