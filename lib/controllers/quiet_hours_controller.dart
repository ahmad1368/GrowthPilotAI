import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/deserialize_quiet_hours_settings.dart';
import 'package:growth_pilot_ai/business/serialize_quiet_hours_settings.dart';
import 'package:growth_pilot_ai/business/should_deliver_notification.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/models/daily_alert_counts.dart';
import 'package:growth_pilot_ai/core/models/quiet_hours_settings.dart';
import 'package:growth_pilot_ai/core/services/daily_alert_counter_service.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Client-side "DeliveryGuardService" (Issue #159): Quiet Hours + a daily
/// per-category cap, persisted locally, no Redis/BullMQ backend needed.
class QuietHoursController extends GetxController {
  static const _settingsKey = 'quiet_hours_settings';
  final _counterService = DailyAlertCounterService();

  final settings = QuietHoursSettings.defaults().obs;
  final Rx<DailyAlertCounts> _counts = Rx(DailyAlertCounts.empty(''));

  @override
  void onInit() {
    super.onInit();
    _restore();
  }

  Future<void> _restore() async {
    final storedSettings = await SecureStorageService.readData(_settingsKey);
    settings.value = DeserializeQuietHoursSettings.call(storedSettings);
    _counts.value = await _counterService.load();
  }

  bool shouldDeliver(NotificationCategory category) {
    final now = DateTime.now();
    return ShouldDeliverNotification.call(
      category: category,
      nowMinutes: now.hour * 60 + now.minute,
      settings: settings.value,
      countSoFarToday: _counts.value.countFor(category),
    );
  }

  Future<void> recordDelivery(NotificationCategory category) async {
    _counts.value = await _counterService.increment(_counts.value, category);
  }

  Future<void> updateSettings(QuietHoursSettings next) async {
    settings.value = next;
    await SecureStorageService.writeData(_settingsKey, SerializeQuietHoursSettings.call(next));
  }
}
