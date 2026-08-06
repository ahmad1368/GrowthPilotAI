import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_repos.dart';

/// Listing creation for the barter exchange (Issue #413, acceptance
/// criterion 1) — split out of [BarterBody].
class BarterListingActions {
  final BarterRepos repos;

  BarterListingActions(this.repos);

  BarterListingEntity create(BarterListingEntity listing) {
    repos.listings.save(listing);
    return listing;
  }
}
