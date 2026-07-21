import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_business_compass_metrics.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';

TransactionEntity _tx({
  required double amount,
  required TransactionType type,
  required DateTime date,
  SyncStatus syncStatus = SyncStatus.synced,
  int? vendorId,
}) {
  final tx = TransactionEntity(
    amount: amount,
    date: date,
    description: 'x',
    dbType: type.index,
    dbSyncStatus: syncStatus.index,
  );
  if (vendorId != null) {
    tx.vendor.target = VendorEntity(id: vendorId, name: 'v$vendorId');
  }
  return tx;
}

void main() {
  final now = DateTime(2026, 1, 30);

  test('returns a neutral zeroed vector for an empty transaction list', () {
    final metrics = ComputeBusinessCompassMetrics.call(const []);

    expect(metrics.liquidityRatio, 0);
    expect(metrics.burnVelocity, 0.5);
    expect(metrics.profitMargin, 0);
  });

  test('liquidityRatio and profitMargin reflect income vs. expense', () {
    final metrics = ComputeBusinessCompassMetrics.call([
      _tx(amount: 1000, type: TransactionType.income, date: now),
      _tx(amount: 500, type: TransactionType.expense, date: now),
    ]);

    expect(metrics.liquidityRatio, 1.0); // ratio 2.0 -> clamped to 1.0
    expect(metrics.profitMargin, 0.5); // (1000-500)/1000
  });

  test('vendorDiversity is the fraction of distinct vendors', () {
    final metrics = ComputeBusinessCompassMetrics.call([
      _tx(amount: 10, type: TransactionType.expense, date: now, vendorId: 1),
      _tx(amount: 10, type: TransactionType.expense, date: now, vendorId: 1),
      _tx(amount: 10, type: TransactionType.expense, date: now, vendorId: 2),
    ]);

    expect(metrics.vendorDiversity, closeTo(2 / 3, 0.001));
  });

  test('paymentPunctuality is the fraction of already-synced transactions', () {
    final metrics = ComputeBusinessCompassMetrics.call([
      _tx(amount: 10, type: TransactionType.expense, date: now),
      _tx(amount: 10, type: TransactionType.expense, date: now, syncStatus: SyncStatus.pending),
    ]);

    expect(metrics.paymentPunctuality, 0.5);
  });
}
