import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_barter_reputation.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_row_actions.dart';

/// One barter listing card (Issue #413) — header info, a local trust
/// score from [ComputeBarterReputation], and status-specific actions
/// from [BarterRowActions].
class BarterRow extends StatelessWidget {
  final BarterListingEntity listing;
  final List<BarterProposalEntity> proposals;
  final List<BarterListingEntity> allListings;
  final List<BarterProposalEntity> allProposals;
  final void Function(String, String, String, String, double, String) onPropose;
  final void Function(BarterProposalEntity) onAccept;
  final void Function(BarterProposalEntity) onComplete;

  const BarterRow({
    super.key,
    required this.listing,
    required this.proposals,
    required this.allListings,
    required this.allProposals,
    required this.onPropose,
    required this.onAccept,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final reputation =
        ComputeBarterReputation.call(listing.merchantName, allListings, allProposals);
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
          Text('${listing.surplusItemName} — ${listing.merchantName} (${listing.geoZone})'),
          Text(
              'Wants: ${listing.wantedItemName} (~\$${listing.estimatedValue.toStringAsFixed(2)}) '
              '— ${listing.status.name} — $reputation trade(s) completed',
              style: const TextStyle(fontSize: 12)),
          BarterRowActions(
              listing: listing,
              proposals: proposals,
              onPropose: onPropose,
              onAccept: onAccept,
              onComplete: onComplete),
        ],
      ),
    );
  }
}
