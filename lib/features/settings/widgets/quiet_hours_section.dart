import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/quiet_hours_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/max_daily_alerts_tile.dart';
import 'package:growth_pilot_ai/features/settings/widgets/quiet_hours_window_tile.dart';

/// "Quiet Hours & Frequency Capping" settings (Issue #159) — lets a user
/// silence non-transactional alerts overnight and cap how many they get
/// per day, mirroring the issue's own "stop after 10PM, max 5/day" story.
class QuietHoursSection extends StatelessWidget {
  const QuietHoursSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuietHoursController>();
    final theme = Theme.of(context);

    return Obx(() => Column(
          children: [
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text('Quiet Hours', style: TextStyle(color: theme.colorScheme.onSurface)),
              subtitle: Text('Silence non-order alerts overnight',
                  style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              value: controller.settings.value.enabled,
              onChanged: (enabled) =>
                  controller.updateSettings(controller.settings.value.copyWith(enabled: enabled)),
            ),
            const QuietHoursWindowTile(),
            const MaxDailyAlertsTile(),
          ],
        ));
  }
}
