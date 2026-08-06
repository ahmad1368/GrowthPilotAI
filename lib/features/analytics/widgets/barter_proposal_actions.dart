import 'package:growth_pilot_ai/business/accept_barter_proposal.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/complete_barter_trade.dart';
import 'package:growth_pilot_ai/business/propose_barter_trade.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_repos.dart';

/// Proposal submission, acceptance, and trade resolution (Issue #413,
/// acceptance criteria 2-4) — split out of [BarterBody].
class BarterProposalActions {
  final BarterRepos repos;

  BarterProposalActions(this.repos);

  void propose(BarterListingEntity listing, String proposerName, String itemName,
      String itemDescription, String category, double value, String zone) {
    repos.proposals.save(ProposeBarterTrade.call(
      listingId: listing.id,
      proposerName: proposerName,
      offeredItemName: itemName,
      offeredItemDescription: itemDescription,
      offeredCategory: category,
      offeredValue: value,
      proposerZone: zone,
      now: DateTime.now(),
    ));
  }

  ({BarterListingEntity listing, BarterProposalEntity proposal}) accept(
      BarterListingEntity listing, BarterProposalEntity proposal) {
    final result = AcceptBarterProposal.call(listing, proposal);
    repos.listings.save(result.listing);
    repos.proposals.save(result.proposal);
    return result;
  }

  ({BarterListingEntity listing, BarterProposalEntity proposal}) complete(
      BarterListingEntity listing, BarterProposalEntity proposal) {
    final result = CompleteBarterTrade.call(listing, proposal);
    repos.listings.save(result.listing);
    repos.proposals.save(result.proposal);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'completed barter trade',
      targetMerchant: listing.merchantName,
      previousValue: listing.surplusItemName,
      newValue: 'traded with ${proposal.proposerName} for ${proposal.offeredItemName}',
    ));
    return result;
  }
}
