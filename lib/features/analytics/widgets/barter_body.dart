import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_listing_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_proposal_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_view.dart';

/// Owns listing/proposal state for the barter exchange (Issue #413).
class BarterBody extends StatefulWidget {
  final List<BarterListingEntity> listings;
  const BarterBody({super.key, required this.listings});
  @override
  State<BarterBody> createState() => _BarterBodyState();
}

class _BarterBodyState extends State<BarterBody> {
  final _repos = BarterRepos();
  late final _listingActions = BarterListingActions(_repos);
  late final _proposalActions = BarterProposalActions(_repos);
  late List<BarterListingEntity> _listings = widget.listings;
  late List<BarterProposalEntity> _proposals = _repos.proposals.getAll();

  void _updateListing(BarterListingEntity updated) => setState(() =>
      _listings = [for (final l in _listings) if (l.id != updated.id) l, updated]);

  Future<void> _create() async {
    final listing = await showBarterDialog(context);
    if (listing == null) return;
    setState(() => _listings = [..._listings, _listingActions.create(listing)]);
  }

  void _propose(BarterListingEntity listing, String name, String item, String desc,
      String category, double value, String zone) {
    _proposalActions.propose(listing, name, item, desc, category, value, zone);
    setState(() => _proposals = _repos.proposals.getAll());
  }

  void _accept(BarterListingEntity listing, BarterProposalEntity proposal) {
    final result = _proposalActions.accept(listing, proposal);
    _updateListing(result.listing);
    setState(() => _proposals = _repos.proposals.getAll());
  }

  void _complete(BarterListingEntity listing, BarterProposalEntity proposal) {
    final result = _proposalActions.complete(listing, proposal);
    _updateListing(result.listing);
    setState(() => _proposals = _repos.proposals.getAll());
  }

  @override
  Widget build(BuildContext context) {
    return BarterView(
      listings: _listings,
      proposals: _proposals,
      onCreate: _create,
      onPropose: _propose,
      onAccept: _accept,
      onComplete: _complete,
    );
  }
}
