import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_cra_log_checksum.dart';
import 'package:growth_pilot_ai/business/verify_cra_log_integrity.dart';
import 'package:growth_pilot_ai/core/data/entities/cra_transaction_log_entity.dart';

CraTransactionLogEntity _entry() {
  final loggedAt = DateTime(2026, 1, 1);
  final checksum = ComputeCraLogChecksum.call(
    counterpartyNameEncrypted: 'cipher-a',
    amount: 100,
    currency: 'CAD',
    exchangeRateAtSettlement: 1,
    transactionHash: 'hash-1',
    loggedAt: loggedAt,
  );
  return CraTransactionLogEntity(
    gatewayTransactionId: 1,
    counterpartyNameEncrypted: 'cipher-a',
    amount: 100,
    currency: 'CAD',
    exchangeRateAtSettlement: 1,
    feeAmount: 0,
    transactionHash: 'hash-1',
    checksum: checksum,
    loggedAt: loggedAt,
  );
}

void main() {
  test('validates an untampered entry', () {
    expect(VerifyCraLogIntegrity.call(_entry()), true);
  });

  test('flags an entry whose stored amount was altered after logging', () {
    final tampered = _entry()..amount = 999;
    expect(VerifyCraLogIntegrity.call(tampered), false);
  });
}
