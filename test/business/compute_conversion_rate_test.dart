import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_conversion_rate.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/notification_conversion_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/conversion_status.dart';

InboxNotificationEntity _alert(int id, String? category) => InboxNotificationEntity(
      id: id,
      title: 't',
      body: 'b',
      metadataRefType: category,
      createdAt: DateTime(2026, 1, 1),
    );

NotificationConversionEventEntity _event(int alertId, String category, ConversionStatus status) =>
    NotificationConversionEventEntity(
      alertId: alertId,
      category: category,
      dbStatus: status.index,
      occurredAt: DateTime(2026, 1, 1),
    );

void main() {
  group('ComputeConversionRate', () {
    test('0 sent alerts in a category is 0%, not a division-by-zero crash', () {
      final rate = ComputeConversionRate.call(sentAlerts: const [], events: const [], category: 'PRICE_DROP');
      expect(rate, 0);
    });

    test('counts a converted alert once even with duplicate opened/converted events', () {
      final sent = [_alert(1, 'PRICE_DROP'), _alert(2, 'PRICE_DROP')];
      final events = [
        _event(1, 'PRICE_DROP', ConversionStatus.opened),
        _event(1, 'PRICE_DROP', ConversionStatus.dealClosed),
      ];

      final rate = ComputeConversionRate.call(sentAlerts: sent, events: events, category: 'PRICE_DROP');
      expect(rate, 50);
    });

    test('ignores conversions attributed to a different category', () {
      final sent = [_alert(1, 'PRICE_DROP')];
      final events = [_event(1, 'NEW_VENDOR', ConversionStatus.dealClosed)];

      final rate = ComputeConversionRate.call(sentAlerts: sent, events: events, category: 'PRICE_DROP');
      expect(rate, 0);
    });

    test('a merely-opened alert (no dealClosed) does not count as converted', () {
      final sent = [_alert(1, 'PRICE_DROP')];
      final events = [_event(1, 'PRICE_DROP', ConversionStatus.chatStarted)];

      final rate = ComputeConversionRate.call(sentAlerts: sent, events: events, category: 'PRICE_DROP');
      expect(rate, 0);
    });
  });
}
