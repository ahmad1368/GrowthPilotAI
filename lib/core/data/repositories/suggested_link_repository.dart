import '../../../../objectbox.g.dart';
import '../entities/suggested_link_entity.dart';

/// Thin ObjectBox wrapper for [SuggestedLinkEntity] rows (Issue #244).
class SuggestedLinkRepository {
  final Box<SuggestedLinkEntity> _box;

  SuggestedLinkRepository(this._box);

  List<SuggestedLinkEntity> getAll() => _box.getAll();

  void upsert(SuggestedLinkEntity suggestion) => _box.put(suggestion);

  void delete(int id) => _box.remove(id);
}
