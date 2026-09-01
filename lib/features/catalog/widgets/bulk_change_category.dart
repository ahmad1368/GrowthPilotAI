import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_repos.dart';

/// Sets every selected listing's category (Issue #143, Bulk Action
/// "Change Category").
void bulkChangeCategory(AdminTableRepos repos, Set<int> ids, String category) {
  for (final listing in repos.listings.getAll()) {
    if (!ids.contains(listing.id)) continue;
    listing.category = category;
    repos.listings.save(listing);
  }
}
