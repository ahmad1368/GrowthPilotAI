import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';

/// One read-only audit trail entry (Issue #343, acceptance criterion
/// 3) — purely a display row, no edit/delete affordance.
class AuditTrailRow extends StatelessWidget {
  final AuditLogEntity entry;

  const AuditTrailRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text('${entry.adminId} — ${entry.changeType} on ${entry.targetMerchant}',
                      overflow: TextOverflow.ellipsis)),
              Text(entry.timestamp.toString(),
                  style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
            ],
          ),
          if (entry.previousValue.isNotEmpty || entry.newValue.isNotEmpty)
            Text('${entry.previousValue} → ${entry.newValue}',
                style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.7))),
        ],
      ),
    );
  }
}
