import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_supplier_scorecards.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/core/enum/spending_trend.dart';

TransactionEntity _tx(double amount, DateTime date, {VendorEntity? vendor}) {
  final tx = TransactionEntity(amount: amount, date: date, description: 'x', dbType: 0);
  if (vendor != null) tx.vendor.target = vendor;
  return tx;
}

void main() {
  test('ranks vendors by average price per transaction, cheapest first', () {
    final cheap = VendorEntity(name: 'Cheap Co');
    final pricey = VendorEntity(name: 'Pricey Inc');
    final results = ComputeSupplierScorecards.call([
      _tx(100, DateTime(2026, 1, 1), vendor: cheap),
      _tx(500, DateTime(2026, 1, 1), vendor: pricey),
    ]);

    expect(results.map((r) => r.vendorName), ['Cheap Co', 'Pricey Inc']);
  });

  test('flags the cheapest vendor as recommended, no one else', () {
    final cheap = VendorEntity(name: 'Cheap Co');
    final pricey = VendorEntity(name: 'Pricey Inc');
    final results = ComputeSupplierScorecards.call([
      _tx(100, DateTime(2026, 1, 1), vendor: cheap),
      _tx(500, DateTime(2026, 1, 1), vendor: pricey),
    ]);

    expect(results.where((r) => r.isRecommended).map((r) => r.vendorName), ['Cheap Co']);
  });

  test('detects a rising price trend across a vendor\'s transactions', () {
    final vendor = VendorEntity(name: 'Rising Corp');
    final results = ComputeSupplierScorecards.call([
      _tx(100, DateTime(2026, 1, 1), vendor: vendor),
      _tx(200, DateTime(2026, 2, 1), vendor: vendor),
    ]);

    expect(results.single.priceTrend, SpendingTrend.rising);
  });

  test('averages spend correctly across multiple transactions', () {
    final vendor = VendorEntity(name: 'Steady Co');
    final results = ComputeSupplierScorecards.call([
      _tx(100, DateTime(2026, 1, 1), vendor: vendor),
      _tx(300, DateTime(2026, 1, 2), vendor: vendor),
    ]);

    expect(results.single.totalSpend, 400);
    expect(results.single.transactionCount, 2);
    expect(results.single.averageAmount, 200);
  });

  test('a transaction with no vendor tagged is excluded entirely', () {
    final results = ComputeSupplierScorecards.call([
      _tx(100, DateTime(2026, 1, 1)),
    ]);

    expect(results, isEmpty);
  });

  test('no transactions returns an empty list', () {
    expect(ComputeSupplierScorecards.call([]), isEmpty);
  });
}
