import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/quiet_hours_controller.dart';

/// Daily alert cap stepper (Issue #159 AC: "Users do not receive more
/// than the Max Daily Alerts allowed for non-critical categories").
class MaxDailyAlertsTile extends StatelessWidget {
  const MaxDailyAlertsTile({super.key});

  static const _min = 1;
  static const _max = 20;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuietHoursController>();
    final theme = Theme.of(context);
    final current = controller.settings.value.maxDailyAlerts;

    void setValue(int next) {
      if (next < _min || next > _max) return;
      controller.updateSettings(controller.settings.value.copyWith(maxDailyAlerts: next));
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text('Max Daily Alerts', style: TextStyle(color: theme.colorScheme.onSurface)),
      subtitle: Text('$current per day',
          style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => setValue(current - 1)),
        IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => setValue(current + 1)),
      ]),
    );
  }
}
