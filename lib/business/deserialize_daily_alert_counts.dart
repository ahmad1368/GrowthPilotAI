import 'dart:convert';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/models/daily_alert_counts.dart';

/// Decodes what [SerializeDailyAlertCounts] wrote (Issue #159) — a stale
/// (yesterday-or-older) count, a missing save, or corrupted storage all
/// fall back to a fresh, empty count for [today] rather than carrying
/// over a stale cap.
class DeserializeDailyAlertCounts {
  static DailyAlertCounts call(String? stored, String today) {
    if (stored == null) return DailyAlertCounts.empty(today);
    try {
      final map = jsonDecode(stored) as Map<String, dynamic>;
      final date = map['date'] as String;
      if (date != today) return DailyAlertCounts.empty(today);

      final counts = (map['counts'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(NotificationCategory.values.byName(k), v as int));
      return DailyAlertCounts.restore(date, counts);
    } catch (_) {
      return DailyAlertCounts.empty(today);
    }
  }
}
