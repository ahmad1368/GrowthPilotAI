import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/broadcast_read_rate.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One dispatched broadcast's delivery/read status row (Issue #345,
/// acceptance criterion 3). "+1 Read" logs another reported read as
/// merchant acknowledgements come in.
class EmergencyBroadcastRow extends StatelessWidget {
  final BroadcastReadRate result;
  final VoidCallback onMarkRead;

  const EmergencyBroadcastRow({super.key, required this.result, required this.onMarkRead});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final canMarkMore = result.readCount < result.recipientCount;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${result.targetNeighborhoods}: ${result.messageBody}',
              overflow: TextOverflow.ellipsis),
          Row(
            children: [
              Text('${result.readCount}/${result.recipientCount} read '
                  '(${result.readRatePercent.toStringAsFixed(1)}%)',
                  style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.7))),
              const SizedBox(width: 8),
              if (canMarkMore)
                ShadButton.ghost(onPressed: onMarkRead, child: const Text('+1 Read')),
            ],
          ),
        ],
      ),
    );
  }
}
