import 'package:growth_pilot_ai/business/cache_intelligence_bundle.dart';
import 'package:growth_pilot_ai/business/has_intelligence_cache_entry_changed.dart';
import 'package:growth_pilot_ai/business/select_intelligence_cache_evictions.dart';
import 'package:growth_pilot_ai/business/should_refresh_intelligence_cache.dart';
import 'package:growth_pilot_ai/core/data/repositories/intelligence_cache_repository.dart';
import 'package:growth_pilot_ai/core/models/intelligence_bundle.dart';

/// The "Edge Intelligence Downloader" (Issue #105): caches locally-built
/// #104 [IntelligenceBundle]s so the Radar Chart (#99) and Efficiency Gap
/// (#100) render offline. Runs entirely against the on-device ObjectBox
/// store (no NestJS backend in this app to poll), so [syncIfDue] is safe
/// to call from a foreground-resume hook without blocking the UI thread —
/// every op here is a fast local read/write, not a network call.
class IntelligenceCacheSyncService {
  final IntelligenceCacheRepository _repo;
  DateTime? _lastSyncedAt;

  IntelligenceCacheSyncService(this._repo) {
    final all = _repo.getAll();
    if (all.isNotEmpty) {
      _lastSyncedAt = all.map((e) => e.syncedAt).reduce((a, b) => a.isAfter(b) ? a : b);
    }
  }

  DateTime? get lastSyncedAt => _lastSyncedAt;

  /// Writes only the entries whose bundle actually changed since the last
  /// sync, then evicts down to the 500-item cap.
  Future<void> syncIfDue(Map<String, IntelligenceBundle> bundles, {DateTime? now}) async {
    final at = now ?? DateTime.now();
    if (!ShouldRefreshIntelligenceCache.call(_lastSyncedAt, at)) return;

    for (final entry in bundles.entries) {
      final cached = _repo.getByItemId(entry.key);
      final fresh = CacheIntelligenceBundle.call(entry.key, entry.value, at, id: cached?.id ?? 0);
      if (HasIntelligenceCacheEntryChanged.call(cached, fresh)) {
        _repo.upsert(fresh);
      }
    }

    _repo.removeAll(SelectIntelligenceCacheEvictions.call(_repo.getAll()));
    _lastSyncedAt = at;
  }
}
