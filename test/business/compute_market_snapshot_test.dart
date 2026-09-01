import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_market_snapshot.dart';
import 'package:growth_pilot_ai/core/models/anonymous_record.dart';

AnonymousRecord _record(String category, String region, double amount) => AnonymousRecord(
      orgHash: 'h',
      period: '2027-03',
      region: region,
      category: category,
      amount: amount,
    );

void main() {
  final now = DateTime.utc(2027, 3, 14);

  test('averages price and counts volume for the matching peer group only', () {
    final records = [
      _record('furniture', 'V3J', 100),
      _record('furniture', 'V3J', 200),
      _record('furniture', 'X1X', 999), // different region, excluded
      _record('rent', 'V3J', 500), // different category, excluded
    ];

    final snapshot = ComputeMarketSnapshot.call(records, 'furniture', 'V3J', now);

    expect(snapshot.category, 'furniture');
    expect(snapshot.region, 'V3J');
    expect(snapshot.avgPrice, 150);
    expect(snapshot.itemCount, 2);
    expect(snapshot.snapshotDate, now);
  });

  test('an empty peer group produces a zero-volume snapshot', () {
    final snapshot = ComputeMarketSnapshot.call(const [], 'furniture', 'V3J', now);
    expect(snapshot.avgPrice, 0);
    expect(snapshot.itemCount, 0);
  });
}
