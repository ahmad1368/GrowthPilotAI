import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/vancouver_neighborhood.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Neighborhood checklist, message body, and recipient count fields for
/// a new emergency broadcast (Issue #345, acceptance criteria 1-2).
class EmergencyBroadcastFields extends StatelessWidget {
  final Set<VancouverNeighborhood> selectedNeighborhoods;
  final ValueChanged<VancouverNeighborhood> onToggleNeighborhood;
  final TextEditingController messageController;
  final TextEditingController recipientCountController;

  const EmergencyBroadcastFields({
    super.key,
    required this.selectedNeighborhoods,
    required this.onToggleNeighborhood,
    required this.messageController,
    required this.recipientCountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 4, runSpacing: 4, children: [
          for (final n in VancouverNeighborhood.values)
            ShadCheckbox(
              value: selectedNeighborhoods.contains(n),
              onChanged: (_) => onToggleNeighborhood(n),
              label: Text(n.name),
            ),
        ]),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Urgent message'), controller: messageController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Merchants notified'),
            controller: recipientCountController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
