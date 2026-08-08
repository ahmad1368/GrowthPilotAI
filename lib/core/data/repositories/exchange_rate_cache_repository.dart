import '../../../../objectbox.g.dart';
import '../entities/exchange_rate_cache_entity.dart';

/// Thin ObjectBox wrapper for the local rate cache (Issue #153).
class ExchangeRateCacheRepository {
  final Box<ExchangeRateCacheEntity> _box;

  ExchangeRateCacheRepository(this._box);

  ExchangeRateCacheEntity? getForPair(String pairKey) {
    final query = _box.query(ExchangeRateCacheEntity_.pairKey.equals(pairKey)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  int upsert(ExchangeRateCacheEntity entry) => _box.put(entry);
}
