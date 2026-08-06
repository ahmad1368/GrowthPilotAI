import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/match_barter_proposal.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One counter-offer line under an active listing (Issue #413,
/// acceptance criteria 1-2) — shows the [MatchBarterProposal] score
/// and an Accept button only for pending proposals while the listing
/// is still active.
class BarterProposalRow extends StatelessWidget {
  final BarterListingEntity listing;
  final BarterProposalEntity proposal;
  final bool canAccept;
  final VoidCallback onAccept;

  const BarterProposalRow({
    super.key,
    required this.listing,
    required this.proposal,
    required this.canAccept,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final score = MatchBarterProposal.call(listing, proposal);
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
                '${proposal.proposerName}: ${proposal.offeredItemName} '
                '(\$${proposal.offeredValue.toStringAsFixed(2)}, match $score%)',
                style: const TextStyle(fontSize: 12)),
          ),
          if (canAccept && proposal.status == BarterProposalStatus.pending)
            ShadButton.ghost(onPressed: onAccept, child: const Text('Accept')),
        ],
      ),
    );
  }
}
