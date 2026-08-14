import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/derive_trial_start_date.dart';
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
  final fallback = DateTime(2026, 1, 1);

  test('uses the earliest order for the merchant', () {
    final orders = [
      _order('Alpha', DateTime(2026, 3, 1)),
      _order('Alpha', DateTime(2026, 2, 1)),
      _order('Beta', DateTime(2026, 1, 15)),
    ];
    expect(DeriveTrialStartDate.call('Alpha', orders, fallback), DateTime(2026, 2, 1));
  });

  test('falls back when the merchant has no orders', () {
    expect(DeriveTrialStartDate.call('Gamma', [], fallback), fallback);
  });
}
