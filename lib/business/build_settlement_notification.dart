import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

/// Builds the Inbox alert fired when a settlement reaches a notable
/// milestone (Issue #426, acceptance criterion 3) — this app has no
/// push/webhook backend, so the alert surfaces in the Inbox (#71)
/// instead of a real push notification.
class BuildSettlementNotification {
  static InboxNotificationEntity call(BankingGatewayTransactionEntity transaction, DateTime now) {
    final (title, body, type, priority) = switch (transaction.status) {
      GatewayTransactionStatus.settled => (
          'Funds cleared',
          '${transaction.currency} ${transaction.amount.toStringAsFixed(2)} from '
              '${transaction.counterpartyName} has settled.',
          InboxNotificationType.info,
          NotificationPriority.high,
        ),
      GatewayTransactionStatus.refunded => (
          'Transaction refunded',
          '${transaction.currency} ${transaction.amount.toStringAsFixed(2)} to '
              '${transaction.counterpartyName} was refunded.',
          InboxNotificationType.warning,
          NotificationPriority.normal,
        ),
      GatewayTransactionStatus.failed => (
          'Settlement failed',
          'The transaction with ${transaction.counterpartyName} failed and needs attention.',
          InboxNotificationType.actionRequired,
          NotificationPriority.critical,
        ),
      _ => (
          'Settlement update',
          "${transaction.counterpartyName}'s transaction is now ${transaction.status.name}.",
          InboxNotificationType.info,
          NotificationPriority.normal,
        ),
    };
    return InboxNotificationEntity(
      title: title,
      body: body,
      dbType: type.index,
      dbPriority: priority.index,
      metadataRefType: 'Transaction',
      metadataRefId: '${transaction.id}',
      createdAt: now,
    );
  }
}
