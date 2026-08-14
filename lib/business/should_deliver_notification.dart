import 'package:growth_pilot_ai/business/is_within_quiet_hours.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/models/quiet_hours_settings.dart';

/// The client-side "DeliveryGuardService" gate (Issue #159) — combines
/// Quiet Hours and the daily frequency cap. [NotificationCategory.orders]
/// is this app's closest match to the issue's "Order Confirmations /
/// Direct Messages" transactional examples, so it always bypasses both
/// filters (AC: "Transactional messages bypass these filters").
class ShouldDeliverNotification {
  static bool call({
    required NotificationCategory category,
    required int nowMinutes,
    required QuietHoursSettings settings,
    required int countSoFarToday,
  }) {
    if (category == NotificationCategory.orders) return true;

    if (settings.enabled &&
        IsWithinQuietHours.call(nowMinutes, settings.quietStartMinutes, settings.quietEndMinutes)) {
      return false;
    }

    return countSoFarToday < settings.maxDailyAlerts;
  }
}
