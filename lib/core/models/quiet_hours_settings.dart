import 'package:flutter/foundation.dart';

/// "Quiet Hours" + daily frequency cap config (Issue #159) — times are
/// minutes-since-midnight in the device's local time, matching how
/// [IsWithinQuietHours] compares against `DateTime.now()` without any
/// timezone-conversion dependency (this offline-first client has no
/// server-stored `timezone` field to fetch, unlike the issue's NestJS spec).
@immutable
class QuietHoursSettings {
  final bool enabled;
  final int quietStartMinutes;
  final int quietEndMinutes;
  final int maxDailyAlerts;

  const QuietHoursSettings({
    required this.enabled,
    required this.quietStartMinutes,
    required this.quietEndMinutes,
    required this.maxDailyAlerts,
  });

  factory QuietHoursSettings.defaults() => const QuietHoursSettings(
        enabled: true,
        quietStartMinutes: 22 * 60,
        quietEndMinutes: 8 * 60,
        maxDailyAlerts: 5,
      );

  QuietHoursSettings copyWith({
    bool? enabled,
    int? quietStartMinutes,
    int? quietEndMinutes,
    int? maxDailyAlerts,
  }) =>
      QuietHoursSettings(
        enabled: enabled ?? this.enabled,
        quietStartMinutes: quietStartMinutes ?? this.quietStartMinutes,
        quietEndMinutes: quietEndMinutes ?? this.quietEndMinutes,
        maxDailyAlerts: maxDailyAlerts ?? this.maxDailyAlerts,
      );
}
