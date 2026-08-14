import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_wallet_balance_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

BankingGatewayTransactionEntity _transaction(
    BankingGatewayProvider provider, double convertedAmount, GatewayTransactionStatus status) {
  return BankingGatewayTransactionEntity(
    dbProvider: provider.index,
    merchantName: 'Merchant',
    counterpartyName: 'Supplier',
    amount: convertedAmount,
    currency: 'USDT',
    convertedAmount: convertedAmount,
    exchangeRate: 1.35,
    feeAmount: 0.5,
    dbStatus: status.index,
    initiatedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('sums settled amounts per crypto provider, ignoring non-settled and non-crypto', () {
    final transactions = [
      _transaction(BankingGatewayProvider.usdt, 100, GatewayTransactionStatus.settled),
      _transaction(BankingGatewayProvider.usdt, 50, GatewayTransactionStatus.settled),
      _transaction(BankingGatewayProvider.usdt, 200, GatewayTransactionStatus.captured),
      _transaction(BankingGatewayProvider.bitcoin, 500, GatewayTransactionStatus.settled),
      _transaction(BankingGatewayProvider.stripe, 999, GatewayTransactionStatus.settled),
    ];

    final balances = BuildWalletBalanceSummary.call(transactions);

    expect(balances[BankingGatewayProvider.usdt], closeTo(150.0, 0.001));
    expect(balances[BankingGatewayProvider.bitcoin], closeTo(500.0, 0.001));
    expect(balances.containsKey(BankingGatewayProvider.stripe), false);
  });

  test('no transactions produce an empty summary', () {
    expect(BuildWalletBalanceSummary.call([]), isEmpty);
  });
}
