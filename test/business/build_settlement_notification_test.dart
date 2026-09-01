import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_settlement_notification.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';

BankingGatewayTransactionEntity _tx(GatewayTransactionStatus status) {
  final tx = BankingGatewayTransactionEntity(
    dbProvider: 0,
    merchantName: 'Alpha',
    counterpartyName: 'Beta',
    amount: 100,
    currency: 'CAD',
    convertedAmount: 100,
    exchangeRate: 1,
    feeAmount: 0,
    initiatedAt: DateTime(2026, 1, 1),
  );
  tx.status = status;
  return tx;
}

void main() {
  final now = DateTime(2026, 1, 2);

  test('a settled transaction fires a high-priority funds-cleared alert', () {
    final n = BuildSettlementNotification.call(_tx(GatewayTransactionStatus.settled), now);
    expect(n.title, 'Funds cleared');
    expect(n.priority, NotificationPriority.high);
  });

  test('a failed transaction fires a critical action-required alert', () {
    final n = BuildSettlementNotification.call(_tx(GatewayTransactionStatus.failed), now);
    expect(n.title, 'Settlement failed');
    expect(n.priority, NotificationPriority.critical);
    expect(n.isCritical, true);
  });

  test('links back to the transaction via metadata', () {
    final tx = _tx(GatewayTransactionStatus.settled);
    final n = BuildSettlementNotification.call(tx, now);
    expect(n.metadataRefType, 'Transaction');
    expect(n.metadataRefId, '${tx.id}');
  });
}
