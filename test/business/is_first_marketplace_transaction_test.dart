import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_first_marketplace_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

WholesaleOrderEntity _order(int id, DateTime orderedAt) {
  return WholesaleOrderEntity(
    id: id,
    buyerMerchantName: 'Merchant',
    itemsSummary: '1x Item',
    totalAmount: 100,
    orderedAt: orderedAt,
  );
}

void main() {
  test('a lone order is the first transaction', () {
    final order = _order(1, DateTime(2026, 1, 1));
    expect(IsFirstMarketplaceTransaction.call(order, [order]), true);
  });

  test('the chronologically earliest order among several is first', () {
    final earliest = _order(1, DateTime(2026, 1, 1));
    final later = _order(2, DateTime(2026, 2, 1));
    final orders = [earliest, later];

    expect(IsFirstMarketplaceTransaction.call(earliest, orders), true);
    expect(IsFirstMarketplaceTransaction.call(later, orders), false);
  });

  test('an empty merchant order list defaults to first', () {
    final order = _order(1, DateTime(2026, 1, 1));
    expect(IsFirstMarketplaceTransaction.call(order, []), true);
  });
}
