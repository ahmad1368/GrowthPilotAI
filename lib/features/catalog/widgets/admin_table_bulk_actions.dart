import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/admin_table_repos.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_change_category.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_deactivate_listings.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/bulk_delete_listings.dart';

/// Wraps the 3 bulk-action functions with a shared repos+refresh
/// callback (Issue #143) — split out of [AdminTableBody].
class AdminTableBulkActions {
  final AdminTableRepos repos;
  final Set<int> selectedIds;
  final VoidCallback onDone;
  AdminTableBulkActions(this.repos, this.selectedIds, this.onDone);

  void deactivate() {
    bulkDeactivateListings(repos, selectedIds);
    onDone();
  }

  void delete() {
    bulkDeleteListings(repos, selectedIds);
    onDone();
  }

  void changeCategory(String category) {
    bulkChangeCategory(repos, selectedIds, category);
    onDone();
  }
}
