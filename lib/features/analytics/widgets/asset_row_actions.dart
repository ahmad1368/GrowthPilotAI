import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_bid_input.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_bid_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Status-specific action area for one listing (Issue #412) — split
/// out of [AssetRow] to stay under the file line cap.
class AssetRowActions extends StatelessWidget {
  final AssetListingEntity listing;
  final List<AssetBidEntity> bids;
  final void Function(bool approved) onDecide;
  final void Function(String bidderName, double amount) onSubmitBid;
  final void Function(AssetBidEntity bid) onAcceptBid;
  final VoidCallback onConfirmPickup;

  const AssetRowActions({
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
    if (listing.status == AssetListingStatus.pendingReview) {
      return Row(children: [
        ShadButton.ghost(onPressed: () => onDecide(true), child: const Text('Approve')),
        ShadButton.ghost(onPressed: () => onDecide(false), child: const Text('Reject')),
      ]);
    }
    if (listing.status == AssetListingStatus.active) {
      return Column(children: [
        AssetBidInput(onSubmit: onSubmitBid),
        for (final bid in bids)
          AssetBidRow(bid: bid, canAccept: true, onAccept: () => onAcceptBid(bid)),
      ]);
    }
    if (listing.status == AssetListingStatus.sold) {
      return ShadButton.ghost(onPressed: onConfirmPickup, child: const Text('Confirm Pickup'));
    }
    return const SizedBox.shrink();
  }
}
