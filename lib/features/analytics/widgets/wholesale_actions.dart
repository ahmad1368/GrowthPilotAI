import 'package:growth_pilot_ai/business/apply_stock_movement.dart';
import 'package:growth_pilot_ai/business/checkout_wholesale_cart.dart';
import 'package:growth_pilot_ai/business/flag_surplus_for_wholesale.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_repos.dart';

/// Listing and checkout persistence for the wholesale marketplace
/// (Issue #411) — split out of [WholesaleBody].
class WholesaleActions {
  final WholesaleRepos repos;

  WholesaleActions(this.repos);

  List<WholesaleListingEntity>? flagNextSurplus(
      DeadStockLiquidationSnapshot? candidate, List<WholesaleListingEntity> listings) {
    if (candidate == null) return null;
    final listing = FlagSurplusForWholesale.call(candidate, DateTime.now());
    repos.listings.save(listing);
    return [...listings, listing];
  }

  Future<List<WholesaleListingEntity>?> checkoutCart(
      List<WholesaleListingEntity> listings, Set<int> cartIds, String buyerName) async {
    final cart = listings.where((l) => cartIds.contains(l.id)).toList();
    if (cart.isEmpty || buyerName.trim().isEmpty) return null;
    final result = CheckoutWholesaleCart.call(
        cart: cart, buyerMerchantName: buyerName.trim(), now: DateTime.now());
    repos.orders.save(result.order);
    for (final listing in result.soldListings) {
      repos.listings.save(listing);
      await ApplyStockMovement.call(repos.store, listing.inventoryItemId,
          listing.quantityListed, StockMovementType.sale, channel: SalesChannel.wholesale);
    }
    return repos.listings.getAll();
  }
}
