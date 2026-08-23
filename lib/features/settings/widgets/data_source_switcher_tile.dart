import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/services/environment_service.dart';

/// Debug-only "Local vs Cloud" data-source toggle (Issue #264/#265) —
/// flat shadcn_ui replacement for the legacy `OmniGlassPanel`/`AdaptiveText`
/// block this used to be.
class DataSourceSwitcherTile extends StatelessWidget {
  const DataSourceSwitcherTile({super.key});

  @override
  Widget build(BuildContext context) {
    final env = Get.find<EnvironmentService>();
    final colors = ShadTheme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
      child: Obx(() => ShadSwitch(
            value: env.isRemoteEnabled.value,
            onChanged: env.toggleDataSource,
            label: Text('Remote Access', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
            sublabel: Text('Toggle between Local ObjectBox and Cloud API',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
          )),
    );
  }
}
