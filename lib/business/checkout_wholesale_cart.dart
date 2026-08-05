import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/wholesale_listing_status.dart';

/// Processes a multi-item B2B checkout (Issue #411, acceptance
/// criterion 3) — each cart listing is sold in full (no partial-
/// quantity split), the same simplification [PurchaseOrderEntity]
/// (#443) takes by summarizing rather than normalizing line items.
class CheckoutWholesaleCart {
  static ({WholesaleOrderEntity order, List<WholesaleListingEntity> soldListings}) call({
    required List<WholesaleListingEntity> cart,
    required String buyerMerchantName,
    required DateTime now,
  }) {
    final total = cart.fold<double>(0, (sum, l) => sum + l.wholesalePrice * l.quantityListed);
    final summary = cart.map((l) => '${l.quantityListed}x ${l.itemName}').join(', ');

    final order = WholesaleOrderEntity(
      buyerMerchantName: buyerMerchantName,
      itemsSummary: summary,
      totalAmount: total,
      orderedAt: now,
    );

    final sold = cart
        .map((l) => WholesaleListingEntity(
              id: l.id,
              inventoryItemId: l.inventoryItemId,
              itemName: l.itemName,
              quantityListed: l.quantityListed,
              wholesalePrice: l.wholesalePrice,
              dbStatus: WholesaleListingStatus.sold.index,
              listedAt: l.listedAt,
            ))
        .toList();

    return (order: order, soldListings: sold);
  }
}
