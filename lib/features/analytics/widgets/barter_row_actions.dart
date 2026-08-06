import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_proposal_input.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_proposal_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Status-specific action area for one listing (Issue #413) — split
/// out of [BarterRow] to stay under the file line cap.
class BarterRowActions extends StatelessWidget {
  final BarterListingEntity listing;
  final List<BarterProposalEntity> proposals;
  final void Function(String proposerName, String itemName, String itemDescription,
      String category, double value, String zone) onPropose;
  final void Function(BarterProposalEntity proposal) onAccept;
  final void Function(BarterProposalEntity proposal) onComplete;

  const BarterRowActions({
    super.key,
    required this.listing,
    required this.proposals,
    required this.onPropose,
    required this.onAccept,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (listing.status == BarterListingStatus.active) {
      return Column(children: [
        BarterProposalInput(onSubmit: onPropose),
        for (final proposal in proposals)
          BarterProposalRow(
              listing: listing,
              proposal: proposal,
              canAccept: true,
              onAccept: () => onAccept(proposal)),
      ]);
    }
    if (listing.status == BarterListingStatus.matched) {
      final accepted =
          proposals.where((p) => p.status == BarterProposalStatus.accepted).firstOrNull;
      if (accepted == null) return const SizedBox.shrink();
      return ShadButton.ghost(
          onPressed: () => onComplete(accepted), child: const Text('Confirm Trade Resolved'));
    }
    return const SizedBox.shrink();
  }
}
