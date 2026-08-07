import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_gateway_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_disclaimer.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the simulation disclaimer, a new-transaction button, every
/// transaction card, and a narrative (Issue #421). Purely
/// presentational.
class BankingGatewayView extends StatelessWidget {
  final List<BankingGatewayTransactionEntity> transactions;
  final VoidCallback onCreate;
  final void Function(BankingGatewayTransactionEntity) onCapture;
  final void Function(BankingGatewayTransactionEntity) onSettle;
  final void Function(BankingGatewayTransactionEntity) onFail;
  final void Function(BankingGatewayTransactionEntity) onRefund;
  final void Function(BankingGatewayTransactionEntity) onRetryWithFallback;

  const BankingGatewayView({
    super.key,
    required this.transactions,
    required this.onCreate,
    required this.onCapture,
    required this.onSettle,
    required this.onFail,
    required this.onRefund,
    required this.onRetryWithFallback,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BankingGatewayDisclaimer(),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ShadButton.outline(
              onPressed: onCreate, child: Text('+ New Transaction', style: TextStyle(color: fg))),
        ]),
        for (final transaction in transactions)
          BankingGatewayRow(
            transaction: transaction,
            onCapture: () => onCapture(transaction),
            onSettle: () => onSettle(transaction),
            onFail: () => onFail(transaction),
            onRefund: () => onRefund(transaction),
            onRetryWithFallback: () => onRetryWithFallback(transaction),
          ),
        const SizedBox(height: 8),
        Text(BuildGatewayNarrative.call(transactions)),
      ],
    );
  }
}
