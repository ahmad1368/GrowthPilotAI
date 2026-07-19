import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_anomaly_notification.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/models/transaction_anomaly.dart';

void main() {
  test('builds a HIGH-priority WARNING linked back to the transaction', () {
    const anomaly = TransactionAnomaly(
      type: AnomalyType.zScore,
      transactionRefId: 'plaid-zenith-9012',
      merchantName: 'Zenith Office Supplies',
      amount: 2400,
      zScoreValue: 4.8,
    );

    final notification = BuildAnomalyNotification.call(anomaly);

    expect(notification.type, InboxNotificationType.warning);
    expect(notification.priority, NotificationPriority.high);
    expect(notification.metadataRefType, 'Transaction');
    expect(notification.metadataRefId, 'plaid-zenith-9012');
    expect(notification.body, contains('Zenith Office Supplies'));
    expect(notification.body, contains('2400.00'));
  });

  test('describes a velocity anomaly without a dollar figure', () {
    const anomaly = TransactionAnomaly(
      type: AnomalyType.velocity,
      transactionRefId: 'plaid-ubereats-1',
      merchantName: 'Uber Eats',
      amount: 25,
    );

    final notification = BuildAnomalyNotification.call(anomaly);

    expect(notification.body, contains('repeated charges'));
    expect(notification.body, contains('Uber Eats'));
  });
}
