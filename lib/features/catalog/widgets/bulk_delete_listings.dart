import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_repos.dart';

/// Removes every selected listing (Issue #143, Bulk Action "Delete").
void bulkDeleteListings(AdminTableRepos repos, Set<int> ids) => repos.listings.removeByIds(ids.toList());
