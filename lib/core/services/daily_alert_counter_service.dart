import 'package:growth_pilot_ai/business/deserialize_daily_alert_counts.dart';
import 'package:growth_pilot_ai/business/format_date_key.dart';
import 'package:growth_pilot_ai/business/serialize_daily_alert_counts.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/models/daily_alert_counts.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Persists [DailyAlertCounts] (Issue #159) — the local stand-in for the
/// issue's Redis `notification_count:{userId}:{category}` rolling
/// 24-hour counter.
class DailyAlertCounterService {
  static const _storageKey = 'daily_alert_counts';

  Future<DailyAlertCounts> load() async {
    final stored = await SecureStorageService.readData(_storageKey);
    return DeserializeDailyAlertCounts.call(stored, FormatDateKey.call(DateTime.now()));
  }

  Future<DailyAlertCounts> increment(
      DailyAlertCounts current, NotificationCategory category) async {
    final next = current.incremented(category, FormatDateKey.call(DateTime.now()));
    await SecureStorageService.writeData(_storageKey, SerializeDailyAlertCounts.call(next));
    return next;
  }
}
