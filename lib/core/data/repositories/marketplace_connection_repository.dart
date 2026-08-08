import '../../../../objectbox.g.dart';
import '../entities/marketplace_connection_entity.dart';

/// Thin ObjectBox wrapper for connected marketplace accounts (Issue #127).
class MarketplaceConnectionRepository {
  final Box<MarketplaceConnectionEntity> _box;

  MarketplaceConnectionRepository(this._box);

  List<MarketplaceConnectionEntity> getAll() => _box.getAll();

  int upsert(MarketplaceConnectionEntity connection) => _box.put(connection);
}
