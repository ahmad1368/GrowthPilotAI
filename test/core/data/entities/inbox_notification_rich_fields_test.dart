import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';

void main() {
  group('InboxNotificationEntity rich fields (Issue #160)', () {
    test('default to null so older/plain builders keep compiling unchanged', () {
      final notification = InboxNotificationEntity(
        title: 'Plain alert',
        body: 'No rich content',
        createdAt: DateTime(2026, 1, 1),
      );

      expect(notification.imageUrl, isNull);
      expect(notification.actionLabel, isNull);
      expect(notification.deepLinkRoute, isNull);
    });

    test('are stored as given when a builder opts into rich content', () {
      final notification = InboxNotificationEntity(
        title: 'Price Drop Alert!',
        body: 'Fresh Tomatoes are now \$2.99/lb',
        createdAt: DateTime(2026, 1, 1),
        imageUrl: 'https://cdn.example.ca/products/tomatoes.jpg',
        actionLabel: 'View Product',
        deepLinkRoute: '/inbox',
      );

      expect(notification.imageUrl, 'https://cdn.example.ca/products/tomatoes.jpg');
      expect(notification.actionLabel, 'View Product');
      expect(notification.deepLinkRoute, '/inbox');
    });
  });
}
