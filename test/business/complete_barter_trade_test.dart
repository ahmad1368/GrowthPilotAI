import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/accept_barter_proposal.dart';
import 'package:growth_pilot_ai/business/complete_barter_trade.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';

void main() {
  final listing = BarterListingEntity(
    id: 5,
    merchantName: 'Owner',
    surplusItemName: 'Espresso Beans',
    surplusItemDescription: '',
    wantedItemName: 'Bar Stools',
    category: 'Furniture',
    estimatedValue: 500,
    geoZone: 'Downtown',
    dbStatus: BarterListingStatus.active.index,
    listedAt: DateTime(2026, 1, 1),
  );
  final proposal = BarterProposalEntity(
    id: 7,
    listingId: 5,
    proposerName: 'Proposer',
    offeredItemName: 'Bar Stools',
    offeredItemDescription: '',
    offeredCategory: 'Furniture',
    offeredValue: 480,
    proposerZone: 'Downtown',
    proposedAt: DateTime(2026, 1, 2),
  );

  test('accepting a proposal locks the listing into matched escrow', () {
    final result = AcceptBarterProposal.call(listing, proposal);
    expect(result.listing.status, BarterListingStatus.matched);
    expect(result.proposal.status, BarterProposalStatus.accepted);
  });

  test('completing a trade resolves both the listing and the proposal', () {
    final accepted = AcceptBarterProposal.call(listing, proposal);
    final result = CompleteBarterTrade.call(accepted.listing, accepted.proposal);
    expect(result.listing.status, BarterListingStatus.completed);
    expect(result.proposal.status, BarterProposalStatus.completed);
    expect(result.listing.id, 5);
    expect(result.proposal.id, 7);
  });
}
