import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The feature/center/radius fields and enabled switch for a new
/// geofence zone (Issue #346, acceptance criterion 1).
class GeofenceZoneFields extends StatelessWidget {
  final TextEditingController featureNameController;
  final TextEditingController centerLatController;
  final TextEditingController centerLngController;
  final TextEditingController radiusKmController;
  final bool isEnabled;
  final ValueChanged<bool> onEnabledChanged;

  const GeofenceZoneFields({
    super.key,
    required this.featureNameController,
    required this.centerLatController,
    required this.centerLngController,
    required this.radiusKmController,
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
            placeholder: const Text('Feature (e.g. Marketplace)'),
            controller: featureNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Center latitude'),
            controller: centerLatController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Center longitude'),
            controller: centerLngController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Radius (km)'),
            controller: radiusKmController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadSwitch(
          value: isEnabled,
          label: const Text('Zone enabled'),
          onChanged: onEnabledChanged,
        ),
      ],
    );
  }
}
