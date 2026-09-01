import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a Smart Recommendation ACTION_CARD inline in an Inbox row (Issue
/// #75): a primary CTA (e.g. "Review Subscription") plus "Dismiss"/"Snooze"
/// while PENDING, a status label once resolved. [isProcessing] disables all
/// three buttons so a double-tap can't race the status update.
class SmartRecommendationCard extends StatelessWidget {
  final ActionCardData data;
  final bool isProcessing;
  final VoidCallback onAct;
  final VoidCallback onDismiss;
  final VoidCallback onSnooze;

  const SmartRecommendationCard({
    super.key,
    required this.data,
    required this.isProcessing,
    required this.onAct,
    required this.onDismiss,
    required this.onSnooze,
  });

  @override
  Widget build(BuildContext context) {
    if (!data.isPending) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lightbulb_outline_rounded, size: 16),
          const SizedBox(width: 4),
          Text(data.status.name, style: const TextStyle(fontSize: 12)),
        ],
      );
    }
    return FittedBox(
      alignment: Alignment.centerLeft,
      fit: BoxFit.scaleDown,
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          ShadButton(
            enabled: !isProcessing,
            size: ShadButtonSize.sm,
            onPressed: onAct,
            child: Text(data.actionLabel ?? 'View'),
          ),
          ShadButton.ghost(
            enabled: !isProcessing,
            size: ShadButtonSize.sm,
            onPressed: onSnooze,
            child: const Text('Snooze'),
          ),
          ShadButton.ghost(
            enabled: !isProcessing,
            size: ShadButtonSize.sm,
            onPressed: onDismiss,
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }
}
