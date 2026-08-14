import '../../../../objectbox.g.dart';
import '../entities/intelligence_cache_entry_entity.dart';

/// Thin ObjectBox wrapper for the local "Intelligence Node" cache (Issue
/// #105) — the Edge Downloader's on-device store.
class IntelligenceCacheRepository {
  final Box<IntelligenceCacheEntryEntity> _box;

  IntelligenceCacheRepository(this._box);

  List<IntelligenceCacheEntryEntity> getAll() => _box.getAll();

  IntelligenceCacheEntryEntity? getByItemId(String itemId) {
    final query = _box.query(IntelligenceCacheEntryEntity_.itemId.equals(itemId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  int upsert(IntelligenceCacheEntryEntity entry) => _box.put(entry);

  void removeAll(List<IntelligenceCacheEntryEntity> entries) =>
      _box.removeMany(entries.map((e) => e.id).toList());
}
