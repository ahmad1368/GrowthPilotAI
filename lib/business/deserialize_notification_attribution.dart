import 'dart:convert';
import 'package:growth_pilot_ai/core/models/notification_attribution.dart';

/// Decodes what [SerializeNotificationAttribution] wrote (Issue #161) —
/// no prior save, or corrupted storage, both return null (no active
/// attribution) rather than crashing.
class DeserializeNotificationAttribution {
  static NotificationAttribution? call(String? stored) {
    if (stored == null) return null;
    try {
      final map = jsonDecode(stored) as Map<String, dynamic>;
      return NotificationAttribution(
        alertId: map['alertId'] as int,
        category: map['category'] as String,
        attributedAt: DateTime.parse(map['attributedAt'] as String),
      );
    } catch (_) {
      return null;
    }
  }
}
