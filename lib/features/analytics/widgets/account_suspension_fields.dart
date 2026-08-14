import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The merchant/reason fields and duration preset buttons for a new
/// account suspension (Issue #341, acceptance criterion 1).
class AccountSuspensionFields extends StatelessWidget {
  final TextEditingController merchantNameController;
  final TextEditingController reasonController;
  final int selectedDurationHours;
  final ValueChanged<int> onDurationChanged;

  const AccountSuspensionFields({
    super.key,
    required this.merchantNameController,
    required this.reasonController,
    required this.selectedDurationHours,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Merchant name'),
            controller: merchantNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Reason'), controller: reasonController),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          for (final hours in const [24, 24 * 7])
            if (selectedDurationHours == hours)
              ShadButton(
                onPressed: () => onDurationChanged(hours),
                child: Text(hours == 24 ? '24 hours' : '7 days'),
              )
            else
              ShadButton.outline(
                onPressed: () => onDurationChanged(hours),
                child: Text(hours == 24 ? '24 hours' : '7 days'),
              ),
        ]),
      ],
    );
  }
}
