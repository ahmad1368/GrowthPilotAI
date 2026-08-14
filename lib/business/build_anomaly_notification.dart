import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/models/transaction_anomaly.dart';

/// Builds the WARNING/HIGH-priority alert (Issue #74) that
/// [DispatchNotificationUseCase] sends for a [TransactionAnomaly]; linked
/// back to the transaction via [InboxNotificationEntity.metadataRefId] so
/// the Flutter UI can deep-link to its Actionable Card.
class BuildAnomalyNotification {
  static InboxNotificationEntity call(TransactionAnomaly anomaly) {
    final reason = anomaly.type == AnomalyType.velocity
        ? 'repeated charges in a short window'
        : 'an unusual \$${anomaly.amount.toStringAsFixed(2)} charge';
    return InboxNotificationEntity(
      title: '⚠️ Unusual Activity Detected',
      body: 'We noticed $reason at ${anomaly.merchantName}.',
      dbType: InboxNotificationType.warning.index,
      dbPriority: NotificationPriority.high.index,
      metadataRefType: 'Transaction',
      metadataRefId: anomaly.transactionRefId,
      createdAt: DateTime.now(),
    );
  }
}
