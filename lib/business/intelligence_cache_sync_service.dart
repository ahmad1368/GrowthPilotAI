import 'package:growth_pilot_ai/business/cache_intelligence_bundle.dart';
import 'package:growth_pilot_ai/business/enforce_intelligence_cache_kill_switch.dart';
import 'package:growth_pilot_ai/business/has_intelligence_cache_entry_changed.dart';
import 'package:growth_pilot_ai/business/select_intelligence_cache_evictions.dart';
import 'package:growth_pilot_ai/business/should_refresh_intelligence_cache.dart';
import 'package:growth_pilot_ai/core/data/repositories/intelligence_cache_repository.dart';
import 'package:growth_pilot_ai/core/models/intelligence_bundle.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// "Edge Intelligence Downloader" + "Secure Storage Vault" (Issues
/// #105/#106): caches #104 [IntelligenceBundle]s AES-encrypted at rest
/// for offline Radar Chart (#99) / Efficiency Gap (#100) rendering.
/// Runs entirely against the on-device ObjectBox store, so [syncIfDue]
/// is safe off the UI thread.
class IntelligenceCacheSyncService {
  final IntelligenceCacheRepository _repo;
  final FieldCipher _cipher;
  final _killSwitch = EnforceIntelligenceCacheKillSwitch();
  DateTime? _lastSyncedAt;

  IntelligenceCacheSyncService(this._repo, this._cipher) {
    final all = _repo.getAll();
    if (all.isNotEmpty) {
      _lastSyncedAt = all.map((e) => e.syncedAt).reduce((a, b) => a.isAfter(b) ? a : b);
    }
  }

  DateTime? get lastSyncedAt => _lastSyncedAt;

  /// Runs the Kill Switch first (a wipe resets [lastSyncedAt]); writes
  /// only changed entries, then evicts down to the 500-item cap.
  /// [interval] (Issue #110) throttles the sync on low-end hardware.
  Future<void> syncIfDue(Map<String, IntelligenceBundle> bundles,
      {DateTime? now, Duration? interval}) async {
    final at = now ?? DateTime.now();
    if (await _killSwitch.call(_repo, _cipher)) _lastSyncedAt = null;

    if (!ShouldRefreshIntelligenceCache.call(_lastSyncedAt, at, interval: interval)) return;

    for (final entry in bundles.entries) {
      final cached = _repo.getByItemId(entry.key);
      final fresh = await CacheIntelligenceBundle.call(
          entry.key, entry.value, at, _cipher, id: cached?.id ?? 0);
      if (HasIntelligenceCacheEntryChanged.call(cached, fresh)) {
        _repo.upsert(fresh);
      }
    }

    _repo.removeAll(SelectIntelligenceCacheEvictions.call(_repo.getAll()));
    _lastSyncedAt = at;
  }
}
