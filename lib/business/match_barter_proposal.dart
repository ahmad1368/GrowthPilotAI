import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';

/// Scores how well a proposal matches its target listing (Issue #413,
/// acceptance criterion 1) by comparing item value, category
/// relevance, and geographical proximity — this app has no real
/// geolocation backend, so proximity is approximated by exact
/// commercial-zone text equality. Returns 0-100, higher is better.
class MatchBarterProposal {
  static int call(BarterListingEntity listing, BarterProposalEntity proposal) {
    final valueScore = _valueScore(listing.estimatedValue, proposal.offeredValue);
    final categoryScore =
        listing.category.toLowerCase() == proposal.offeredCategory.toLowerCase() ? 30 : 0;
    final zoneScore =
        listing.geoZone.toLowerCase() == proposal.proposerZone.toLowerCase() ? 30 : 0;
    return valueScore + categoryScore + zoneScore;
  }

  static int _valueScore(double listingValue, double offeredValue) {
    if (listingValue <= 0) return 0;
    final diffRatio = (listingValue - offeredValue).abs() / listingValue;
    final closeness = (1 - diffRatio).clamp(0, 1);
    return (closeness * 40).round();
  }
}
