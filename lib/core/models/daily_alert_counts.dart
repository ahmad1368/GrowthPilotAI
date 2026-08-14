import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';

/// Rolling per-category alert count for one calendar day, local time
/// (Issue #159's client-side stand-in for the issue's Redis
/// `notification_count:{userId}:{category}` counter). [incremented]
/// resets to a fresh count whenever [today] no longer matches the
/// stored [date], so a session left open past midnight self-corrects.
@immutable
class DailyAlertCounts {
  final String date;
  final Map<NotificationCategory, int> _counts;

  const DailyAlertCounts._(this.date, this._counts);

  factory DailyAlertCounts.empty(String today) =>
      DailyAlertCounts._(today, const {});

  factory DailyAlertCounts.restore(String date, Map<NotificationCategory, int> counts) =>
      DailyAlertCounts._(date, counts);

  int countFor(NotificationCategory category) => _counts[category] ?? 0;

  DailyAlertCounts incremented(NotificationCategory category, String today) {
    final base = date == today ? _counts : const <NotificationCategory, int>{};
    final next = Map<NotificationCategory, int>.of(base);
    next[category] = (next[category] ?? 0) + 1;
    return DailyAlertCounts._(today, next);
  }

  Map<NotificationCategory, int> get counts => Map.unmodifiable(_counts);
}
