import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/performance_controller.dart';
import 'package:growth_pilot_ai/core/enum/performance_tier.dart';

/// "Power Saver Mode" toggle (Issue #110's "User Control" constraint) —
/// flat row, no Glassmorphism, matching [LanguageSettingsSection]'s
/// (#429) plain-container precedent rather than the legacy OmniGlassPanel
/// used elsewhere in this screen.
class PerformanceSettingsSection extends StatelessWidget {
  const PerformanceSettingsSection({super.key});

  String _tierLabel(PerformanceTier tier) => switch (tier) {
        PerformanceTier.low => 'Low-end device detected',
        PerformanceTier.mid => 'Standard device',
        PerformanceTier.high => 'High-end device',
      };

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PerformanceController>();
    final theme = Theme.of(context);

    return Obx(() => ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Icon(Icons.battery_saver_rounded, color: theme.colorScheme.onSurface),
          title: const Text('Power Saver Mode', style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
            '${_tierLabel(controller.tier.value)} — throttles background sync to save battery',
            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
          ),
          trailing: Switch(
            value: controller.powerSaverEnabled.value,
            onChanged: controller.togglePowerSaver,
          ),
        ));
  }
}
