import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inventory_turnover_and_aging_snapshot.dart';

/// One item's row in the turnover-and-aging list (Issue #447).
class InventoryTurnoverAgingRow extends StatelessWidget {
  final InventoryTurnoverAndAgingSnapshot snapshot;

  const InventoryTurnoverAgingRow({super.key, required this.snapshot});

  Color _statusColor(ColorScheme scheme) => switch (snapshot.statusLabel) {
        'Needs review' => scheme.error,
        'Fast moving' => scheme.primary,
        _ => scheme.onSurface,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(snapshot.item.name, overflow: TextOverflow.ellipsis)),
          Text('${snapshot.agingDays}d aging',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text('${snapshot.turnoverRatio.toStringAsFixed(2)}x'),
          const SizedBox(width: 8),
          Text(snapshot.statusLabel,
              style: TextStyle(fontSize: 11, color: _statusColor(scheme))),
        ],
      ),
    );
  }
}
