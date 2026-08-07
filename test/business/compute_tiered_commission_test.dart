import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_standard_commission.dart';
import 'package:growth_pilot_ai/business/compute_tiered_commission.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

WholesaleOrderEntity _order(int id, DateTime orderedAt, {double amount = 1000}) {
  return WholesaleOrderEntity(
    id: id,
    buyerMerchantName: 'Alpha',
    itemsSummary: '1x Item',
    totalAmount: amount,
    orderedAt: orderedAt,
  );
}

void main() {
  final now = DateTime(2026, 6, 1);

  test('unverified merchants settle at the standard flat rate', () {
    final order = _order(1, now, amount: 1000);
    final record = ComputeTieredCommission.call(
      order: order,
      merchantOrders: [order],
      dependencyVerified: false,
      now: now,
    );
    expect(record.commissionRate, ComputeStandardCommission.rate);
    expect(record.commissionAmount, 50.0);
    expect(record.dependencyVerified, false);
  });

  test('verified merchants settle at the tiered rate for their band', () {
    final order = _order(1, now, amount: 1000);
    final record = ComputeTieredCommission.call(
      order: order,
      merchantOrders: [order],
      dependencyVerified: true,
      now: now,
    );
    expect(record.tierBand, CommissionTierBand.upTo100);
    expect(record.commissionRate, 0.0002);
    expect(record.commissionAmount, 0.2);
  });

  test('an admin override forces the band regardless of cumulative volume', () {
    final order = _order(1, now, amount: 1000);
    final record = ComputeTieredCommission.call(
      order: order,
      merchantOrders: [order],
      dependencyVerified: true,
      overrideBand: CommissionTierBand.over10000,
      now: now,
    );
    expect(record.tierBand, CommissionTierBand.over10000);
    expect(record.isOverridden, true);
  });
}
