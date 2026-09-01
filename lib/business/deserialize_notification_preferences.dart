import 'dart:convert';
import 'package:growth_pilot_ai/core/models/notification_preferences.dart';

/// Decodes what [SerializeNotificationPreferences] wrote (Issue #158) —
/// no prior save, or corrupted storage, both fall back to "everything
/// on" rather than silently muting the user.
class DeserializeNotificationPreferences {
  static NotificationPreferences call(String? stored) {
    if (stored == null) return NotificationPreferences.allEnabled();
    try {
      final decoded = jsonDecode(stored) as Map<String, dynamic>;
      return NotificationPreferences.fromMap(decoded.map((k, v) => MapEntry(k, v as bool)));
    } catch (_) {
      return NotificationPreferences.allEnabled();
    }
  }
}
