import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/select_stale_insight_notifications_for_cleanup.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';

InboxNotificationEntity _entry({
  required bool isRead,
  required DateTime createdAt,
  String? metadataRefType = 'IntelligenceItem',
}) {
  return InboxNotificationEntity(
    title: 'Market Insight',
    body: 'body',
    metadataRefType: metadataRefType,
    metadataRefId: 'item-1',
    createdAt: createdAt,
    isRead: isRead,
  );
}

void main() {
  group('SelectStaleInsightNotificationsForCleanup', () {
    final now = DateTime(2026, 8, 13);

    test('selects a read entry older than the 14-day retention window', () {
      final entry = _entry(isRead: true, createdAt: now.subtract(const Duration(days: 15)));
      expect(SelectStaleInsightNotificationsForCleanup.call([entry], now), [entry]);
    });

    test('keeps an unread entry regardless of age', () {
      final entry = _entry(isRead: false, createdAt: now.subtract(const Duration(days: 30)));
      expect(SelectStaleInsightNotificationsForCleanup.call([entry], now), isEmpty);
    });

    test('keeps a read entry within the retention window', () {
      final entry = _entry(isRead: true, createdAt: now.subtract(const Duration(days: 1)));
      expect(SelectStaleInsightNotificationsForCleanup.call([entry], now), isEmpty);
    });

    test('ignores notifications from a different feature', () {
      final entry = _entry(
        isRead: true,
        createdAt: now.subtract(const Duration(days: 30)),
        metadataRefType: 'Transaction',
      );
      expect(SelectStaleInsightNotificationsForCleanup.call([entry], now), isEmpty);
    });
  });
}
