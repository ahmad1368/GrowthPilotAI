import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_cra_log_checksum.dart';

void main() {
  final loggedAt = DateTime(2026, 1, 1);

  test('is deterministic for identical inputs', () {
    final a = ComputeCraLogChecksum.call(
      counterpartyNameEncrypted: 'cipher-a',
      amount: 100,
      currency: 'CAD',
      exchangeRateAtSettlement: 1,
      transactionHash: 'hash-1',
      loggedAt: loggedAt,
    );
    final b = ComputeCraLogChecksum.call(
      counterpartyNameEncrypted: 'cipher-a',
      amount: 100,
      currency: 'CAD',
      exchangeRateAtSettlement: 1,
      transactionHash: 'hash-1',
      loggedAt: loggedAt,
    );
    expect(a, b);
  });

  test('changes when any field changes', () {
    final base = ComputeCraLogChecksum.call(
      counterpartyNameEncrypted: 'cipher-a',
      amount: 100,
      currency: 'CAD',
      exchangeRateAtSettlement: 1,
      transactionHash: 'hash-1',
      loggedAt: loggedAt,
    );
    final tamperedAmount = ComputeCraLogChecksum.call(
      counterpartyNameEncrypted: 'cipher-a',
      amount: 999,
      currency: 'CAD',
      exchangeRateAtSettlement: 1,
      transactionHash: 'hash-1',
      loggedAt: loggedAt,
    );
    expect(base, isNot(tamperedAmount));
  });
}
