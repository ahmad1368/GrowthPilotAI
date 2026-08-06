import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';

/// Counts a merchant's completed barter trades, on either side of the
/// exchange, as a local trust/reputation metric (Issue #413,
/// acceptance criterion 4) — this app has no shared merchant-identity
/// backend, so reputation is derived purely from this device's local
/// trade history rather than a network-wide score.
class ComputeBarterReputation {
  static int call(
    String merchantName,
    List<BarterListingEntity> listings,
    List<BarterProposalEntity> proposals,
  ) {
    final asOwner = listings
        .where((l) => l.merchantName == merchantName && l.status == BarterListingStatus.completed)
        .length;
    final asProposer = proposals
        .where((p) =>
            p.proposerName == merchantName && p.status == BarterProposalStatus.completed)
        .length;
    return asOwner + asProposer;
  }
}
