import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_row_actions.dart';

/// One asset listing card (Issue #412) — header info plus
/// status-specific actions from [AssetRowActions].
class AssetRow extends StatelessWidget {
  final AssetListingEntity listing;
  final List<AssetBidEntity> bids;
  final void Function(bool approved) onDecide;
  final void Function(String bidderName, double amount) onSubmitBid;
  final void Function(AssetBidEntity bid) onAcceptBid;
  final VoidCallback onConfirmPickup;
  const AssetRow({
    super.key,
    required this.listing,
    required this.bids,
    required this.onDecide,
    required this.onSubmitBid,
    required this.onAcceptBid,
    required this.onConfirmPickup,
  });
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${listing.assetName} — ${listing.sellerName} (${listing.commercialZone})'),
          Text(
              '\$${listing.askingPrice.toStringAsFixed(2)} of \$${listing.marketValue.toStringAsFixed(2)} — ${listing.status.name}',
              style: const TextStyle(fontSize: 12)),
          AssetRowActions(
              listing: listing, bids: bids, onDecide: onDecide, onSubmitBid: onSubmitBid,
              onAcceptBid: onAcceptBid, onConfirmPickup: onConfirmPickup),
        ],
      ),
    );
  }
}
