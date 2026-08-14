import 'dart:convert';
import 'package:growth_pilot_ai/core/models/daily_alert_counts.dart';

/// Encodes [DailyAlertCounts] for [SecureStorageService] (Issue #159).
class SerializeDailyAlertCounts {
  static String call(DailyAlertCounts counts) => jsonEncode({
        'date': counts.date,
        'counts': counts.counts.map((k, v) => MapEntry(k.name, v)),
      });
}
