import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Module/merchant fields, duration presets, and the value-exchange
/// disclosure text shown before the simulated ad plays (Issue #405,
/// acceptance criterion 3).
class RewardedUnlockFields extends StatelessWidget {
  final TextEditingController moduleNameController;
  final TextEditingController merchantNameController;
  final int selectedDurationMinutes;
  final ValueChanged<int> onDurationChanged;

  const RewardedUnlockFields({
    super.key,
    required this.moduleNameController,
    required this.merchantNameController,
    required this.selectedDurationMinutes,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Locked module (e.g. Analytics)'),
            controller: moduleNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Merchant name'),
            controller: merchantNameController),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          for (final minutes in const [15, 60])
            if (selectedDurationMinutes == minutes)
              ShadButton(
                  onPressed: () => onDurationChanged(minutes),
                  child: Text('$minutes min'))
            else
              ShadButton.outline(
                  onPressed: () => onDurationChanged(minutes),
                  child: Text('$minutes min')),
        ]),
        const SizedBox(height: 8),
        Text(
            'Watch a short sponsored message to unlock this module for '
            '$selectedDurationMinutes minute(s).',
            style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
