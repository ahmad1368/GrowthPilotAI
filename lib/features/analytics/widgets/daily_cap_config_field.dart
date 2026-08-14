import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Editable daily transaction cap amount input (Issue #344, acceptance
/// criterion 1), saved immediately on change.
class DailyCapConfigField extends StatefulWidget {
  final double capAmount;
  final ValueChanged<double> onSaved;

  const DailyCapConfigField({super.key, required this.capAmount, required this.onSaved});

  @override
  State<DailyCapConfigField> createState() => _DailyCapConfigFieldState();
}

class _DailyCapConfigFieldState extends State<DailyCapConfigField> {
  late final _controller = TextEditingController(text: widget.capAmount.toString());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Daily cap (\$):'),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: ShadInput(controller: _controller, keyboardType: TextInputType.number),
        ),
        const SizedBox(width: 8),
        ShadButton.outline(
          onPressed: () {
            final value = double.tryParse(_controller.text);
            if (value != null && value >= 0) widget.onSaved(value);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
