import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_broadcast_narrative.dart';
import 'package:growth_pilot_ai/core/models/broadcast_read_rate.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/emergency_broadcast_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a dispatch button, per-broadcast rows, and a summary
/// narrative (Issue #345). Purely presentational — the broadcast list
/// is owned by [EmergencyBroadcastBody].
class EmergencyBroadcastView extends StatelessWidget {
  final List<BroadcastReadRate> results;
  final VoidCallback onDispatch;
  final ValueChanged<BroadcastReadRate> onMarkRead;

  const EmergencyBroadcastView({
    super.key,
    required this.results,
    required this.onDispatch,
    required this.onMarkRead,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onDispatch,
              child: Text('+ Broadcast', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results)
          EmergencyBroadcastRow(result: result, onMarkRead: () => onMarkRead(result)),
        const SizedBox(height: 8),
        Text(BuildBroadcastNarrative.call(results)),
      ],
    );
  }
}
