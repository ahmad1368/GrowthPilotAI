import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Requested cap amount and reason fields for a new cap expansion
/// request (Issue #344, acceptance criterion 3).
class CapExpansionRequestFields extends StatelessWidget {
  final TextEditingController requestedCapController;
  final TextEditingController reasonController;

  const CapExpansionRequestFields({
    super.key,
    required this.requestedCapController,
    required this.reasonController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Requested daily cap (\$)'),
            controller: requestedCapController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Reason for the increase'),
            controller: reasonController),
      ],
    );
  }
}
