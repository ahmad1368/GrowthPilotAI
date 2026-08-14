import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_fee_waiver.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

WholesaleOrderEntity _order(int id, DateTime orderedAt, {double totalAmount = 100}) {
  return WholesaleOrderEntity(
    id: id,
    buyerMerchantName: 'Merchant',
    itemsSummary: '1x Item',
    totalAmount: totalAmount,
    orderedAt: orderedAt,
  );
}

void main() {
  test('a first-ever order with no prior waiver is fully waived', () {
    final order = _order(1, DateTime(2026, 1, 1), totalAmount: 200);

    final record = ApplyFeeWaiver.call(
      order: order,
      merchantOrders: [order],
      merchantAlreadyHasWaiver: false,
      now: DateTime(2026, 1, 1),
    );

    expect(record.isWaived, true);
    expect(record.commissionAmount, closeTo(10.0, 0.001)); // 5% of 200
    expect(record.waivedAmount, closeTo(10.0, 0.001));
  });

  test('a second order for the same merchant is charged full commission', () {
    final first = _order(1, DateTime(2026, 1, 1));
    final second = _order(2, DateTime(2026, 2, 1), totalAmount: 200);

    final record = ApplyFeeWaiver.call(
      order: second,
      merchantOrders: [first, second],
      merchantAlreadyHasWaiver: false,
      now: DateTime(2026, 2, 1),
    );

    expect(record.isWaived, false);
    expect(record.waivedAmount, 0);
    expect(record.commissionAmount, closeTo(10.0, 0.001));
  });

  test('a merchant who already has a waiver can never claim a second one', () {
    final order = _order(1, DateTime(2026, 1, 1));

    final record = ApplyFeeWaiver.call(
      order: order,
      merchantOrders: [order],
      merchantAlreadyHasWaiver: true,
      now: DateTime(2026, 1, 1),
    );

    expect(record.isWaived, false);
  });
}
