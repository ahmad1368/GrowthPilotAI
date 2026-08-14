import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_recommendation_notification.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';
import 'package:growth_pilot_ai/core/models/smart_recommendation.dart';

void main() {
  test('builds a low-priority info notification', () {
    const recommendation = SmartRecommendation(
      type: RecommendationType.cashReserve,
      title: 'Potential Savings Found',
      body: 'Consider moving excess cash to savings.',
      actionLabel: 'View Cash Flow',
    );

    final notification = BuildRecommendationNotification.call(recommendation);

    expect(notification.title, 'Potential Savings Found');
    expect(notification.dbType, InboxNotificationType.info.index);
    expect(notification.dbPriority, NotificationPriority.low.index);
    expect(notification.metadataRefType, 'Recommendation');
  });
}
