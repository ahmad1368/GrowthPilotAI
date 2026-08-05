import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_wholesale_marketplace_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_checkout_bar.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_flag_button.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_listing_row.dart';

/// Renders listings, cart checkout, and a summary narrative (Issue #411).
class WholesaleView extends StatelessWidget {
  final List<WholesaleListingEntity> listings;
  final List<WholesaleOrderEntity> orders;
  final Set<int> cart;
  final bool hasCandidate;
  final TextEditingController buyerController;
  final VoidCallback onFlagSurplus;
  final void Function(int) onToggleCart;
  final VoidCallback? onCheckout;
  const WholesaleView({
    super.key,
    required this.listings,
    required this.orders,
    required this.cart,
    required this.hasCandidate,
    required this.buyerController,
    required this.onFlagSurplus,
    required this.onToggleCart,
    required this.onCheckout,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasCandidate) WholesaleFlagButton(onPressed: onFlagSurplus),
        for (final listing in listings)
          WholesaleListingRow(
            listing: listing,
            inCart: cart.contains(listing.id),
            onToggleCart: () => onToggleCart(listing.id),
          ),
        const SizedBox(height: 8),
        WholesaleCheckoutBar(
            buyerController: buyerController, cartSize: cart.length, onCheckout: onCheckout),
        const SizedBox(height: 8),
        Text(BuildWholesaleMarketplaceNarrative.call(orders)),
      ],
    );
  }
}
