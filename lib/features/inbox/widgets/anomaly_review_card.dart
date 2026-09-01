import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders an anomaly-review ACTION_CARD inline in an Inbox row (Issue #74):
/// "Ignore for this Merchant" while PENDING, a dismissed label once
/// IGNORED. [isProcessing] disables the button so a double-tap can't
/// suppress the merchant twice.
class AnomalyReviewCard extends StatelessWidget {
  final ActionCardData data;
  final bool isProcessing;
  final VoidCallback onIgnore;

  const AnomalyReviewCard({
    super.key,
    required this.data,
    required this.isProcessing,
    required this.onIgnore,
  });

  @override
  Widget build(BuildContext context) {
    if (!data.isPending) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.visibility_off_rounded, size: 16),
          SizedBox(width: 4),
          Text('Dismissed', style: TextStyle(fontSize: 12)),
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
            : const Icon(Icons.warning_amber_rounded, size: 14),
        onPressed: onIgnore,
        child: Text(isProcessing
            ? 'Updating...'
            : 'Ignore ${data.merchantName ?? "merchant"}'),
      ),
    );
  }
}
