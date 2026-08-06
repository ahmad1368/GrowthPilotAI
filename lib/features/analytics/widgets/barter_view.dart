import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_barter_listing_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a new-listing button, every listing card, and a summary
/// narrative (Issue #413). Purely presentational.
class BarterView extends StatelessWidget {
  final List<BarterListingEntity> listings;
  final List<BarterProposalEntity> proposals;
  final VoidCallback onCreate;
  final void Function(BarterListingEntity, String, String, String, String, double, String)
      onPropose;
  final void Function(BarterListingEntity, BarterProposalEntity) onAccept;
  final void Function(BarterListingEntity, BarterProposalEntity) onComplete;

  const BarterView({
    super.key,
    required this.listings,
    required this.proposals,
    required this.onCreate,
    required this.onPropose,
    required this.onAccept,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ShadButton.outline(
              onPressed: onCreate, child: Text('+ List Item for Barter', style: TextStyle(color: fg))),
        ]),
        for (final listing in listings)
          BarterRow(
            listing: listing,
            proposals: proposals.where((p) => p.listingId == listing.id).toList(),
            allListings: listings,
            allProposals: proposals,
            onPropose: (name, item, desc, cat, value, zone) =>
                onPropose(listing, name, item, desc, cat, value, zone),
            onAccept: (proposal) => onAccept(listing, proposal),
            onComplete: (proposal) => onComplete(listing, proposal),
          ),
        const SizedBox(height: 8),
        Text(BuildBarterListingNarrative.call(listings)),
      ],
    );
  }
}
