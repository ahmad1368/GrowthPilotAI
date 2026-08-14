import 'dart:convert';
import 'package:growth_pilot_ai/core/models/quiet_hours_settings.dart';

/// Decodes what [SerializeQuietHoursSettings] wrote (Issue #159) — no
/// prior save, or corrupted storage, both fall back to the issue's own
/// "10PM-8AM, max 5/day" example defaults.
class DeserializeQuietHoursSettings {
  static QuietHoursSettings call(String? stored) {
    if (stored == null) return QuietHoursSettings.defaults();
    try {
      final map = jsonDecode(stored) as Map<String, dynamic>;
      return QuietHoursSettings(
        enabled: map['enabled'] as bool,
        quietStartMinutes: map['quietStartMinutes'] as int,
        quietEndMinutes: map['quietEndMinutes'] as int,
        maxDailyAlerts: map['maxDailyAlerts'] as int,
      );
    } catch (_) {
      return QuietHoursSettings.defaults();
    }
  }
}
