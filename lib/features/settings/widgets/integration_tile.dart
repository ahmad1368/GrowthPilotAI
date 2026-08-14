import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';
import 'package:growth_pilot_ai/features/settings/widgets/integration_status_chip.dart';
import 'package:growth_pilot_ai/features/settings/widgets/integration_tile_actions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One provider row on the Integrations Dashboard (Issue #61): status chip,
/// last-synced subtitle, and Connect/Reconnect/Refresh + Disconnect actions.
class IntegrationTile extends StatelessWidget {
  final IntegrationConnectionEntity entity;
  final bool isBusy;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  const IntegrationTile({
    super.key,
    required this.entity,
    required this.isBusy,
    required this.onConnect,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final status = DashboardConnectionStatus.values[entity.dbStatus];
    final displayStatus =
        isBusy ? DashboardConnectionStatus.syncing : status;

    return ShadCard(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(entity.providerLabel)),
          const SizedBox(width: 8),
          IntegrationStatusChip(status: displayStatus),
        ],
      ),
      description: Text(entity.accountLabel != null
          ? '${entity.accountLabel} · synced ${_lastSynced(entity.lastSyncedAt)}'
          : 'Not connected yet'),
      footer: IntegrationTileActions(
        status: status,
        isBusy: isBusy,
        onConnect: onConnect,
        onDisconnect: onDisconnect,
      ),
    );
  }

  static String _lastSynced(DateTime? at) {
    if (at == null) return 'never';
    final minutes = DateTime.now().difference(at).inMinutes;
    if (minutes < 1) return 'just now';
    if (minutes < 60) return '$minutes min ago';
    return '${(minutes / 60).floor()}h ago';
  }
}
