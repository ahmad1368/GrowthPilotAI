import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/security_audit_log_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/security_audit_log_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Security Audit Logs" viewer (Issue #186) — a chronological,
/// read-only record of sensitive actions on this device.
class SecurityAuditLogViewer extends StatelessWidget {
  final SecurityAuditLogController controller;

  const SecurityAuditLogViewer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (controller.visibleLogs.isEmpty) {
        return Text('No security events recorded yet.',
            style: TextStyle(color: colors.mutedForeground, fontSize: 12));
      }
      return Column(
        children: [for (final log in controller.visibleLogs) SecurityAuditLogRow(entry: log)],
      );
    });
  }
}
