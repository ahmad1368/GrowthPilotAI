import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_cumulative_transaction_count.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

WholesaleOrderEntity _order(int id, DateTime orderedAt) {
  return WholesaleOrderEntity(
    id: id,
    buyerMerchantName: 'Alpha',
    itemsSummary: '1x Item',
    totalAmount: 50,
    orderedAt: orderedAt,
  );
}

void main() {
  test('counts orders at or before the settling order, chronologically', () {
    final earlier = _order(1, DateTime(2026, 1, 1));
    final settling = _order(2, DateTime(2026, 2, 1));
    final later = _order(3, DateTime(2026, 3, 1));
    final orders = [earlier, settling, later];

    expect(ComputeCumulativeTransactionCount.call(settling, orders), 2);
  });

  test('a lone order counts as one', () {
    final order = _order(1, DateTime(2026, 1, 1));
    expect(ComputeCumulativeTransactionCount.call(order, [order]), 1);
  });
}
