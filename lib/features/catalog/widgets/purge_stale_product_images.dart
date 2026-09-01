import 'package:growth_pilot_ai/business/purge_stale_draft_images.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';

/// Deletes locally-stored image variants that were never attached to
/// a saved listing or draft within 24h (Issue #140, "Privacy
/// Integrity").
void purgeStaleProductImages(ProductFormRepos repos, Set<int> referencedIds) {
  final staleIds = PurgeStaleDraftImages.call(
    images: repos.images.getAll().map((v) => (id: v.id, createdAt: v.createdAt)).toList(),
    referencedIds: referencedIds,
    now: DateTime.now(),
  );
  if (staleIds.isNotEmpty) repos.images.removeByIds(staleIds);
}
