import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/deserialize_notification_attribution.dart';
import 'package:growth_pilot_ai/business/serialize_notification_attribution.dart';
import 'package:growth_pilot_ai/core/models/notification_attribution.dart';

void main() {
  group('SerializeNotificationAttribution / DeserializeNotificationAttribution', () {
    test('round-trips an attribution', () {
      final original = NotificationAttribution(
        alertId: 42,
        category: 'PRICE_DROP',
        attributedAt: DateTime(2026, 1, 1, 12),
      );

      final restored = DeserializeNotificationAttribution.call(SerializeNotificationAttribution.call(original));

      expect(restored?.alertId, 42);
      expect(restored?.category, 'PRICE_DROP');
      expect(restored?.attributedAt, DateTime(2026, 1, 1, 12));
    });

    test('null storage (no prior tap) returns null, not a default attribution', () {
      expect(DeserializeNotificationAttribution.call(null), isNull);
    });

    test('corrupted storage returns null instead of crashing', () {
      expect(DeserializeNotificationAttribution.call('not valid json'), isNull);
    });
  });
}
