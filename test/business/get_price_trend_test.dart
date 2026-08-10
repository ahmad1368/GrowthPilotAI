import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/get_price_trend.dart';
import 'package:growth_pilot_ai/core/data/entities/market_snapshot_entity.dart';

MarketSnapshotEntity _snapshot(DateTime date, double price) => MarketSnapshotEntity(
      category: 'furniture',
      region: 'V3J',
      avgPrice: price,
      itemCount: 1,
      snapshotDate: date,
    );

void main() {
  final now = DateTime.utc(2027, 3, 31);

  test('excludes snapshots older than the 30-day window', () {
    final snapshots = [
      _snapshot(now.subtract(const Duration(days: 45)), 999), // excluded
      _snapshot(now.subtract(const Duration(days: 10)), 150),
    ];

    final trend = GetPriceTrend.call(snapshots, now);

    expect(trend.length, 1);
    expect(trend.single.value, 150);
  });

  test('sorts points oldest-first', () {
    final snapshots = [
      _snapshot(now.subtract(const Duration(days: 5)), 200),
      _snapshot(now.subtract(const Duration(days: 20)), 100),
    ];

    final trend = GetPriceTrend.call(snapshots, now);

    expect(trend.map((p) => p.value), [100, 200]);
  });

  test('an empty snapshot list produces an empty trend', () {
    expect(GetPriceTrend.call(const [], now), isEmpty);
  });
}
