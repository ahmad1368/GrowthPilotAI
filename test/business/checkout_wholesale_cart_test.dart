import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/checkout_wholesale_cart.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/wholesale_listing_status.dart';

WholesaleListingEntity _listing(int id, String name, int qty, double price) =>
    WholesaleListingEntity(
      id: id,
      inventoryItemId: id,
      itemName: name,
      quantityListed: qty,
      wholesalePrice: price,
      listedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('total amount sums quantity times price across every cart item', () {
    final cart = [_listing(1, 'Rice', 10, 2.0), _listing(2, 'Beans', 5, 3.0)];

    final result =
        CheckoutWholesaleCart.call(cart: cart, buyerMerchantName: 'Neighbor Co', now: DateTime(2026, 1, 2));

    expect(result.order.totalAmount, 35.0); // 10*2 + 5*3
    expect(result.order.buyerMerchantName, 'Neighbor Co');
  });

  test('the order summary mentions every purchased item', () {
    final cart = [_listing(1, 'Rice', 10, 2.0), _listing(2, 'Beans', 5, 3.0)];

    final result =
        CheckoutWholesaleCart.call(cart: cart, buyerMerchantName: 'Neighbor Co', now: DateTime(2026, 1, 2));

    expect(result.order.itemsSummary, contains('Rice'));
    expect(result.order.itemsSummary, contains('Beans'));
  });

  test('every checked-out listing is marked sold', () {
    final cart = [_listing(1, 'Rice', 10, 2.0)];

    final result =
        CheckoutWholesaleCart.call(cart: cart, buyerMerchantName: 'Neighbor Co', now: DateTime(2026, 1, 2));

    expect(result.soldListings.single.status, WholesaleListingStatus.sold);
    expect(result.soldListings.single.id, 1);
  });
}
