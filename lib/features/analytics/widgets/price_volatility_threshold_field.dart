import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Editable breach threshold percentage input (Issue #340, acceptance
/// criterion 1), saved immediately on change.
class PriceVolatilityThresholdField extends StatefulWidget {
  final double thresholdPercent;
  final ValueChanged<double> onSaved;

  const PriceVolatilityThresholdField(
      {super.key, required this.thresholdPercent, required this.onSaved});

  @override
  State<PriceVolatilityThresholdField> createState() =>
      _PriceVolatilityThresholdFieldState();
}

class _PriceVolatilityThresholdFieldState
    extends State<PriceVolatilityThresholdField> {
  late final _controller =
      TextEditingController(text: widget.thresholdPercent.toString());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Alert threshold:'),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: ShadInput(controller: _controller, keyboardType: TextInputType.number),
        ),
        const SizedBox(width: 8),
        ShadButton.outline(
          onPressed: () {
            final value = double.tryParse(_controller.text);
            if (value != null && value >= 0) widget.onSaved(value);
          },
          child: const Text('Save %'),
        ),
      ],
    );
  }
}
