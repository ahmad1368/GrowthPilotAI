import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/match_barter_proposal.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';

BarterListingEntity _listing({double value = 500, String category = 'Furniture', String zone = 'Downtown'}) {
  return BarterListingEntity(
    id: 1,
    merchantName: 'Owner',
    surplusItemName: 'Espresso Beans',
    surplusItemDescription: '',
    wantedItemName: 'Bar Stools',
    category: category,
    estimatedValue: value,
    geoZone: zone,
    listedAt: DateTime(2026, 1, 1),
  );
}

BarterProposalEntity _proposal({double value = 500, String category = 'Furniture', String zone = 'Downtown'}) {
  return BarterProposalEntity(
    id: 1,
    listingId: 1,
    proposerName: 'Proposer',
    offeredItemName: 'Bar Stools',
    offeredItemDescription: '',
    offeredCategory: category,
    offeredValue: value,
    proposerZone: zone,
    proposedAt: DateTime(2026, 1, 2),
  );
}

void main() {
  test('exact value, category, and zone match scores 100', () {
    expect(MatchBarterProposal.call(_listing(), _proposal()), 100);
  });

  test('mismatched category and zone lose their points but value score remains', () {
    final score = MatchBarterProposal.call(
        _listing(category: 'Furniture', zone: 'Downtown'),
        _proposal(category: 'Electronics', zone: 'Kitsilano'));
    expect(score, 40);
  });

  test('a wildly mismatched value scores near zero on the value component', () {
    final score = MatchBarterProposal.call(_listing(value: 1000), _proposal(value: 0));
    expect(score, 0);
  });
}
