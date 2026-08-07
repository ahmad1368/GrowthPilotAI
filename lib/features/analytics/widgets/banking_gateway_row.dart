import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_row_actions.dart';

/// One gateway transaction card (Issue #421) — header info and
/// status-specific actions from [BankingGatewayRowActions].
class BankingGatewayRow extends StatelessWidget {
  final BankingGatewayTransactionEntity transaction;
  final VoidCallback onCapture;
  final VoidCallback onSettle;
  final VoidCallback onFail;
  final VoidCallback onRefund;
  final VoidCallback onRetryWithFallback;

  const BankingGatewayRow({
    super.key,
    required this.transaction,
    required this.onCapture,
    required this.onSettle,
    required this.onFail,
    required this.onRefund,
    required this.onRetryWithFallback,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${transaction.provider.name} — ${transaction.merchantName} → ${transaction.counterpartyName}'),
          Text(
              '${transaction.currency} ${transaction.amount.toStringAsFixed(2)} '
              '(CAD ${transaction.convertedAmount.toStringAsFixed(2)}, fee \$${transaction.feeAmount.toStringAsFixed(2)}) '
              '— ${transaction.status.name}',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          BankingGatewayRowActions(
            transaction: transaction,
            onCapture: onCapture,
            onSettle: onSettle,
            onFail: onFail,
            onRefund: onRefund,
            onRetryWithFallback: onRetryWithFallback,
          ),
        ],
      ),
    );
  }
}
