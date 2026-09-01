import '../../../../objectbox.g.dart';
import '../entities/embedding_entity.dart';

/// Thin ObjectBox wrapper for [EmbeddingEntity] rows (Issue #198).
/// [clearAll] is the "purge the Vector Index" step the issue ties to
/// account deletion (Issue #182) — not wired to that flow yet, see PR
/// notes.
class EmbeddingRepository {
  final Box<EmbeddingEntity> _box;

  EmbeddingRepository(this._box);

  List<EmbeddingEntity> getAll() => _box.getAll();

  void upsert(EmbeddingEntity embedding) => _box.put(embedding);

  void clearAll() => _box.removeAll();
}
