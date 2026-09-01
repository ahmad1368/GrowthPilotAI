import 'dart:convert';
import 'package:growth_pilot_ai/core/models/notification_preferences.dart';

/// Encodes [NotificationPreferences] for [SecureStorageService] (Issue
/// #158) — a plain JSON map of "category.channel" -> bool.
class SerializeNotificationPreferences {
  static String call(NotificationPreferences prefs) => jsonEncode(prefs.toMap());
}
