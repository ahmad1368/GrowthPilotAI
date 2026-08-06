import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';

/// Builds a new structured counter-offer on a barter listing (Issue
/// #413, acceptance criterion 2) — pure construction, the caller
/// persists it.
class ProposeBarterTrade {
  static BarterProposalEntity call({
    required int listingId,
    required String proposerName,
    required String offeredItemName,
    required String offeredItemDescription,
    required String offeredCategory,
    required double offeredValue,
    required String proposerZone,
    required DateTime now,
  }) {
    return BarterProposalEntity(
      listingId: listingId,
      proposerName: proposerName,
      offeredItemName: offeredItemName,
      offeredItemDescription: offeredItemDescription,
      offeredCategory: offeredCategory,
      offeredValue: offeredValue,
      proposerZone: proposerZone,
      proposedAt: now,
    );
  }
}
