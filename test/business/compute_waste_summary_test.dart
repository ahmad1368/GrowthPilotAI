import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_waste_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';

WasteLogEntity _entry(double value, WasteReason reason) => WasteLogEntity(
    itemDescription: 'item', estimatedValue: value, date: DateTime(2026, 1, 1))
  ..reason = reason;

void main() {
  test('groups entries by reason and sums their value', () {
    final results = ComputeWasteSummary.call([
      _entry(10, WasteReason.expiration),
      _entry(5, WasteReason.expiration),
      _entry(20, WasteReason.damage),
    ]);

    final expiration = results.firstWhere((r) => r.reason == WasteReason.expiration);
    expect(expiration.totalValue, 15);
    expect(expiration.entryCount, 2);
  });

  test('ranks reasons by highest total loss first', () {
    final results = ComputeWasteSummary.call([
      _entry(5, WasteReason.damage),
      _entry(50, WasteReason.expiration),
    ]);

    expect(results.map((r) => r.reason), [WasteReason.expiration, WasteReason.damage]);
  });

  test('an empty entry list returns an empty summary', () {
    expect(ComputeWasteSummary.call([]), isEmpty);
  });

  test('a single entry produces exactly one breakdown', () {
    final results = ComputeWasteSummary.call([_entry(12.5, WasteReason.other)]);
    expect(results, hasLength(1));
    expect(results.single.totalValue, 12.5);
  });
}
