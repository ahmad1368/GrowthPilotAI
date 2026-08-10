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
}
