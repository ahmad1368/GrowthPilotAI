import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_bid_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One bid line under an active listing (Issue #412, acceptance
/// criterion 3) — an Accept button only shows for pending bids while
/// the listing itself is still active.
class AssetBidRow extends StatelessWidget {
  final AssetBidEntity bid;
  final bool canAccept;
  final VoidCallback onAccept;

  const AssetBidRow(
      {super.key, required this.bid, required this.canAccept, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${bid.bidderName}: \$${bid.bidAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12)),
          if (canAccept && bid.status == AssetBidStatus.pending)
            ShadButton.ghost(onPressed: onAccept, child: const Text('Accept')),
        ],
      ),
    );
  }
}
