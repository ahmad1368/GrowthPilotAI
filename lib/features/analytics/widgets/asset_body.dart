import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_bid_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_listing_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_view.dart';

/// Owns listing/bid state for the asset marketplace (Issue #412).
class AssetBody extends StatefulWidget {
  final List<AssetListingEntity> listings;
  const AssetBody({super.key, required this.listings});
  @override
  State<AssetBody> createState() => _AssetBodyState();
}

class _AssetBodyState extends State<AssetBody> {
  final _repos = AssetRepos();
  late final _listingActions = AssetListingActions(_repos);
  late final _bidActions = AssetBidActions(_repos);
  late List<AssetListingEntity> _listings = widget.listings;
  late List<AssetBidEntity> _bids = _repos.bids.getAll();
  void _update(AssetListingEntity updated) => setState(() =>
      _listings = [for (final l in _listings) if (l.id != updated.id) l, updated]);
  Future<void> _create() async {
    final listing = await showAssetDialog(context);
    if (listing == null) return;
    setState(() => _listings = [..._listings, _listingActions.create(listing)]);
  }
  void _decide(AssetListingEntity listing, bool approved) =>
      _update(_listingActions.decide(listing, approved));
  void _submitBid(AssetListingEntity listing, String bidder, double amount) {
    _bidActions.submitBid(listing.id, bidder, amount);
    setState(() => _bids = _repos.bids.getAll());
  }
  void _acceptBid(AssetListingEntity listing, AssetBidEntity bid) {
    _update(_bidActions.acceptBid(listing, bid).listing);
    setState(() => _bids = _repos.bids.getAll());
  }
  void _confirmPickup(AssetListingEntity listing) =>
      _update(_bidActions.confirmPickup(listing));
  @override
  Widget build(BuildContext context) {
    return AssetView(
      listings: _listings, bids: _bids, onCreate: _create, onDecide: _decide,
      onSubmitBid: _submitBid, onAcceptBid: _acceptBid, onConfirmPickup: _confirmPickup,
    );
  }
}
