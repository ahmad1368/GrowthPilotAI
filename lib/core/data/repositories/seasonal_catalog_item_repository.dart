import '../../../../objectbox.g.dart';
import '../entities/seasonal_catalog_item_entity.dart';

/// Insert-or-update CRUD for seasonal catalog lines (Issue #417),
/// mirroring [GroupPurchaseRepository]'s upsert pattern.
class SeasonalCatalogItemRepository {
  final Box<SeasonalCatalogItemEntity> _box;

  SeasonalCatalogItemRepository(this._box);

  int save(SeasonalCatalogItemEntity item) => _box.put(item);

  List<SeasonalCatalogItemEntity> getAll() => _box.getAll();
}
