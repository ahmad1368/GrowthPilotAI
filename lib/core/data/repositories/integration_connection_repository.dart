import '../../../../objectbox.g.dart';
import '../entities/integration_connection_entity.dart';

/// Thin ObjectBox wrapper for the Integrations Dashboard's connection rows
/// (Issue #61). Upserts by [IntegrationConnectionEntity.providerId] since
/// each provider has exactly one row.
class IntegrationConnectionRepository {
  final Box<IntegrationConnectionEntity> _box;

  IntegrationConnectionRepository(this._box);

  List<IntegrationConnectionEntity> getAll() => _box.getAll();

  void upsert(IntegrationConnectionEntity entity) {
    final query = _box
        .query(IntegrationConnectionEntity_.providerId
            .equals(entity.providerId))
        .build();
    final existing = query.findFirst();
    query.close();
    if (existing != null) entity.id = existing.id;
    _box.put(entity);
  }
}
