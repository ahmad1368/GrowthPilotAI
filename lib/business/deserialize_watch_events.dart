import 'dart:convert';
import 'package:growth_pilot_ai/core/models/watch_event.dart';

/// Decodes what [SerializeWatchEvents] wrote (Issue #163) — no prior
/// history, or corrupted storage, both return an empty list.
class DeserializeWatchEvents {
  static List<WatchEvent> call(String? stored) {
    if (stored == null) return const [];
    try {
      final list = jsonDecode(stored) as List;
      return list
          .map((e) => WatchEvent(
              videoId: (e as Map<String, dynamic>)['videoId'] as String,
              openedAt: DateTime.parse(e['openedAt'] as String)))
          .toList();
    } catch (_) {
      return const [];
    }
  }
}
