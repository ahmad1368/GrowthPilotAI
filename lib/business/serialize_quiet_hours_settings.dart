import 'dart:convert';
import 'package:growth_pilot_ai/core/models/quiet_hours_settings.dart';

/// Encodes [QuietHoursSettings] for [SecureStorageService] (Issue #159).
class SerializeQuietHoursSettings {
  static String call(QuietHoursSettings settings) => jsonEncode({
        'enabled': settings.enabled,
        'quietStartMinutes': settings.quietStartMinutes,
        'quietEndMinutes': settings.quietEndMinutes,
        'maxDailyAlerts': settings.maxDailyAlerts,
      });
}
