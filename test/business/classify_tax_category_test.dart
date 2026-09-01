import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_tax_category.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/tax_category.dart';

BankingGatewayTransactionEntity _tx({required int provider, required String currency}) {
  return BankingGatewayTransactionEntity(
    dbProvider: provider,
    merchantName: 'Alpha',
    counterpartyName: 'Beta',
    amount: 100,
    currency: currency,
    convertedAmount: 100,
    exchangeRate: 1,
    feeAmount: 0,
    initiatedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('classifies crypto-rail transactions as capital gains', () {
    final tx = _tx(provider: 7, currency: 'CAD'); // BankingGatewayProvider.usdt
    expect(ClassifyTaxCategory.call(tx), TaxCategory.capitalGain);
  });

  test('classifies cross-currency fiat as foreign exchange gain/loss', () {
    final tx = _tx(provider: 0, currency: 'USD'); // stripe
    expect(ClassifyTaxCategory.call(tx), TaxCategory.foreignExchangeGainLoss);
  });

  test('classifies same-currency fiat as business income', () {
    final tx = _tx(provider: 0, currency: 'CAD');
    expect(ClassifyTaxCategory.call(tx), TaxCategory.businessIncome);
  });
}
