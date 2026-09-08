import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/queue_intelligence_update_notification.dart';
import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';

void main() {
  group('QueueIntelligenceUpdateNotification', () {
    test('does nothing when state is not updateRequired', () {
      final notifications = <AppNotification>[];
      final queued =
          QueueIntelligenceUpdateNotification.call(IntelligenceSyncState.localMode, notifications);

      expect(queued, isFalse);
      expect(notifications, isEmpty);
    });

    test('inserts a notification at the front when update is required', () {
      final notifications = <AppNotification>[
        AppNotification(id: 'x', title: 'x', body: 'x', footer: 'x', date: DateTime.now())
      ];
      final queued =
          QueueIntelligenceUpdateNotification.call(IntelligenceSyncState.updateRequired, notifications);

      expect(queued, isTrue);
      expect(notifications.length, 2);
      expect(notifications.first.id, QueueIntelligenceUpdateNotification.id);
    });

    test('does not insert a duplicate if already queued', () {
      final notifications = <AppNotification>[];
      QueueIntelligenceUpdateNotification.call(IntelligenceSyncState.updateRequired, notifications);
      final queuedAgain =
          QueueIntelligenceUpdateNotification.call(IntelligenceSyncState.updateRequired, notifications);

      expect(queuedAgain, isFalse);
      expect(notifications.length, 1);
    });
  });
}
