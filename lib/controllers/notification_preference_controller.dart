import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/deserialize_notification_preferences.dart';
import 'package:growth_pilot_ai/business/serialize_notification_preferences.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/enum/notification_channel.dart';
import 'package:growth_pilot_ai/core/models/notification_preferences.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Owns the "Unified Notification Preference Center" (Issue #158) — the
/// per-category/per-channel toggle matrix, persisted locally. Cross-device
/// real-time sync (the issue's NestJS SSOT + WebSocket broadcast) has no
/// backend in this offline-first client; this is the local half a future
/// sync layer would read from and write to.
class NotificationPreferenceController extends GetxController {
  static const _storageKey = 'notification_preferences';

  final preferences = NotificationPreferences.allEnabled().obs;

  @override
  void onInit() {
    super.onInit();
    _restore();
  }

  Future<void> _restore() async {
    final stored = await SecureStorageService.readData(_storageKey);
    preferences.value = DeserializeNotificationPreferences.call(stored);
  }

  Future<void> toggle(NotificationCategory category, NotificationChannel channel) async {
    preferences.value = preferences.value.toggled(category, channel);
    await SecureStorageService.writeData(
        _storageKey, SerializeNotificationPreferences.call(preferences.value));
  }
}
