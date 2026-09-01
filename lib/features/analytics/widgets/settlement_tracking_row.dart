import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_settlement_timeline.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_alert_banner.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_timeline_stepper.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_history_panel.dart';

/// One P2P settlement's timeline, alert state, and admin history
/// drill-down (Issue #426, acceptance criteria 1-2 and 5).
class SettlementTrackingRow extends StatelessWidget {
  final BankingGatewayTransactionEntity transaction;
  final EscrowAccountEntity? escrow;
  final List<AuditLogEntity> history;

  const SettlementTrackingRow({
    super.key,
    required this.transaction,
    required this.escrow,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    final steps = BuildSettlementTimeline.call(transaction, escrow);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${transaction.merchantName} → ${transaction.counterpartyName}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          SettlementTimelineStepper(steps: steps),
          SettlementAlertBanner(status: transaction.status),
          SettlementTrackingHistoryPanel(history: history),
        ],
      ),
    );
  }
}
