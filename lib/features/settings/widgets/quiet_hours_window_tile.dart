import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/quiet_hours_controller.dart';

/// Start/end time pickers for the Quiet Hours window (Issue #159) —
/// stored as minutes-since-midnight on [QuietHoursController].
class QuietHoursWindowTile extends StatelessWidget {
  const QuietHoursWindowTile({super.key});

  TimeOfDay _toTimeOfDay(int minutes) => TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);

  Future<void> _pick(BuildContext context, QuietHoursController controller, {required bool isStart}) async {
    final settings = controller.settings.value;
    final initial = _toTimeOfDay(isStart ? settings.quietStartMinutes : settings.quietEndMinutes);
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    final minutes = picked.hour * 60 + picked.minute;
    await controller.updateSettings(isStart
        ? settings.copyWith(quietStartMinutes: minutes)
        : settings.copyWith(quietEndMinutes: minutes));
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuietHoursController>();
    final theme = Theme.of(context);
    final settings = controller.settings.value;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text('Quiet Window', style: TextStyle(color: theme.colorScheme.onSurface)),
      subtitle: Text(
        '${_toTimeOfDay(settings.quietStartMinutes).format(context)} – '
        '${_toTimeOfDay(settings.quietEndMinutes).format(context)}',
        style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
      ),
      trailing: Wrap(spacing: 4, children: [
        TextButton(onPressed: () => _pick(context, controller, isStart: true), child: const Text('Start')),
        TextButton(onPressed: () => _pick(context, controller, isStart: false), child: const Text('End')),
      ]),
    );
  }
}
