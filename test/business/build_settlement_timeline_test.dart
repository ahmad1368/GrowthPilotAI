import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_settlement_timeline.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

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
  test('an authorized transaction is only on the first step', () {
    final steps = BuildSettlementTimeline.call(_tx(GatewayTransactionStatus.authorized), null);
    expect(steps[0].isComplete, true);
    expect(steps[0].isCurrent, true);
    expect(steps[1].isComplete, false);
  });

  test('a captured transaction with escrow is currently holding', () {
    final escrow = EscrowAccountEntity(
      buyerName: 'Beta',
      sellerName: 'Alpha',
      itemDescription: 'gateway-tx-1',
      amount: 100,
      createdAt: DateTime(2026, 1, 1),
    );
    final steps = BuildSettlementTimeline.call(_tx(GatewayTransactionStatus.captured), escrow);
    expect(steps[1].isApplicable, true);
    expect(steps[1].isCurrent, true);
    expect(steps[1].isComplete, false);
  });

  test('a settled transaction with released escrow completes all steps', () {
    final escrow = EscrowAccountEntity(
      buyerName: 'Beta',
      sellerName: 'Alpha',
      itemDescription: 'gateway-tx-1',
      amount: 100,
      dbStatus: EscrowStatus.released.index,
      createdAt: DateTime(2026, 1, 1),
    );
    final steps = BuildSettlementTimeline.call(_tx(GatewayTransactionStatus.settled), escrow);
    expect(steps.every((s) => s.isComplete), true);
  });

  test('a settled transaction with no escrow confirms delivery by settlement alone', () {
    final steps = BuildSettlementTimeline.call(_tx(GatewayTransactionStatus.settled), null);
    expect(steps[1].isApplicable, false);
    expect(steps[3].isComplete, true);
  });
}
