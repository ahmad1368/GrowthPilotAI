import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';

/// Accepts one proposal, locking the offered surplus item into escrow
/// pending resolution (Issue #413, acceptance criterion 3) — other
/// outstanding proposals on the same listing are left as-is since the
/// UI stops offering them once the listing is no longer active.
class AcceptBarterProposal {
  static ({BarterListingEntity listing, BarterProposalEntity proposal}) call(
      BarterListingEntity listing, BarterProposalEntity proposal) {
    final updatedListing = BarterListingEntity(
      id: listing.id,
      merchantName: listing.merchantName,
      surplusItemName: listing.surplusItemName,
      surplusItemDescription: listing.surplusItemDescription,
      wantedItemName: listing.wantedItemName,
      category: listing.category,
      estimatedValue: listing.estimatedValue,
      geoZone: listing.geoZone,
      dbStatus: BarterListingStatus.matched.index,
      listedAt: listing.listedAt,
    );
    final updatedProposal = BarterProposalEntity(
      id: proposal.id,
      listingId: proposal.listingId,
      proposerName: proposal.proposerName,
      offeredItemName: proposal.offeredItemName,
      offeredItemDescription: proposal.offeredItemDescription,
      offeredCategory: proposal.offeredCategory,
      offeredValue: proposal.offeredValue,
      proposerZone: proposal.proposerZone,
      dbStatus: BarterProposalStatus.accepted.index,
      proposedAt: proposal.proposedAt,
    );
    return (listing: updatedListing, proposal: updatedProposal);
  }
}
