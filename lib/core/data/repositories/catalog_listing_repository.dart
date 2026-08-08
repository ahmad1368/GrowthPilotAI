import '../../../../objectbox.g.dart';
import '../entities/catalog_listing_entity.dart';

/// Insert/lookup CRUD for catalog listings (Issue #138).
class CatalogListingRepository {
  final Box<CatalogListingEntity> _box;

  CatalogListingRepository(this._box);

  int save(CatalogListingEntity listing) => _box.put(listing);

  List<CatalogListingEntity> getAll() => _box.getAll();
}
