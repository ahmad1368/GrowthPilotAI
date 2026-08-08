import 'package:growth_pilot_ai/core/enum/catalog_availability.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_repos.dart';

/// Sets every selected listing's availability to inactive (Issue
/// #143, Bulk Action "Deactivate").
void bulkDeactivateListings(AdminTableRepos repos, Set<int> ids) {
  for (final listing in repos.listings.getAll()) {
    if (!ids.contains(listing.id)) continue;
    listing.availability = CatalogAvailability.inactive;
    repos.listings.save(listing);
  }
}
