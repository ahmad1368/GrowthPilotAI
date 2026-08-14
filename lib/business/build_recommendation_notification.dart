import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/models/smart_recommendation.dart';

/// Builds the low-priority "Smart Message" alert (Issue #75) that
/// [DispatchNotificationUseCase] would send for a [SmartRecommendation] —
/// informational, not urgent, unlike the Issue #74 anomaly warning.
class BuildRecommendationNotification {
  static InboxNotificationEntity call(SmartRecommendation recommendation) {
    return InboxNotificationEntity(
      title: recommendation.title,
      body: recommendation.body,
      dbType: InboxNotificationType.info.index,
      dbPriority: NotificationPriority.low.index,
      metadataRefType: 'Recommendation',
      metadataRefId: recommendation.metadataRefId,
      createdAt: DateTime.now(),
    );
  }
}
