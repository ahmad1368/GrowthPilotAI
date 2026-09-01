import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/build_intelligence_version_tag.dart';
import 'package:growth_pilot_ai/business/determine_intelligence_sync_state.dart';
import 'package:growth_pilot_ai/business/intelligence_cache_sync_service.dart';
import 'package:growth_pilot_ai/business/scale_interval_for_performance_tier.dart';
import 'package:growth_pilot_ai/business/should_refresh_intelligence_cache.dart';
import 'package:growth_pilot_ai/controllers/performance_controller.dart';
import 'package:growth_pilot_ai/core/data/repositories/intelligence_cache_repository.dart';
import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';
import 'package:growth_pilot_ai/core/models/intelligence_bundle.dart';

/// Drives the "Offline Intelligence" status badge (Issue #109): bridges
/// the #105/#106 background cache sync to a user-facing traffic-light
/// state, never exposing [IntelligenceCacheSyncService] internals.
class IntelligenceStatusController extends GetxController {
  late final IntelligenceCacheSyncService _syncService;
  late final IntelligenceCacheRepository _repository;

  final state = IntelligenceSyncState.updateRequired.obs;
  final lastSyncedAt = Rx<DateTime?>(null);
  final bundleVersion = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    _syncService = GetIt.I<IntelligenceCacheSyncService>();
    _repository = GetIt.I<IntelligenceCacheRepository>();
    _refreshState();
  }

  /// No scheduler calls this yet — the periodic background trigger (#105/
  /// #108) is out of this issue's scope; this is the connection point for
  /// whichever future trigger owns that cadence. The sync cadence itself
  /// is throttled by [PerformanceController.effectiveTier] (Issue #110)
  /// so low-end hardware / Power Saver Mode sync less often.
  Future<void> sync(Map<String, IntelligenceBundle> bundles) async {
    state.value = IntelligenceSyncState.syncing;
    final interval = ScaleIntervalForPerformanceTier.call(
      ShouldRefreshIntelligenceCache.interval,
      Get.find<PerformanceController>().effectiveTier,
    );
    await _syncService.syncIfDue(bundles, interval: interval);
    _refreshState();
  }

  void _refreshState() {
    lastSyncedAt.value = _syncService.lastSyncedAt;
    bundleVersion.value = BuildIntelligenceVersionTag.call(_repository.getAll());
    state.value = DetermineIntelligenceSyncState.call(
      isSyncing: false,
      lastSyncedAt: lastSyncedAt.value,
      now: DateTime.now(),
    );
  }
}
