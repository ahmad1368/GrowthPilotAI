import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Color-coded connection badge for the Integrations Dashboard (Issue #61).
/// Always pairs color with an icon/label so status reads for color-blind
/// users, matching [MappingStatusChip]'s convention (Issue #58).
class IntegrationStatusChip extends StatelessWidget {
  final DashboardConnectionStatus status;

  const IntegrationStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, icon, label) = switch (status) {
      DashboardConnectionStatus.connected => (
          Colors.green,
          Icons.check_circle_outline_rounded,
          'Active'
        ),
      DashboardConnectionStatus.expired => (
          Colors.red,
          Icons.error_outline_rounded,
          'Action Required'
        ),
      DashboardConnectionStatus.syncing => (
          Colors.blue,
          Icons.sync_rounded,
          'Syncing'
        ),
      DashboardConnectionStatus.notConnected => (
          Colors.grey,
          Icons.radio_button_unchecked_rounded,
          'Not Connected'
        ),
    };

    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: color.withValues(alpha: 0.12),
      foregroundColor: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
