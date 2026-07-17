import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Connect/Reconnect/Refresh + Disconnect action row for one
/// [IntegrationTile] (Issue #61).
class IntegrationTileActions extends StatelessWidget {
  final DashboardConnectionStatus status;
  final bool isBusy;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  const IntegrationTileActions({
    super.key,
    required this.status,
    required this.isBusy,
    required this.onConnect,
    required this.onDisconnect,
  });

  @override
  Widget build(BuildContext context) {
    final isConnected = status == DashboardConnectionStatus.connected;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isConnected)
          ShadButton.outline(
            enabled: !isBusy,
            onPressed: onDisconnect,
            child: const Text('Disconnect'),
          ),
        const SizedBox(width: 8),
        ShadButton(
          enabled: !isBusy,
          leading: isBusy
              ? const SizedBox(
                  width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
              : null,
          onPressed: onConnect,
          child: Text(isBusy
              ? 'Syncing...'
              : isConnected
                  ? 'Refresh'
                  : status == DashboardConnectionStatus.expired
                      ? 'Reconnect'
                      : 'Connect'),
        ),
      ],
    );
  }
}
