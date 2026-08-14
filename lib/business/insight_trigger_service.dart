import 'package:growth_pilot_ai/business/build_insight_trigger_notification.dart';
import 'package:growth_pilot_ai/business/decrypt_intelligence_cache_snapshot.dart';
import 'package:growth_pilot_ai/business/dispatch_notification_usecase.dart';
import 'package:growth_pilot_ai/business/is_high_value_insight.dart';
import 'package:growth_pilot_ai/business/select_stale_insight_notifications_for_cleanup.dart';
import 'package:growth_pilot_ai/business/should_run_insight_scan.dart';
import 'package:growth_pilot_ai/business/should_send_insight_notification.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/intelligence_cache_repository.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// "Proactive Edge Intelligence" (Issue #108): scans #106's encrypted
/// local cache for a new Hidden Gem / top-5%-value item and dispatches
/// at most one alert per 12-hour cooldown, never round-tripping to a
/// backend.
class InsightTriggerService {
  final IntelligenceCacheRepository _cacheRepo;
  final InboxNotificationRepository _notificationRepo;
  final FieldCipher _cipher;
  final DispatchNotificationUseCase _dispatcher;
  DateTime? _lastScanAt;
  DateTime? _lastNotificationAt;

  InsightTriggerService(this._cacheRepo, this._notificationRepo, this._cipher, this._dispatcher);

  Future<void> scanIfDue({DateTime? now}) async {
    final at = now ?? DateTime.now();
    if (!ShouldRunInsightScan.call(_lastScanAt, at)) return;
    _lastScanAt = at;

    final history = _notificationRepo.getAll();
    _notificationRepo.removeAll(SelectStaleInsightNotificationsForCleanup.call(history, at));
    if (!ShouldSendInsightNotification.call(_lastNotificationAt, at)) return;

    final alreadyNotified =
        history.where((n) => n.metadataRefType == 'IntelligenceItem').map((n) => n.metadataRefId).toSet();

    for (final entry in _cacheRepo.getAll()) {
      if (alreadyNotified.contains(entry.itemId)) continue;
      final context = await DecryptIntelligenceCacheSnapshot.call(entry, _cipher);
      if (!IsHighValueInsight.call(context)) continue;

      final notification = BuildInsightTriggerNotification.call(entry.itemId, entry.sectorId, context);
      if (await _dispatcher.dispatch(notification, history) != null) {
        _lastNotificationAt = at;
        return;
      }
    }
  }
}
