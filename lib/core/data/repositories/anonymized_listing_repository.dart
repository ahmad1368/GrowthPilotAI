import '../../../../objectbox.g.dart';
import '../entities/anonymized_listing_entity.dart';

/// The decoupled analytics store (Issue #93) — a box distinct from any
/// production entity, holding only [AnonymizedListingEntity] shadow
/// records.
class AnonymizedListingRepository {
  final Box<AnonymizedListingEntity> _box;

  AnonymizedListingRepository(this._box);

  int save(AnonymizedListingEntity listing) => _box.put(listing);

  List<AnonymizedListingEntity> getAll() => _box.getAll();

  List<AnonymizedListingEntity> getByHashedId(String hashedId) =>
      _box.query(AnonymizedListingEntity_.hashedId.equals(hashedId)).build().find();

  /// Issue #94: hard-deletes expired/forgotten records. Returns the
  /// number removed for the "log the summary of deleted records" AC.
  int removeMany(List<int> ids) => _box.removeMany(ids);
}
