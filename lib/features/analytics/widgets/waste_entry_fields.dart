import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The 3 input fields for a waste-log entry (Issue #377): description,
/// estimated loss, and a reason picker.
class WasteEntryFields extends StatelessWidget {
  final TextEditingController descriptionController;
  final TextEditingController valueController;
  final WasteReason reason;
  final ValueChanged<WasteReason> onReasonChanged;

  const WasteEntryFields({
    super.key,
    required this.descriptionController,
    required this.valueController,
    required this.reason,
    required this.onReasonChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Item description'),
            controller: descriptionController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Estimated loss (\$)'),
            controller: valueController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadSelect<WasteReason>(
          initialValue: reason,
          options: WasteReason.values
              .map((r) => ShadOption(value: r, child: Text(r.name)))
              .toList(),
          selectedOptionBuilder: (context, value) => Text(value.name),
          onChanged: (value) {
            if (value != null) onReasonChanged(value);
          },
        ),
      ],
    );
  }
}
