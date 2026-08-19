import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/export_event_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One row on the "Export History" screen (Issue #253) — filename,
/// format, timestamp, and a re-share action disabled once the local
/// 48h retention window has elapsed (or bytes were never captured).
class ExportHistoryRow extends StatelessWidget {
  const ExportHistoryRow({
    super.key,
    required this.event,
    required this.isExpired,
    required this.onReshare,
  });

  final ExportEventEntity event;
  final bool isExpired;
  final VoidCallback onReshare;

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.filename, style: TextStyle(color: colors.foreground, fontSize: 13)),
                Text(
                  '${event.format.toUpperCase()} · ${event.occurredAt}',
                  style: TextStyle(color: colors.mutedForeground, fontSize: 11),
                ),
              ],
            ),
          ),
          if (isExpired)
            Text('Expired', style: TextStyle(color: colors.mutedForeground, fontSize: 11))
          else
            ShadButton.outline(onPressed: onReshare, child: const Text('Re-share')),
        ],
      ),
    );
  }
}
