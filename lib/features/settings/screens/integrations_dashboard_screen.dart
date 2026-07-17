import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/accounting_integrations_controller.dart';
import 'package:growth_pilot_ai/core/theme/mapping_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/disconnect_confirm_dialog.dart';
import 'package:growth_pilot_ai/features/settings/widgets/integration_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Integrations Dashboard (Issue #61): status, last-synced time, and
/// Connect/Disconnect/Refresh controls for Plaid, QuickBooks, and Xero.
class IntegrationsDashboardScreen extends StatelessWidget {
  const IntegrationsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final controller = Get.find<AccountingIntegrationsController>();

    return ShadTheme(
      data: MappingShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Accounting & Banking')),
        body: Obx(() => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.connections.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entity = controller.connections[index];
                return IntegrationTile(
                  entity: entity,
                  isBusy: controller.busyProviderId.value == entity.providerId,
                  onConnect: () => controller.connect(entity.providerId),
                  onDisconnect: () => _confirmAndDisconnect(context, controller, entity.providerId,
                      entity.providerLabel),
                );
              },
            )),
      ),
    );
  }

  Future<void> _confirmAndDisconnect(BuildContext context,
      AccountingIntegrationsController controller, String providerId, String providerLabel) async {
    final confirmed = await showDisconnectConfirmDialog(
      context,
      providerLabel: providerLabel,
      willClearMappingRules: providerId != 'plaid',
    );
    if (confirmed) controller.disconnect(providerId);
  }
}
