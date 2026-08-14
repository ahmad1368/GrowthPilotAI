import '../../../../objectbox.g.dart';
import '../entities/product_listing_details_entity.dart';

/// Insert/lookup CRUD for the Product discriminator's fields (Issue
/// #138, acceptance criterion 2).
class ProductListingDetailsRepository {
  final Box<ProductListingDetailsEntity> _box;

  ProductListingDetailsRepository(this._box);

  int save(ProductListingDetailsEntity details) => _box.put(details);

  List<ProductListingDetailsEntity> getAll() => _box.getAll();

  ProductListingDetailsEntity? forListing(int listingId) =>
      _box.getAll().where((d) => d.listingId == listingId).firstOrNull;
}
