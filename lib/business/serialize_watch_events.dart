import 'dart:convert';
import 'package:growth_pilot_ai/core/models/watch_event.dart';

/// Encodes the watch-event history for [SecureStorageService] (Issue #163).
class SerializeWatchEvents {
  static String call(List<WatchEvent> events) => jsonEncode(events
      .map((e) => {'videoId': e.videoId, 'openedAt': e.openedAt.toIso8601String()})
      .toList());
}
