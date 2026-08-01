import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The target/destination/redirect-count fields for a new logged
/// traffic-steering directive (Issue #334).
class TrafficSteeringFields extends StatelessWidget {
  final TextEditingController targetNameController;
  final TextEditingController destinationLabelController;
  final TextEditingController redirectCountController;

  const TrafficSteeringFields({
    super.key,
    required this.targetNameController,
    required this.destinationLabelController,
    required this.redirectCountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Merchant or user name'),
            controller: targetNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Destination (category, marketplace, etc.)'),
            controller: destinationLabelController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Redirect count'),
            controller: redirectCountController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
