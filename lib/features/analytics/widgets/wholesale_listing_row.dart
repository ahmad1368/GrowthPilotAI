import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/wholesale_listing_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One wholesale listing row (Issue #411, acceptance criterion 2) —
/// active listings can be toggled into the cart; sold listings just
/// show a badge.
class WholesaleListingRow extends StatelessWidget {
  final WholesaleListingEntity listing;
  final bool inCart;
  final VoidCallback onToggleCart;

  const WholesaleListingRow(
      {super.key, required this.listing, required this.inCart, required this.onToggleCart});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final active = listing.status == WholesaleListingStatus.active;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${listing.quantityListed}x ${listing.itemName} — '
                  '\$${listing.wholesalePrice.toStringAsFixed(2)}/unit (wholesale)')),
          if (active)
            inCart
                ? ShadButton(onPressed: onToggleCart, child: const Text('In Cart'))
                : ShadButton.outline(onPressed: onToggleCart, child: const Text('Add to Cart'))
          else
            Text('Sold', style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface)),
        ],
      ),
    );
  }
}
