import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/deserialize_watch_events.dart';
import 'package:growth_pilot_ai/business/serialize_watch_events.dart';
import 'package:growth_pilot_ai/core/models/watch_event.dart';

void main() {
  group('SerializeWatchEvents / DeserializeWatchEvents', () {
    test('round-trips a watch history', () {
      final original = [
        WatchEvent(videoId: 'a', openedAt: DateTime(2026, 1, 1, 12)),
        WatchEvent(videoId: 'b', openedAt: DateTime(2026, 1, 2, 9)),
      ];

      final restored = DeserializeWatchEvents.call(SerializeWatchEvents.call(original));

      expect(restored.length, 2);
      expect(restored[0].videoId, 'a');
      expect(restored[0].openedAt, DateTime(2026, 1, 1, 12));
      expect(restored[1].videoId, 'b');
    });

    test('null storage (no prior history) returns an empty list', () {
      expect(DeserializeWatchEvents.call(null), isEmpty);
    });

    test('corrupted storage returns an empty list instead of crashing', () {
      expect(DeserializeWatchEvents.call('not valid json'), isEmpty);
    });
  });
}
