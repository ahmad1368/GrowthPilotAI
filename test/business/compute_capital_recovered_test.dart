import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_capital_recovered.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

void main() {
  test('sums the total amount across every completed order', () {
    final orders = [
      WholesaleOrderEntity(
          buyerMerchantName: 'A',
          itemsSummary: '10x Rice',
          totalAmount: 20,
          orderedAt: DateTime(2026, 1, 1)),
      WholesaleOrderEntity(
          buyerMerchantName: 'B',
          itemsSummary: '5x Beans',
          totalAmount: 15,
          orderedAt: DateTime(2026, 1, 2)),
    ];

    expect(ComputeCapitalRecovered.call(orders), 35);
  });

  test('an empty order list recovers zero capital', () {
    expect(ComputeCapitalRecovered.call([]), 0);
  });
}
