import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// FIFO/LIFO/weighted-average accounting-method picker (Issue #446).
class InventoryValuationMethodSelect extends StatelessWidget {
  final ValuationMethod method;
  final ValueChanged<ValuationMethod?> onChanged;

  const InventoryValuationMethodSelect({super.key, required this.method, required this.onChanged});

  static String _label(ValuationMethod m) => switch (m) {
        ValuationMethod.fifo => 'FIFO',
        ValuationMethod.lifo => 'LIFO',
        ValuationMethod.weightedAverage => 'Weighted Average',
      };

  @override
  Widget build(BuildContext context) {
    return ShadSelect<ValuationMethod>(
      initialValue: method,
      placeholder: const Text('Accounting method'),
      options: [
        for (final m in ValuationMethod.values) ShadOption(value: m, child: Text(_label(m)))
      ],
      selectedOptionBuilder: (context, value) => Text(_label(value)),
      onChanged: onChanged,
    );
  }
}
