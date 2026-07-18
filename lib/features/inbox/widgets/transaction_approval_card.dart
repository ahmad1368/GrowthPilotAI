import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a transaction-approval ACTION_CARD inline in an Inbox row (Issue
/// #73): "Confirm" while PENDING, a synced badge once COMPLETED.
/// [isProcessing] disables the button and shows a spinner so a double-tap
/// can't submit the approval twice.
class TransactionApprovalCard extends StatelessWidget {
  final ActionCardData data;
  final bool isProcessing;
  final VoidCallback onApprove;

  const TransactionApprovalCard({
    super.key,
    required this.data,
    required this.isProcessing,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    if (!data.isPending) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, color: Colors.green, size: 16),
          SizedBox(width: 4),
          Text('Synced to QBO', style: TextStyle(fontSize: 12, color: Colors.green)),
        ],
      );
    }
    return FittedBox(
      alignment: Alignment.centerLeft,
      fit: BoxFit.scaleDown,
      child: ShadButton.outline(
        enabled: !isProcessing,
        size: ShadButtonSize.sm,
        leading: isProcessing
            ? const SizedBox(
                width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2))
            : null,
        onPressed: onApprove,
        child: Text(isProcessing
            ? 'Syncing...'
            : 'Confirm \$${data.amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
