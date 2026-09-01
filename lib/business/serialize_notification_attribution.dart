import 'dart:convert';
import 'package:growth_pilot_ai/core/models/notification_attribution.dart';

/// Encodes [NotificationAttribution] for [SecureStorageService] (Issue #161).
class SerializeNotificationAttribution {
  static String call(NotificationAttribution attribution) => jsonEncode({
        'alertId': attribution.alertId,
        'category': attribution.category,
        'attributedAt': attribution.attributedAt.toIso8601String(),
      });
}
