import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';

/// [Issue #833] Surfaces the Offline Intelligence "update required" state
/// as a normal notification instead of a permanent top-app-bar banner.
/// Returns true if it inserted a notification (caller should setState).
class QueueIntelligenceUpdateNotification {
  static const id = 'intelligence-update-required';

  static bool call(IntelligenceSyncState state, List<AppNotification> notifications) {
    if (state != IntelligenceSyncState.updateRequired) return false;
    if (notifications.any((n) => n.id == id)) return false;

    notifications.insert(
      0,
      AppNotification(
        id: id,
        title: 'Offline intelligence update available',
        body: 'Local benchmarking data is due for a refresh.',
        footer: 'Version 1.0.8',
        date: DateTime.now(),
        type: NotificationType.info,
      ),
    );
    return true;
  }
}
