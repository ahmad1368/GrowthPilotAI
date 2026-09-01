import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_order_placement_volume.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

WholesaleOrderEntity _order(String merchant, DateTime orderedAt) {
  return WholesaleOrderEntity(
    buyerMerchantName: merchant,
    itemsSummary: '1x Item',
    totalAmount: 50,
    orderedAt: orderedAt,
  );
}

void main() {
  final now = DateTime(2026, 6, 1);

  test('counts only the target merchant\'s orders within the window', () {
    final orders = [
      _order('Alpha', now.subtract(const Duration(days: 10))),
      _order('Alpha', now.subtract(const Duration(days: 20))),
      _order('Beta', now.subtract(const Duration(days: 10))),
    ];
    expect(ComputeOrderPlacementVolume.call('Alpha', orders, now), 2);
  });

  test('excludes orders older than the tracking window', () {
    final orders = [_order('Alpha', now.subtract(const Duration(days: 200)))];
    expect(ComputeOrderPlacementVolume.call('Alpha', orders, now), 0);
  });

  test('returns zero for a merchant with no orders', () {
    expect(ComputeOrderPlacementVolume.call('Gamma', [], now), 0);
  });
}
