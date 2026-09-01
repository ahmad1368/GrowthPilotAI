import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The module/route fields and enabled switch for a new logged feature
/// module toggle (Issue #339).
class FeatureToggleFields extends StatelessWidget {
  final TextEditingController moduleNameController;
  final TextEditingController routeNameController;
  final bool isEnabled;
  final ValueChanged<bool> onEnabledChanged;

  const FeatureToggleFields({
    super.key,
    required this.moduleNameController,
    required this.routeNameController,
    required this.isEnabled,
    required this.onEnabledChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Module name (e.g. Integrations)'),
            controller: moduleNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Gated route (e.g. /settings/integrations)'),
            controller: routeNameController),
        const SizedBox(height: 8),
        ShadSwitch(
          value: isEnabled,
          label: const Text('Module enabled'),
          onChanged: onEnabledChanged,
        ),
      ],
    );
  }
}
