import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_transaction_hash.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

void main() {
  test('non-crypto providers get no transaction hash', () {
    final hash = GenerateTransactionHash.call(
        BankingGatewayProvider.stripe, 'Merchant', 'Supplier', 100, DateTime(2026, 1, 1));
    expect(hash, '');
  });

  test('crypto providers get a 0x-prefixed 40-hex-char hash', () {
    final hash = GenerateTransactionHash.call(
        BankingGatewayProvider.usdt, 'Merchant', 'Supplier', 100, DateTime(2026, 1, 1));
    expect(hash.startsWith('0x'), true);
    expect(hash.length, 42);
    expect(RegExp(r'^0x[0-9a-f]{40}$').hasMatch(hash), true);
  });

  test('different inputs produce different hashes', () {
    final hashA = GenerateTransactionHash.call(
        BankingGatewayProvider.usdt, 'Merchant', 'Supplier', 100, DateTime(2026, 1, 1, 0, 0, 0, 0, 1));
    final hashB = GenerateTransactionHash.call(
        BankingGatewayProvider.usdt, 'Merchant', 'Supplier', 100, DateTime(2026, 1, 1, 0, 0, 0, 0, 2));
    expect(hashA, isNot(equals(hashB)));
  });
}
