import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/notification_category.dart';
import 'package:growth_pilot_ai/core/enum/notification_channel.dart';

/// Per-category/per-channel on-off matrix for the Notification
/// Preference Center (Issue #158) — immutable so [toggled] can be used
/// directly as a GetX `.obs` update. Missing keys default to enabled,
/// so a freshly-added category/channel doesn't silently mute existing
/// users who saved preferences before it existed.
@immutable
class NotificationPreferences {
  final Map<String, bool> _enabled;

  const NotificationPreferences._(this._enabled);

  factory NotificationPreferences.allEnabled() => const NotificationPreferences._({});

  factory NotificationPreferences.fromMap(Map<String, bool> map) =>
      NotificationPreferences._(Map.of(map));

  static String _key(NotificationCategory category, NotificationChannel channel) =>
      '${category.name}.${channel.name}';

  bool isEnabled(NotificationCategory category, NotificationChannel channel) =>
      _enabled[_key(category, channel)] ?? true;

  NotificationPreferences toggled(NotificationCategory category, NotificationChannel channel) {
    final next = Map<String, bool>.of(_enabled);
    next[_key(category, channel)] = !isEnabled(category, channel);
    return NotificationPreferences._(next);
  }

  Map<String, bool> toMap() => Map.unmodifiable(_enabled);
}
