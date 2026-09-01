import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_inventory_expiry_status.dart';

void main() {
  final now = DateTime(2026, 6, 15);

  test('a null expiry date is classified as none', () {
    expect(ComputeInventoryExpiryStatus.call(null, now), InventoryExpiryStatus.none);
  });

  test('a date in the past is expired', () {
    final result = ComputeInventoryExpiryStatus.call(now.subtract(const Duration(days: 1)), now);
    expect(result, InventoryExpiryStatus.expired);
  });

  test('a date within the warning window is expiringSoon', () {
    final result = ComputeInventoryExpiryStatus.call(now.add(const Duration(days: 3)), now);
    expect(result, InventoryExpiryStatus.expiringSoon);
  });

  test('a date exactly at the warning window boundary is expiringSoon', () {
    final result = ComputeInventoryExpiryStatus.call(
        now.add(const Duration(days: ComputeInventoryExpiryStatus.warningWindowDays)), now);
    expect(result, InventoryExpiryStatus.expiringSoon);
  });

  test('a far-future date is ok', () {
    final result = ComputeInventoryExpiryStatus.call(now.add(const Duration(days: 90)), now);
    expect(result, InventoryExpiryStatus.ok);
  });
}
