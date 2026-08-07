import 'package:growth_pilot_ai/business/compute_exchange_conversion.dart';
import 'package:growth_pilot_ai/business/compute_gateway_fee.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Builds a new authorized transaction against the local payment-
/// orchestration simulation (Issue #421, acceptance criteria 1-2) —
/// pure construction, the caller persists it.
class AuthorizeGatewayTransaction {
  static BankingGatewayTransactionEntity call({
    required BankingGatewayProvider provider,
    required String merchantName,
    required String counterpartyName,
    required double amount,
    required String currency,
    required DateTime now,
  }) {
    final conversion = ComputeExchangeConversion.call(amount, currency);
    return BankingGatewayTransactionEntity(
      dbProvider: provider.index,
      merchantName: merchantName,
      counterpartyName: counterpartyName,
      amount: amount,
      currency: currency.toUpperCase(),
      convertedAmount: conversion.convertedAmount,
      exchangeRate: conversion.exchangeRate,
      feeAmount: ComputeGatewayFee.call(provider, conversion.convertedAmount),
      initiatedAt: now,
    );
  }
}
