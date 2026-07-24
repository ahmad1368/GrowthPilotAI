import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_brand_penetration_index.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';

TransactionEntity _income(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'in', dbType: 1);
TransactionEntity _expense(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'out', dbType: 0);

void main() {
  test('index is userVolume / benchmark * 100 for the trailing 30 days', () {
    final now = DateTime.now();
    // Tech benchmark is 28000/mo (see GetRegionalCategoryBenchmark).
    final index = ComputeBrandPenetrationIndex.call(
        [_income(now.subtract(const Duration(days: 10)), 14000)],
        BusinessSector.tech);

    expect(index.userVolume, 14000);
    expect(index.neighborhoodBenchmarkVolume, 28000);
    expect(index.indexPercent, closeTo(50, 0.001));
  });

  test('ignores income older than 30 days', () {
    final now = DateTime.now();
    final index = ComputeBrandPenetrationIndex.call(
        [_income(now.subtract(const Duration(days: 45)), 99999)],
        BusinessSector.tech);

    expect(index.userVolume, 0);
    expect(index.indexPercent, 0);
  });

  test('ignores expense transactions', () {
    final now = DateTime.now();
    final index = ComputeBrandPenetrationIndex.call(
        [_expense(now.subtract(const Duration(days: 5)), 5000)],
        BusinessSector.tech);

    expect(index.userVolume, 0);
  });

  test('uses the benchmark for the given sector', () {
    final now = DateTime.now();
    final index = ComputeBrandPenetrationIndex.call(
        [_income(now, 21000)], BusinessSector.retail);

    // Retail benchmark is 35000/mo.
    expect(index.neighborhoodBenchmarkVolume, 35000);
    expect(index.indexPercent, closeTo(60, 0.001));
  });
}
