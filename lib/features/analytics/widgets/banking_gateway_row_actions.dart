import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Status-specific action area for one transaction (Issue #421;
/// fallback retry added for Issue #422, acceptance criterion 3) —
/// split out of [BankingGatewayRow] to stay under the file line cap.
class BankingGatewayRowActions extends StatelessWidget {
  final BankingGatewayTransactionEntity transaction;
  final VoidCallback onCapture;
  final VoidCallback onSettle;
  final VoidCallback onFail;
  final VoidCallback onRefund;
  final VoidCallback onRetryWithFallback;

  const BankingGatewayRowActions({
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
    switch (transaction.status) {
      case GatewayTransactionStatus.authorized:
        return ShadButton.ghost(onPressed: onCapture, child: const Text('Capture'));
      case GatewayTransactionStatus.captured:
        return Row(children: [
          ShadButton.ghost(onPressed: onSettle, child: const Text('Settle')),
          ShadButton.ghost(onPressed: onFail, child: const Text('Fail')),
        ]);
      case GatewayTransactionStatus.settled:
        return ShadButton.ghost(onPressed: onRefund, child: const Text('Refund'));
      case GatewayTransactionStatus.failed:
        return ShadButton.ghost(onPressed: onRetryWithFallback, child: const Text('Retry via Fallback'));
      case GatewayTransactionStatus.refunded:
        return const SizedBox.shrink();
    }
  }
}
