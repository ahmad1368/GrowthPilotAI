import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One row in the security-audit-log viewer (Issue #186) — flat, no
/// Glassmorphism.
class SecurityAuditLogRow extends StatelessWidget {
  final SecurityAuditLogEntity entry;

  const SecurityAuditLogRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final isFailure = entry.status == SecurityAuditStatus.failure;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.actionType.name,
                    style: TextStyle(color: colors.foreground, fontSize: 13)),
                Text('${entry.occurredAt} · ${entry.platform}',
                    style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
                if (entry.metadata != null)
                  Text(entry.metadata!,
                      style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
              ],
            ),
          ),
          Text(isFailure ? 'Failure' : 'Success',
              style: TextStyle(
                  color: isFailure ? Colors.red : Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
