import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_barter_reputation.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';

BarterListingEntity _listing(int id, String merchant, BarterListingStatus status) {
  return BarterListingEntity(
    id: id,
    merchantName: merchant,
    surplusItemName: 'Item',
    surplusItemDescription: '',
    wantedItemName: 'Wanted',
    category: 'Cat',
    estimatedValue: 100,
    geoZone: 'Zone',
    dbStatus: status.index,
    listedAt: DateTime(2026, 1, 1),
  );
}

BarterProposalEntity _proposal(int id, String proposer, BarterProposalStatus status) {
  return BarterProposalEntity(
    id: id,
    listingId: 1,
    proposerName: proposer,
    offeredItemName: 'Offer',
    offeredItemDescription: '',
    offeredCategory: 'Cat',
    offeredValue: 100,
    proposerZone: 'Zone',
    dbStatus: status.index,
    proposedAt: DateTime(2026, 1, 2),
  );
}

void main() {
  test('counts completed trades on both the listing and proposer side', () {
    final listings = [
      _listing(1, 'Alice', BarterListingStatus.completed),
      _listing(2, 'Alice', BarterListingStatus.active),
      _listing(3, 'Bob', BarterListingStatus.completed),
    ];
    final proposals = [
      _proposal(1, 'Alice', BarterProposalStatus.completed),
      _proposal(2, 'Alice', BarterProposalStatus.pending),
    ];

    expect(ComputeBarterReputation.call('Alice', listings, proposals), 2);
    expect(ComputeBarterReputation.call('Bob', listings, proposals), 1);
    expect(ComputeBarterReputation.call('Nobody', listings, proposals), 0);
  });
}
