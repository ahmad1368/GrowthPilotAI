import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_asset_listing_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a new-listing button, every listing card, and a summary
/// narrative (Issue #412). Purely presentational.
class AssetView extends StatelessWidget {
  final List<AssetListingEntity> listings;
  final List<AssetBidEntity> bids;
  final VoidCallback onCreate;
  final void Function(AssetListingEntity, bool) onDecide;
  final void Function(AssetListingEntity, String, double) onSubmitBid;
  final void Function(AssetListingEntity, AssetBidEntity) onAcceptBid;
  final void Function(AssetListingEntity) onConfirmPickup;

  const AssetView({
    super.key, required this.listings, required this.bids, required this.onCreate,
    required this.onDecide, required this.onSubmitBid, required this.onAcceptBid,
    required this.onConfirmPickup,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ShadButton.outline(
              onPressed: onCreate, child: Text('+ List Asset', style: TextStyle(color: fg))),
        ]),
        for (final listing in listings)
          AssetRow(
            listing: listing,
            bids: bids.where((b) => b.listingId == listing.id).toList(),
            onDecide: (approved) => onDecide(listing, approved),
            onSubmitBid: (bidder, amount) => onSubmitBid(listing, bidder, amount),
            onAcceptBid: (bid) => onAcceptBid(listing, bid),
            onConfirmPickup: () => onConfirmPickup(listing),
          ),
        const SizedBox(height: 8),
        Text(BuildAssetListingNarrative.call(listings)),
      ],
    );
  }
}
