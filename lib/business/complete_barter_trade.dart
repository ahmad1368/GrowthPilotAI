import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';

/// Releases the escrowed items and resolves the trade once both sides
/// confirm the exchange (Issue #413, acceptance criteria 3-4) — this
/// app has no payment-holding backend, so "escrow" is represented by
/// the [BarterListingStatus.matched] state until this transition. The
/// caller logs the resolution for reputation tracking.
// TODO (Issue #415): manual buyer/seller confirmation here should
// become (or be backed by) the automated inspection/delivery
// confirmation trigger from the smart-contract escrow engine, so a
// failed inspection can route to refund/dispute instead of completion.
class CompleteBarterTrade {
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
      dbStatus: BarterListingStatus.completed.index,
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
      dbStatus: BarterProposalStatus.completed.index,
      proposedAt: proposal.proposedAt,
    );
    return (listing: updatedListing, proposal: updatedProposal);
  }
}
